import 'package:dio/dio.dart';
import '../../models/earthquake_model.dart';

class EarthquakeService {
  final Dio _dio = Dio();

  Future<Earthquake?> getLatestEarthquake() async {
    try {
      print('Fetching earthquake data from BMKG...');
      final response = await _dio.get(
        "https://data.bmkg.go.id/DataMKG/TEWS/autogempa.json",
      );
      
      print('Response status: ${response.statusCode}');
      
      if (response.data != null) {
        final earthquake = Earthquake.fromJson(response.data);
        print('Parsed earthquake: ${earthquake.magnitude} - ${earthquake.region}');
        return earthquake;
      }
      return null;
    } catch (e) {
      print('Error fetching earthquake data: $e');
      return null;
    }
  }
}