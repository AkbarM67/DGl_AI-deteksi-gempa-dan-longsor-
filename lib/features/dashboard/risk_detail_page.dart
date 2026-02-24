import 'package:flutter/material.dart';
import 'package:dgl_ai/models/earthquake_model.dart';
import 'package:geolocator/geolocator.dart';

class RiskDetailPage extends StatelessWidget {
  final Earthquake earthquake;
  final Position userPosition;
  final String riskLevel;
  final double distance;

  const RiskDetailPage({
    super.key,
    required this.earthquake,
    required this.userPosition,
    required this.riskLevel,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Analisis Risiko'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Risiko
            Card(
              color: _getRiskColor(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(_getRiskIcon(), color: Colors.white, size: 32),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'TINGKAT RISIKO: $riskLevel',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Data Gempa
            const Text(
              'Data Gempa Terkini',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Magnitudo', '${earthquake.magnitude} SR'),
                    _buildInfoRow('Kedalaman', '${earthquake.depth} km'),
                    _buildInfoRow('Wilayah', earthquake.region),
                    _buildInfoRow('Jarak dari Anda', '${distance.toStringAsFixed(1)} km'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Analisis AI
            const Text(
              'Analisis AI',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_getAnalysisText()),
                    const SizedBox(height: 12),
                    Text(
                      'Rekomendasi:',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(_getRecommendation()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label, 
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRiskColor() {
    switch (riskLevel) {
      case 'BAHAYA': return Colors.red;
      case 'WASPADA': return Colors.orange;
      case 'AMAN': return Colors.green;
      default: return Colors.grey;
    }
  }

  IconData _getRiskIcon() {
    switch (riskLevel) {
      case 'BAHAYA': return Icons.dangerous;
      case 'WASPADA': return Icons.warning;
      case 'AMAN': return Icons.check_circle;
      default: return Icons.help;
    }
  }

  String _getAnalysisText() {
    if (earthquake.magnitude >= 7.0) {
      return 'Gempa dengan magnitudo ${earthquake.magnitude} tergolong kuat dan berpotensi merusak.';
    } else if (earthquake.magnitude >= 5.0) {
      return 'Gempa dengan magnitudo ${earthquake.magnitude} tergolong sedang.';
    } else {
      return 'Gempa dengan magnitudo ${earthquake.magnitude} tergolong lemah.';
    }
  }

  String _getRecommendation() {
    switch (riskLevel) {
      case 'BAHAYA':
        return 'Segera cari tempat aman, hindari bangunan tinggi, siapkan tas darurat.';
      case 'WASPADA':
        return 'Tetap waspada, pantau perkembangan, siapkan rencana evakuasi.';
      case 'AMAN':
        return 'Kondisi relatif aman, tetap ikuti informasi resmi BMKG.';
      default:
        return 'Pantau terus informasi terkini dari BMKG.';
    }
  }
}