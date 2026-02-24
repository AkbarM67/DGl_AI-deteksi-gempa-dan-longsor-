import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/landslide_provider.dart';
import '../notification/notification_history_page.dart';
import '../emergency/emergency_guide_page.dart';
import '../maps/landslide_map_page.dart';

class LandslideDashboardPage extends StatefulWidget {
  const LandslideDashboardPage({super.key});

  @override
  State<LandslideDashboardPage> createState() => _LandslideDashboardPageState();
}

class _LandslideDashboardPageState extends State<LandslideDashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LandslideProvider>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Deteksi Risiko Longsor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationHistoryPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<LandslideProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.brown[700]),
                  const SizedBox(height: 16),
                  Text(
                    'Menganalisis Data Cuaca...',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
            );
          }

          if (provider.position == null) {
            return const Center(
              child: Text(
                'GPS tidak tersedia. Pastikan lokasi aktif.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.loadData(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildRiskCard(provider),
                  const SizedBox(height: 16),
                  _buildDataCards(provider),
                  const SizedBox(height: 20),
                  _buildActionButtons(provider),
                  const SizedBox(height: 16),
                  _buildInfoSection(provider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.brown[700]!, Colors.brown[500]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.landslide, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          const Text(
            'Sistem Deteksi Longsor',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Real-time Weather • GPS Location • Risk Analysis',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskCard(LandslideProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: provider.riskColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: provider.riskColor.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: provider.riskColor.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(provider.riskIcon, color: provider.riskColor, size: 48),
          const SizedBox(height: 12),
          Text(
            'STATUS RISIKO LONGSOR',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            provider.riskStatus,
            style: TextStyle(
              color: provider.riskColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDataCards(LandslideProvider provider) {
    if (provider.landslideData == null) return const SizedBox();

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildDataCard(
              'Curah Hujan',
              '${provider.landslideData!.rainfall.toStringAsFixed(1)} mm',
              Icons.water_drop,
              Colors.blue,
            )),
            const SizedBox(width: 12),
            Expanded(child: _buildDataCard(
              'Kemiringan',
              '${provider.landslideData!.slope.toStringAsFixed(0)}°',
              Icons.terrain,
              Colors.orange,
            )),
          ],
        ),
        const SizedBox(height: 12),
        _buildDataCard(
          'Jenis Tanah',
          provider.landslideData!.soilType,
          Icons.landscape,
          Colors.brown,
          fullWidth: true,
        ),
      ],
    );
  }

  Widget _buildDataCard(String label, String value, IconData icon, Color color, {bool fullWidth = false}) {
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
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(LandslideProvider provider) {
    return Column(
      children: [
        if (provider.landslideData != null && provider.position != null)
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LandslideMapPage(),
                ),
              );
            },
            icon: const Icon(Icons.map),
            label: const Text('Lihat Peta Potensi Longsor'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown[700],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              minimumSize: const Size(double.infinity, 0),
            ),
          ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  provider.simulateAlert();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('🚨 Notifikasi terkirim! Cek di panel notifikasi'),
                      backgroundColor: Colors.brown[600],
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.notifications_active),
                label: const Text('Uji Peringatan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmergencyGuidePage(),
                    ),
                  );
                },
                icon: const Icon(Icons.menu_book),
                label: const Text('Panduan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoSection(LandslideProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.brown[50]!, Colors.orange[50]!],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.brown[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.brown[700], size: 24),
              const SizedBox(width: 8),
              Text(
                'Analisis Risiko Longsor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[700],
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Sistem menganalisis curah hujan, kemiringan tanah, dan jenis tanah untuk memprediksi risiko longsor di lokasi Anda.',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
