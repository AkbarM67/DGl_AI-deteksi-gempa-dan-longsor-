class Landslide {
  final String location;
  final double latitude;
  final double longitude;
  final double rainfall; // mm per hari
  final double slope; // derajat kemiringan
  final String soilType; // jenis tanah
  final DateTime timestamp;

  Landslide({
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.rainfall,
    required this.slope,
    required this.soilType,
    required this.timestamp,
  });

  factory Landslide.fromJson(Map<String, dynamic> json) {
    return Landslide(
      location: json['location'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      rainfall: (json['rainfall'] ?? 0).toDouble(),
      slope: (json['slope'] ?? 0).toDouble(),
      soilType: json['soilType'] ?? '',
      timestamp: json['timestamp'] != null 
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'location': location,
    'latitude': latitude,
    'longitude': longitude,
    'rainfall': rainfall,
    'slope': slope,
    'soilType': soilType,
    'timestamp': timestamp.toIso8601String(),
  };
}
