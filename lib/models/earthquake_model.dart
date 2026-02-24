class Earthquake {
  final double magnitude;
  final double depth;
  final double latitude;
  final double longitude;
  final String region;

  Earthquake({
    required this.magnitude,
    required this.depth,
    required this.latitude,
    required this.longitude,
    required this.region,
  });

  factory Earthquake.fromJson(Map<String, dynamic> json) {
    final gempa = json["Infogempa"]['gempa'];
    
    // Handle coordinates - bisa dari field Coordinates atau Lintang/Bujur
    double lat, lng;
    
    if (gempa["Coordinates"] != null && gempa["Coordinates"].toString().isNotEmpty) {
      final coordinates = gempa["Coordinates"].toString().split(',');
      lat = double.parse(coordinates[0].trim());
      lng = double.parse(coordinates[1].trim());
    } else {
      // Fallback ke Lintang/Bujur jika Coordinates null
      final lintang = gempa["Lintang"].toString();
      final bujur = gempa["Bujur"].toString();
      
      // Parse lintang (format: "1.96 LS" -> -1.96)
      lat = double.parse(lintang.split(' ')[0]);
      if (lintang.contains('LS')) lat = -lat;
      
      // Parse bujur (format: "138.95 BT" -> 138.95)
      lng = double.parse(bujur.split(' ')[0]);
      if (bujur.contains('BB')) lng = -lng;
    }

    return Earthquake(
      magnitude: double.parse(gempa["Magnitude"].toString()),
      depth: double.parse(gempa["Kedalaman"].toString().replaceAll(' km', '')),
      latitude: lat,
      longitude: lng,
      region: gempa["Wilayah"].toString(),
    );
  }
}