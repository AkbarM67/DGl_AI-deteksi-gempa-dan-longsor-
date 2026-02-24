import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Pengaturan', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, provider, child) {
          final settings = provider.settings;
          
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildHeader('Notifikasi Peringatan'),
              const SizedBox(height: 12),
              
              _buildCard([
                SwitchListTile(
                  title: const Text('Peringatan Gempa', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text('Aktifkan notifikasi untuk gempa bumi'),
                  value: settings.enableEarthquakeAlert,
                  activeColor: Colors.blue[700],
                  onChanged: (value) => provider.toggleEarthquakeAlert(value),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Peringatan Longsor', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text('Aktifkan notifikasi untuk tanah longsor'),
                  value: settings.enableLandslideAlert,
                  activeColor: Colors.blue[700],
                  onChanged: (value) => provider.toggleLandslideAlert(value),
                ),
              ]),
              
              const SizedBox(height: 24),
              _buildHeader('Zona Bahaya Personal'),
              const SizedBox(height: 12),
              
              _buildCard([
                ListTile(
                  title: const Text('Radius Peringatan', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('${settings.alertRadius.toInt()} km dari lokasi Anda'),
                  trailing: Icon(Icons.location_on, color: Colors.red[400]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Slider(
                        value: settings.alertRadius,
                        min: 50,
                        max: 1000,
                        divisions: 19,
                        activeColor: Colors.blue[700],
                        label: '${settings.alertRadius.toInt()} km',
                        onChanged: (value) => provider.updateAlertRadius(value),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('50 km', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                          Text('1000 km', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
              
              const SizedBox(height: 24),
              _buildHeader('Sensitivitas Alert'),
              const SizedBox(height: 12),
              
              _buildCard([
                ListTile(
                  title: const Text('Magnitudo Minimum', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('Notifikasi untuk gempa ≥ ${settings.minMagnitudeAlert} SR'),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${settings.minMagnitudeAlert} SR',
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Slider(
                        value: settings.minMagnitudeAlert,
                        min: 3.0,
                        max: 7.0,
                        divisions: 8,
                        activeColor: Colors.orange[600],
                        label: '${settings.minMagnitudeAlert} SR',
                        onChanged: (value) => provider.updateMinMagnitude(value),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('3.0 SR', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                          Text('7.0 SR', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
              
              const SizedBox(height: 24),
              _buildInfoBox(),
            ],
          );
        },
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

  Widget _buildCard(List<Widget> children) {
    return Container(
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
      child: Column(children: children),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[50]!, Colors.purple[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue[700], size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Pengaturan ini akan mempengaruhi kapan Anda menerima notifikasi peringatan dini.',
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
