class RiskEngine {
  static String calculateRisk({
    required double magnitude,
    required double depth,
    required double distance,
  }) {
    double riskScore = 0;

    // Magnitudo (faktor utama)
    if (magnitude >= 7.0) {
      riskScore += 70;
    } else if (magnitude >= 6.0) {
      riskScore += 50;
    } else if (magnitude >= 5.0) {
      riskScore += 30;
    } else if (magnitude >= 4.0) {
      riskScore += 15;
    }

    // Kedalaman (shallow quake lebih bahaya)
    if (depth < 70) {
      riskScore += 20;
    } else if (depth < 150) {
      riskScore += 10;
    }

    // Jarak dari episentrum
    if (distance < 50) {
      riskScore += 30;
    } else if (distance < 150) {
      riskScore += 20;
    } else if (distance < 300) {
      riskScore += 10;
    } else if (distance > 1000) {
      riskScore -= 20; // Sangat jauh = aman
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
}