import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../core/services/location_service.dart';
import '../core/services/earthquake_service.dart';
import '../core/services/risk_engine.dart';
import '../core/services/notification_service.dart';
import '../core/utils/geo_utils.dart';
import '../models/earthquake_model.dart';
import '../models/user_settings_model.dart';

class DisasterProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  final EarthquakeService _earthquakeService = EarthquakeService();

  // State variables
  Position? _position;
  Earthquake? _earthquake;
  String _riskStatus = "MEMUAT...";
  Color _riskColor = Colors.grey;
  IconData _riskIcon = Icons.hourglass_empty;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  Position? get position => _position;
  Earthquake? get earthquake => _earthquake;
  String get riskStatus => _riskStatus;
  Color get riskColor => _riskColor;
  IconData get riskIcon => _riskIcon;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  double get distance {
    if (_position == null || _earthquake == null) return 0.0;
    return calculateDistance(
      _position!.latitude,
      _position!.longitude,
      _earthquake!.latitude,
      _earthquake!.longitude,
    );
  }

  Future<void> loadData() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      print('Loading location and earthquake data...');
      
      // Get location
      final position = await _locationService.getCurrentLocation();
      print('Got position: ${position.latitude}, ${position.longitude}');
      
      // Get earthquake data from BMKG
      final earthquake = await _earthquakeService.getLatestEarthquake();
      print('Got earthquake: $earthquake');
      
      _position = position;
      _earthquake = earthquake;
      
      // Calculate risk if both data available
      if (position != null && earthquake != null) {
        print('Calculating risk...');
        _calculateRisk();
      } else {
        _riskStatus = earthquake == null ? "DATA GEMPA TIDAK TERSEDIA" : "LOKASI TIDAK TERSEDIA";
        _riskColor = Colors.grey;
        _riskIcon = Icons.error;
      }
    } catch (e) {
      print('Error loading data: $e');
      _errorMessage = e.toString();
      _riskStatus = "ERROR: $e";
      _riskColor = Colors.red;
      _riskIcon = Icons.error;
    } finally {
      _setLoading(false);
    }
  }

  void _calculateRisk({UserSettings? settings}) {
    if (_position == null || _earthquake == null) return;
    
    final distance = calculateDistance(
      _position!.latitude,
      _position!.longitude,
      _earthquake!.latitude,
      _earthquake!.longitude,
    );
    
    print('Calculating risk: magnitude=${_earthquake!.magnitude}, depth=${_earthquake!.depth}, distance=${distance.toStringAsFixed(1)}km');
    
    // Check user settings for alert radius and minimum magnitude
    if (settings != null) {
      if (distance > settings.alertRadius) {
        _riskStatus = "AMAN (Di Luar Zona Alert)";
        _riskColor = Colors.green;
        _riskIcon = Icons.check_circle;
        return;
      }
      
      if (_earthquake!.magnitude < settings.minMagnitudeAlert) {
        _riskStatus = "AMAN (Magnitudo Rendah)";
        _riskColor = Colors.green;
        _riskIcon = Icons.check_circle;
        return;
      }
    }
    
    final risk = RiskEngine.calculateRisk(
      magnitude: _earthquake!.magnitude,
      depth: _earthquake!.depth,
      distance: distance,
    );
    
    print('Risk result: $risk');
    
    _riskStatus = "$risk (Analisis Sistem)";
    
    switch (risk) {
      case "BAHAYA":
        _riskColor = Colors.red;
        _riskIcon = Icons.dangerous;
        if (settings == null || settings.enableEarthquakeAlert) {
          _sendAutoAlert(risk, distance);
        }
        break;
      case "WASPADA":
        _riskColor = Colors.orange;
        _riskIcon = Icons.warning;
        if (settings == null || settings.enableEarthquakeAlert) {
          _sendAutoAlert(risk, distance);
        }
        break;
      case "AMAN":
        _riskColor = Colors.green;
        _riskIcon = Icons.check_circle;
        break;
    }
    
    print('UI updated with status: $_riskStatus');
  }

  void _sendAutoAlert(String riskLevel, double distance) {
    try {
      String title = riskLevel == "BAHAYA" 
          ? '🚨 PERINGATAN BAHAYA GEMPA!' 
          : '⚠️ PERINGATAN WASPADA GEMPA';
      
      String body = 'Gempa ${_earthquake!.magnitude} SR terdeteksi ${distance.toStringAsFixed(0)} km dari lokasi Anda. '
          '${riskLevel == "BAHAYA" ? "Segera cari tempat aman!" : "Tetap waspada dan siap evakuasi."}';
      
      NotificationService.showEmergencyAlert(
        title: title,
        body: body,
        riskLevel: riskLevel,
      );
      print('Auto alert sent: $riskLevel');
    } catch (e) {
      print('Failed to send auto alert: $e');
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void simulateAlert() {
    // Trigger notification simulation
    print('Alert simulation triggered');
    try {
      NotificationService.simulateEarthquakeAlert();
    } catch (e) {
      print('Notification failed: $e');
    }
  }
}