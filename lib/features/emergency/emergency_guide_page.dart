import 'package:flutter/material.dart';

class EmergencyGuidePage extends StatelessWidget {
  const EmergencyGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panduan Darurat'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildGuideCard(
            'Saat Terjadi Gempa',
            Icons.vibration,
            Colors.red,
            [
              'DROP: Jatuhkan diri ke lantai',
              'COVER: Berlindung di bawah meja kokoh',
              'HOLD ON: Pegang erat-erat hingga guncangan berhenti',
              'Jika di luar ruangan, jauhi bangunan dan kabel listrik',
              'Jika di dalam mobil, berhenti dan tetap di dalam',
              'Jangan berlari keluar saat masih bergoyang',
            ],
          ),
          const SizedBox(height: 16),
          
          _buildGuideCard(
            'Setelah Gempa',
            Icons.medical_services,
            Colors.orange,
            [
              'Periksa diri dan orang sekitar dari luka',
              'Keluar dari bangunan dengan hati-hati',
              'Waspada terhadap gempa susulan',
              'Matikan gas, listrik, dan air jika memungkinkan',
              'Jauhi bangunan yang rusak',
              'Dengarkan radio untuk informasi resmi',
            ],
          ),
          const SizedBox(height: 16),
          
          _buildGuideCard(
            'Saat Longsor',
            Icons.landscape,
            Colors.brown,
            [
              'Segera lari menjauhi arah longsor',
              'Lari ke tempat yang lebih tinggi',
              'Jangan berlari searah dengan longsor',
              'Waspada suara gemuruh dari bukit',
              'Hindari sungai dan lembah',
              'Cari tempat terbuka yang aman',
            ],
          ),
          const SizedBox(height: 16),
          
          _buildGuideCard(
            'Tas Darurat',
            Icons.backpack,
            Colors.blue,
            [
              'Air minum (3 liter per orang)',
              'Makanan tahan lama (3 hari)',
              'Obat-obatan penting',
              'Senter dan baterai cadangan',
              'Radio portabel',
              'Uang tunai secukupnya',
              'Dokumen penting (fotokopi)',
              'Pakaian ganti',
            ],
          ),
          const SizedBox(height: 16),
          
          _buildGuideCard(
            'Nomor Darurat',
            Icons.phone,
            Colors.green,
            [
              'Polisi: 110',
              'Pemadam Kebakaran: 113',
              'Ambulans: 118',
              'SAR: 115',
              'BNPB: 117',
              'PLN: 123',
              'PDAM: (021) 57986555',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGuideCard(String title, IconData icon, Color color, List<String> items) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(child: Text(item)),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}