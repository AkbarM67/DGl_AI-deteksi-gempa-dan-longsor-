import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../providers/landslide_provider.dart';

class LandslideMapPage extends StatefulWidget {
  const LandslideMapPage({super.key});

  @override
  State<LandslideMapPage> createState() => _LandslideMapPageState();
}

class _LandslideMapPageState extends State<LandslideMapPage> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Circle> _circles = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Potensi Longsor'),
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
      ),
      body: Consumer<LandslideProvider>(
        builder: (context, provider, child) {
          if (provider.position == null || provider.landslideData == null) {
            return const Center(
              child: Text('Data tidak tersedia'),
            );
          }

          _updateMarkers(provider);

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                provider.position!.latitude,
                provider.position!.longitude,
              ),
              zoom: 12,
            ),
            markers: _markers,
            circles: _circles,
            onMapCreated: (controller) {
              _mapController = controller;
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          );
        },
      ),
    );
  }

  void _updateMarkers(LandslideProvider provider) {
    _markers.clear();
    _circles.clear();

    // Marker lokasi user
    _markers.add(
      Marker(
        markerId: const MarkerId('user_location'),
        position: LatLng(
          provider.position!.latitude,
          provider.position!.longitude,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(
          title: 'Lokasi Anda',
          snippet: 'Curah Hujan: ${provider.landslideData!.rainfall.toStringAsFixed(1)} mm',
        ),
      ),
    );

    // Circle area potensi longsor
    Color circleColor;
    double radius;
    
    if (provider.riskStatus.contains('BAHAYA')) {
      circleColor = Colors.red;
      radius = 5000; // 5 km
    } else if (provider.riskStatus.contains('WASPADA')) {
      circleColor = Colors.orange;
      radius = 10000; // 10 km
    } else {
      circleColor = Colors.green;
      radius = 15000; // 15 km
    }

    _circles.add(
      Circle(
        circleId: const CircleId('landslide_zone'),
        center: LatLng(
          provider.position!.latitude,
          provider.position!.longitude,
        ),
        radius: radius,
        fillColor: circleColor.withOpacity(0.3),
        strokeColor: circleColor,
        strokeWidth: 2,
      ),
    );
  }
}
