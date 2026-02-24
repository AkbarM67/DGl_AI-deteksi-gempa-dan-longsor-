import '../../models/earthquake_model.dart';

class DummyDataService {
  // Data dummy untuk testing notifikasi
  static List<Earthquake> getDummyEarthquakes() {
    return [
      // BAHAYA - Dekat & Kuat
      Earthquake(
        magnitude: 7.2,
        depth: 10,
        latitude: -6.2088, // Dekat Jakarta
        longitude: 106.8456,
        region: 'Jakarta Selatan (DUMMY - BAHAYA)',
      ),
      // WASPADA - Sedang
      Earthquake(
        magnitude: 5.8,
        depth: 50,
        latitude: -6.5,
        longitude: 107.0,
        region: 'Bandung Barat (DUMMY - WASPADA)',
      ),
      // AMAN - Jauh
      Earthquake(
        magnitude: 4.5,
        depth: 100,
        latitude: -8.5,
        longitude: 115.0,
        region: 'Bali (DUMMY - AMAN)',
      ),
    ];
  }
}
