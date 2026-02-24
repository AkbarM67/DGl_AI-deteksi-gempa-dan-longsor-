class LandslideRiskEngine {
  static String calculateRisk({
    required double rainfall,
    required double slope,
    required String soilType,
    required double distance,
  }) {
    double riskScore = 0;

    // Curah hujan (faktor utama)
    if (rainfall > 100) {
      riskScore += 70;
    } else if (rainfall > 50) {
      riskScore += 40;
    } else if (rainfall > 20) {
      riskScore += 20;
    }

    // Kemiringan tanah (elevasi/slope)
    if (slope > 30) {
      riskScore += 20;
    } else if (slope > 20) {
      riskScore += 15;
    } else if (slope > 15) {
      riskScore += 10;
    }

    // Jenis tanah (tanah liat & gambut lebih rawan)
    if (soilType.contains('Liat') || soilType.contains('Gambut')) {
      riskScore += 15;
    } else if (soilType.contains('Lempung')) {
      riskScore += 10;
    }

    // Jarak dari area rawan
    if (distance < 5) {
      riskScore += 10;
    } else if (distance < 10) {
      riskScore += 5;
    }

    // Status akhir berdasarkan score
    if (riskScore >= 70) {
      return "BAHAYA";
    } else if (riskScore >= 40) {
      return "WASPADA";
    } else {
      return "AMAN";
    }
  }

  static String getRiskDescription(String riskLevel, double rainfall, double slope) {
    switch (riskLevel) {
      case "BAHAYA":
        return "Kondisi sangat berbahaya! Curah hujan ${rainfall.toStringAsFixed(0)} mm dengan kemiringan ${slope.toStringAsFixed(0)}°. Segera evakuasi!";
      case "WASPADA":
        return "Kondisi berpotensi longsor. Curah hujan ${rainfall.toStringAsFixed(0)} mm. Tetap waspada dan siap evakuasi.";
      case "AMAN":
        return "Kondisi relatif aman. Curah hujan ${rainfall.toStringAsFixed(0)} mm. Tetap pantau perkembangan cuaca.";
      default:
        return "Status tidak diketahui";
    }
  }
}
