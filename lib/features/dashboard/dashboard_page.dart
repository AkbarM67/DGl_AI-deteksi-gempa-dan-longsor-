import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dgl_ai/providers/disaster_provider.dart';
import 'package:dgl_ai/features/dashboard/risk_detail_page.dart';
import 'package:dgl_ai/features/emergency/emergency_guide_page.dart';
import 'package:dgl_ai/features/notification/notification_history_page.dart';
import 'package:dgl_ai/features/maps/earthquake_map_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // Load data when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DisasterProvider>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'dglAI - Sistem Peringatan Dini',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
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
            tooltip: 'Riwayat Notifikasi',
          ),
        ],
      ),
      body: Consumer<DisasterProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.blue[800]),
                  const SizedBox(height: 16),
                  Text(
                    'Menganalisis Data Real-Time...',
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
                  // HEADER INFO
                  _buildHeader(),
                  const SizedBox(height: 20),
                  
                  // STATUS RISIKO CARD
                  _buildRiskCard(provider),
                  const SizedBox(height: 16),
                  
                  // DATA CARDS ROW
                  Row(
                    children: [
                      Expanded(child: _buildLocationCard(provider)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildEarthquakeCard(provider)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // ACTION BUTTONS
                  _buildActionButtons(provider),
                  const SizedBox(height: 16),
                  
                  // AI INFO SECTION
                  _buildAIInfo(provider),
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
          colors: [Colors.blue[800]!, Colors.blue[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.psychology,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(height: 8),
          const Text(
            'AI Geo Risk Engine',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Real-time Analysis • BMKG API • GPS Location',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskCard(DisasterProvider provider) {
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
            'STATUS RISIKO TERKINI',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            provider.riskStatus.replaceAll('(AI Prediction)', '(Analisis Sistem)'),
            style: TextStyle(
              color: provider.riskColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          if (provider.earthquake != null && provider.position != null)
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EarthquakeMapPage(),
                  ),
                );
              },
              icon: const Icon(Icons.map),
              label: const Text('Lihat Peta'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          const SizedBox(height: 8),
          if (provider.earthquake != null && provider.position != null)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RiskDetailPage(
                      earthquake: provider.earthquake!,
                      userPosition: provider.position!,
                      riskLevel: provider.riskStatus.split(' ')[0],
                      distance: provider.distance,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: provider.riskColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Lihat Detail Analisis'),
            ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(DisasterProvider provider) {
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
              Icon(Icons.my_location, color: Colors.blue[600], size: 20),
              const SizedBox(width: 8),
              const Text(
                'GPS Location',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${provider.position!.latitude.toStringAsFixed(4)}°',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${provider.position!.longitude.toStringAsFixed(4)}°',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Real-time GPS',
            style: TextStyle(
              color: Colors.green[600],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarthquakeCard(DisasterProvider provider) {
    if (provider.earthquake == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text('Data gempa tidak tersedia'),
      );
    }

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
              Icon(Icons.waves, color: Colors.orange[600], size: 20),
              const SizedBox(width: 8),
              const Text(
                'BMKG Data',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${provider.earthquake!.magnitude} SR',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${provider.earthquake!.depth} km depth',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${provider.distance.toStringAsFixed(0)} km away',
            style: TextStyle(
              color: Colors.blue[600],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(DisasterProvider provider) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              provider.simulateAlert();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('🚨 Notifikasi terkirim! Cek di panel notifikasi'),
                  backgroundColor: Colors.red[600],
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.notifications_active),
            label: const Text('Uji Sistem Peringatan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
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
            label: const Text('Panduan Darurat'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAIInfo(DisasterProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[50]!, Colors.green[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: Colors.blue[700], size: 24),
              const SizedBox(width: 8),
              Text(
                'Analisis Risiko Gempa',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Sistem menganalisis jarak ${provider.earthquake != null ? "${provider.distance.toStringAsFixed(0)} km" : "N/A"} dari gempa ${provider.earthquake?.magnitude ?? "N/A"} SR dengan kedalaman ${provider.earthquake?.depth ?? "N/A"} km untuk memberikan prediksi risiko berdasarkan data BMKG terkini.',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildAnalysisFeature('Analisis Geografis', Icons.map),
              const SizedBox(width: 12),
              _buildAnalysisFeature('Data Real-time', Icons.speed),
              const SizedBox(width: 12),
              _buildAnalysisFeature('Prediksi Risiko', Icons.trending_up),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisFeature(String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.blue[600], size: 16),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.blue[700],
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}