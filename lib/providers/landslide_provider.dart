import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../core/services/location_service.dart';
import '../core/services/weather_service.dart';
import '../core/services/landslide_risk_engine.dart';
import '../core/services/notification_service.dart';
import '../models/landslide_model.dart';

class LandslideProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();

  Position? _position;
  Landslide? _landslideData;
  String _riskStatus = "MEMUAT...";
  Color _riskColor = Colors.grey;
  IconData _riskIcon = Icons.hourglass_empty;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  Position? get position => _position;
  Landslide? get landslideData => _landslideData;
  String get riskStatus => _riskStatus;
  Color get riskColor => _riskColor;
  IconData get riskIcon => _riskIcon;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  double get rainfall => _landslideData?.rainfall ?? 0.0;
  double get slope => _landslideData?.slope ?? 0.0;
  String get soilType => _landslideData?.soilType ?? 'N/A';

  Future<void> loadData() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      print('Loading location and weather data...');
      
      // Get location
      final position = await _locationService.getCurrentLocation();
      print('Got position: ${position.latitude}, ${position.longitude}');
      
      // Get weather data
      final rainfall = await _weatherService.getRainfall(
        position.latitude,
        position.longitude,
      );
      
      final slope = _weatherService.estimateSlope(
        position.latitude,
        position.longitude,
      );
      
      final soilType = _weatherService.estimateSoilType(
        position.latitude,
        position.longitude,
      );
      
      _position = position;
      _landslideData = Landslide(
        location: 'Lokasi Anda',
        latitude: position.latitude,
        longitude: position.longitude,
        rainfall: rainfall,
        slope: slope,
        soilType: soilType,
        timestamp: DateTime.now(),
      );
      
      print('Calculating landslide risk...');
      _calculateRisk();
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

  void _calculateRisk() {
    if (_position == null || _landslideData == null) return;
    
    // Distance dari area rawan (simplified - anggap user di area rawan)
    final distance = 5.0; // km (bisa dikembangkan dengan data area rawan real)
    
    print('Calculating risk: rainfall=${_landslideData!.rainfall}, slope=${_landslideData!.slope}, soil=${_landslideData!.soilType}');
    
    final risk = LandslideRiskEngine.calculateRisk(
      rainfall: _landslideData!.rainfall,
      slope: _landslideData!.slope,
      soilType: _landslideData!.soilType,
      distance: distance,
    );
    
    print('Risk result: $risk');
    
    _riskStatus = "$risk (Analisis Sistem)";
    
    switch (risk) {
      case "BAHAYA":
        _riskColor = Colors.red;
        _riskIcon = Icons.landslide;
        _sendAutoAlert(risk);
        break;
      case "WASPADA":
        _riskColor = Colors.orange;
        _riskIcon = Icons.warning;
        _sendAutoAlert(risk);
        break;
      case "AMAN":
        _riskColor = Colors.green;
        _riskIcon = Icons.check_circle;
        break;
    }
    
    print('UI updated with status: $_riskStatus');
  }

  void _sendAutoAlert(String riskLevel) {
    try {
      String title = riskLevel == "BAHAYA" 
          ? '🚨 PERINGATAN BAHAYA LONGSOR!' 
          : '⚠️ PERINGATAN WASPADA LONGSOR';
      
      String body = LandslideRiskEngine.getRiskDescription(
        riskLevel,
        _landslideData!.rainfall,
        _landslideData!.slope,
      );
      
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
    print('Landslide alert simulation triggered');
    try {
      NotificationService.showEmergencyAlert(
        title: '🚨 SIMULASI PERINGATAN LONGSOR',
        body: 'Curah hujan tinggi terdeteksi di area Anda. Waspada potensi longsor!',
        riskLevel: 'WASPADA',
      );
    } catch (e) {
      print('Notification failed: $e');
    }
  }
}
