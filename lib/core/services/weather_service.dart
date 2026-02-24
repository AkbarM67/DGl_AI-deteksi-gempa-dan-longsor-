import 'package:dio/dio.dart';

class WeatherService {
  final Dio _dio = Dio();

  // Open-Meteo API (free, no API key needed)
  Future<double> getRainfall(double lat, double lon) async {
    try {
      print('Fetching rainfall data for: $lat, $lon');
      final response = await _dio.get(
        'https://api.open-meteo.com/v1/forecast',
        queryParameters: {
          'latitude': lat,
          'longitude': lon,
          'daily': 'precipitation_sum',
          'timezone': 'Asia/Jakarta',
          'forecast_days': 1,
        },
      );

      if (response.data != null && response.data['daily'] != null) {
        final precipitation = response.data['daily']['precipitation_sum'][0];
        print('Rainfall: $precipitation mm');
        return (precipitation ?? 0).toDouble();
      }
      return 0.0;
    } catch (e) {
      print('Error fetching rainfall: $e');
      return 0.0;
    }
  }

  // Simulasi data slope berdasarkan lokasi (Indonesia bagian tengah lebih berbukit)
  double estimateSlope(double lat, double lon) {
    // Area pegunungan di Indonesia (Jawa Barat, Sumatra, Papua)
    if ((lat >= -7.0 && lat <= -6.5 && lon >= 106.5 && lon <= 108.0) || // Jawa Barat
        (lat >= -3.0 && lat <= 2.0 && lon >= 95.0 && lon <= 106.0) ||   // Sumatra
        (lat >= -5.0 && lat <= -2.0 && lon >= 133.0 && lon <= 141.0)) { // Papua
      return 25.0 + (lat.abs() * 2); // Slope tinggi
    }
    return 10.0; // Slope rendah untuk area datar
  }

  String estimateSoilType(double lat, double lon) {
    // Simplified soil type estimation
    if (lat >= -7.0 && lat <= -6.0) {
      return 'Tanah Liat'; // Clay - rawan longsor
    } else if (lat >= -3.0 && lat <= 0.0) {
      return 'Tanah Gambut'; // Peat - sangat rawan
    }
    return 'Tanah Lempung'; // Loam - sedang
  }
}
