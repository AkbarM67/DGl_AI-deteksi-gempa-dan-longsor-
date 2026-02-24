import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../providers/disaster_provider.dart';

class EarthquakeMapPage extends StatefulWidget {
  const EarthquakeMapPage({super.key});

  @override
  State<EarthquakeMapPage> createState() => _EarthquakeMapPageState();
}

class _EarthquakeMapPageState extends State<EarthquakeMapPage> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Circle> _circles = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Gempa Bumi'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Consumer<DisasterProvider>(
        builder: (context, provider, child) {
          if (provider.position == null || provider.earthquake == null) {
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
              zoom: 8,
            ),
            markers: _markers,
            circles: _circles,
            onMapCreated: (controller) {
              _mapController = controller;
              _fitBounds(provider);
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          );
        },
      ),
    );
  }

  void _updateMarkers(DisasterProvider provider) {
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
          snippet: '${provider.position!.latitude.toStringAsFixed(4)}, ${provider.position!.longitude.toStringAsFixed(4)}',
        ),
      ),
    );

    // Marker episentrum gempa
    _markers.add(
      Marker(
        markerId: const MarkerId('earthquake'),
        position: LatLng(
          provider.earthquake!.latitude,
          provider.earthquake!.longitude,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: 'Episentrum Gempa',
          snippet: '${provider.earthquake!.magnitude} SR - ${provider.earthquake!.region}',
        ),
      ),
    );

    // Circle radius bahaya berdasarkan magnitude
    Color circleColor;
    double radius;
    
    if (provider.riskStatus.contains('BAHAYA')) {
      circleColor = Colors.red;
      radius = 100000; // 100 km
    } else if (provider.riskStatus.contains('WASPADA')) {
      circleColor = Colors.orange;
      radius = 150000; // 150 km
    } else {
      circleColor = Colors.green;
      radius = 200000; // 200 km
    }

    _circles.add(
      Circle(
        circleId: const CircleId('danger_zone'),
        center: LatLng(
          provider.earthquake!.latitude,
          provider.earthquake!.longitude,
        ),
        radius: radius,
        fillColor: circleColor.withOpacity(0.2),
        strokeColor: circleColor,
        strokeWidth: 2,
      ),
    );
  }

  void _fitBounds(DisasterProvider provider) {
    if (_mapController == null) return;

    final bounds = LatLngBounds(
      southwest: LatLng(
        provider.position!.latitude < provider.earthquake!.latitude
            ? provider.position!.latitude
            : provider.earthquake!.latitude,
        provider.position!.longitude < provider.earthquake!.longitude
            ? provider.position!.longitude
            : provider.earthquake!.longitude,
      ),
      northeast: LatLng(
        provider.position!.latitude > provider.earthquake!.latitude
            ? provider.position!.latitude
            : provider.earthquake!.latitude,
        provider.position!.longitude > provider.earthquake!.longitude
            ? provider.position!.longitude
            : provider.earthquake!.longitude,
      ),
    );

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 100),
    );
  }
}
