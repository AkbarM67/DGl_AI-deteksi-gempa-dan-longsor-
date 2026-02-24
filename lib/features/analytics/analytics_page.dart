import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/disaster_provider.dart';
import '../../providers/landslide_provider.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Analytics & Trend', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader('Statistik Real-Time'),
          const SizedBox(height: 12),
          
          Consumer<DisasterProvider>(
            builder: (context, provider, child) {
              return _buildStatsCard(
                'Gempa Bumi',
                Icons.waves,
                Colors.orange,
                [
                  _StatItem('Magnitudo', '${provider.earthquake?.magnitude ?? 'N/A'} SR'),
                  _StatItem('Kedalaman', '${provider.earthquake?.depth ?? 'N/A'} km'),
                  _StatItem('Jarak', '${provider.distance.toStringAsFixed(0)} km'),
                  _StatItem('Status', provider.riskStatus.split(' ')[0]),
                ],
              );
            },
          ),
          
          const SizedBox(height: 16),
          
          Consumer<LandslideProvider>(
            builder: (context, provider, child) {
              return _buildStatsCard(
                'Tanah Longsor',
                Icons.landslide,
                Colors.brown,
                [
                  _StatItem('Curah Hujan', '${provider.rainfall.toStringAsFixed(0)} mm'),
                  _StatItem('Kemiringan', '${provider.slope.toStringAsFixed(0)}°'),
                  _StatItem('Jenis Tanah', provider.soilType),
                  _StatItem('Status', provider.riskStatus.split(' ')[0]),
                ],
              );
            },
          ),
          
          const SizedBox(height: 24),
          _buildHeader('Trend Analysis'),
          const SizedBox(height: 12),
          
          _buildTrendCard(
            'Aktivitas Gempa 7 Hari Terakhir',
            Icons.show_chart,
            Colors.blue,
            'Berdasarkan data BMKG, aktivitas gempa dalam 7 hari terakhir menunjukkan pola normal dengan rata-rata 3-5 kejadian per hari.',
          ),
          
          const SizedBox(height: 16),
          
          _buildTrendCard(
            'Prediksi Cuaca & Longsor',
            Icons.cloud,
            Colors.green,
            'Curah hujan diprediksi meningkat dalam 3 hari ke depan. Waspada potensi longsor di area berbukit.',
          ),
          
          const SizedBox(height: 24),
          _buildHeader('Rekomendasi Sistem'),
          const SizedBox(height: 12),
          
          _buildRecommendationCard(),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildStatsCard(String title, IconData icon, Color color, List<_StatItem> stats) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...stats.map((stat) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  stat.label,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                Text(
                  stat.value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTrendCard(String title, IconData icon, Color color, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple[50]!, Colors.blue[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.purple[700], size: 24),
              const SizedBox(width: 12),
              Text(
                'Saran Keamanan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildRecommendationItem('Pastikan tas darurat siap sedia'),
          _buildRecommendationItem('Periksa jalur evakuasi terdekat'),
          _buildRecommendationItem('Simpan nomor darurat di kontak cepat'),
          _buildRecommendationItem('Pantau update cuaca secara berkala'),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem {
  final String label;
  final String value;
  
  _StatItem(this.label, this.value);
}
