# 🌊 dglAI - Disaster Geo-Location AI

**Sistem Peringatan Dini Cerdas (AI-Early Warning System)**

Aplikasi mobile berbasis AI untuk deteksi dini dan peringatan bencana gempa bumi & tanah longsor dengan personalisasi alert berdasarkan lokasi dan preferensi pengguna.

![Flutter](https://img.shields.io/badge/Flutter-3.8.1-blue)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 🎯 Fitur Utama

### 🚨 Real-Time Disaster Monitoring
- **Gempa Bumi**: Data real-time dari BMKG API
- **Tanah Longsor**: Analisis curah hujan & kondisi geografis
- **GPS Tracking**: Deteksi lokasi otomatis untuk perhitungan jarak
- **Risk Engine**: Algoritma cerdas untuk analisis tingkat bahaya

### 👤 Personalisasi Alert (NEW! v1.1.0)
- **Custom Alert Radius**: Atur zona peringatan 50-1000 km
- **Magnitude Filter**: Notifikasi hanya untuk gempa ≥ threshold
- **Toggle Notifications**: Kontrol jenis bencana yang ingin dipantau
- **Smart Filtering**: Alert hanya untuk bencana yang relevan

### 📊 Analytics Dashboard (NEW! v1.1.0)
- **Real-Time Statistics**: Magnitudo, kedalaman, jarak, curah hujan
- **Trend Analysis**: Pola aktivitas bencana 7 hari terakhir
- **AI Recommendations**: Saran keamanan berdasarkan kondisi terkini
- **Multi-Disaster View**: Monitoring gempa & longsor dalam satu dashboard

### 🗺️ Visualisasi & Navigasi
- **Interactive Maps**: Google Maps dengan marker episentrum
- **4-Tab Navigation**: Gempa | Longsor | Analytics | Pengaturan
- **Detail Analysis**: Informasi lengkap setiap kejadian bencana
- **Emergency Guide**: Panduan evakuasi & kontak darurat

---

## 📱 Screenshots

```
┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│   Gempa     │  │   Longsor   │  │  Analytics  │  │ Pengaturan  │
│  Dashboard  │  │  Dashboard  │  │  Dashboard  │  │   Settings  │
│             │  │             │  │             │  │             │
│  🌊 5.5 SR  │  │  🏔️ 85mm   │  │  📊 Stats   │  │  ⚙️ Radius  │
│  WASPADA    │  │  WASPADA    │  │  📈 Trend   │  │  🔔 Toggle  │
│  150 km     │  │  25° slope  │  │  💡 Tips    │  │  ⚡ Filter  │
└─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘
```

---

## 🚀 Quick Start

### Prerequisites
- Flutter SDK 3.8.1+
- Dart 3.0+
- Android Studio / VS Code
- Android device/emulator (API 21+) or iOS device (iOS 12+)

### Installation

```bash
# 1. Clone repository
git clone https://github.com/yourusername/dgl_ai.git
cd dgl_ai

# 2. Install dependencies
flutter pub get

# 3. Run aplikasi
flutter run
```

### Setup Firebase (Optional)
```bash
# Install FlutterFire CLI
flutter pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

---

## 📚 Dokumentasi

### File Dokumentasi Lengkap:
- **[SUMMARY.md](SUMMARY.md)** - Overview & quick summary
- **[FITUR_BARU.md](FITUR_BARU.md)** - Penjelasan detail fitur v1.1.0
- **[TESTING_GUIDE.md](TESTING_GUIDE.md)** - Panduan testing step-by-step
- **[ARCHITECTURE.md](ARCHITECTURE.md)** - Architecture & flow diagram

### Quick Links:
- 📖 [Cara Menggunakan](#-cara-menggunakan)
- 🧪 [Testing](#-testing)
- 🏗️ [Architecture](#-architecture)
- 🤝 [Contributing](#-contributing)

---

## 💡 Cara Menggunakan

### 1. Setup Preferensi (Pertama Kali)
```
1. Buka aplikasi
2. Izinkan akses lokasi
3. Tap tab "Pengaturan" (⚙️)
4. Atur radius alert (default: 500 km)
5. Atur magnitudo minimum (default: 5.0 SR)
6. Toggle on/off untuk jenis bencana
```

### 2. Monitor Dashboard
```
1. Tab "Gempa" → Status risiko gempa real-time
2. Tab "Longsor" → Status risiko longsor real-time
3. Pull to refresh untuk update data
4. Tap "Lihat Detail" untuk analisis lengkap
```

### 3. Lihat Analytics
```
1. Tab "Analytics" → Statistik & trend
2. Scroll untuk melihat:
   - Real-time statistics
   - Trend analysis
   - AI recommendations
```

### 4. Notifikasi Otomatis
```
✅ Notifikasi otomatis terkirim jika:
   - Bencana dalam radius alert Anda
   - Magnitudo ≥ threshold yang diatur
   - Toggle notifikasi ON

❌ Tidak ada notifikasi jika:
   - Bencana di luar zona alert
   - Magnitudo < threshold
   - Toggle notifikasi OFF
```

---

## 🧪 Testing

### Run Tests
```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/

# Code analysis
flutter analyze
```

### Manual Testing
Lihat **[TESTING_GUIDE.md](TESTING_GUIDE.md)** untuk test cases lengkap.

**Quick Test:**
```
1. Buka tab "Pengaturan"
2. Ubah radius ke 200 km
3. Kembali ke tab "Gempa"
4. Pull to refresh
5. Cek status risiko berubah
```

---

## 🏗️ Architecture

### Tech Stack
- **Framework**: Flutter 3.8.1
- **Language**: Dart 3.0+
- **State Management**: Provider
- **Storage**: SharedPreferences, SQLite
- **Maps**: Google Maps Flutter
- **Notifications**: Firebase Cloud Messaging, Local Notifications

### Project Structure
```
lib/
├── core/
│   ├── services/      # Business logic & API calls
│   └── utils/         # Helper functions
├── models/            # Data models
├── providers/         # State management
└── features/          # UI pages
    ├── dashboard/
    ├── landslide/
    ├── analytics/     # ✨ NEW
    └── settings/      # ✨ NEW
```

Lihat **[ARCHITECTURE.md](ARCHITECTURE.md)** untuk detail lengkap.

---

## 📦 Dependencies

### Core
```yaml
flutter:
  sdk: flutter
provider: ^6.1.2
```

### APIs & Services
```yaml
dio: ^5.4.0                    # HTTP client
geolocator: ^11.0.0            # GPS location
firebase_core: ^3.6.0          # Firebase
firebase_messaging: ^15.1.0    # Push notifications
```

### UI & Storage
```yaml
google_maps_flutter: ^2.5.0    # Maps
flutter_local_notifications: ^17.2.0
shared_preferences: ^2.2.2     # Settings storage
sqflite: ^2.3.0                # Database
intl: ^0.19.0                  # Date formatting
```

---

## 🎯 Roadmap

### ✅ v1.0.0 (Completed)
- [x] Real-time earthquake monitoring
- [x] Landslide risk detection
- [x] GPS location tracking
- [x] Basic risk calculation
- [x] Push notifications
- [x] Google Maps integration

### ✅ v1.1.0 (Current)
- [x] User settings & preferences
- [x] Analytics dashboard
- [x] Zone-based alert system
- [x] Smart notification filtering
- [x] 4-tab navigation
- [x] UI/UX improvements

### 🔮 v1.2.0 (Planned)
- [ ] Machine Learning integration (TensorFlow Lite)
- [ ] Historical data charts (fl_chart)
- [ ] Export data (CSV/PDF)
- [ ] Offline mode
- [ ] Multi-language support

### 🚀 v2.0.0 (Future)
- [ ] IoT sensor integration
- [ ] Social features (share status)
- [ ] Community alert system
- [ ] Emergency contact quick dial
- [ ] AR evacuation guide

---

## 🤝 Contributing

Kontribusi sangat diterima! Silakan:

1. Fork repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

### Coding Standards
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Write unit tests for new features
- Update documentation
- Use meaningful commit messages

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👥 Team

**Developer**: [Your Name]
**Project**: Sistem Peringatan Dini Cerdas
**Purpose**: Disaster Preparedness & Early Warning

---

## 🙏 Acknowledgments

- **BMKG** - Earthquake data API
- **Open-Meteo** - Weather data API
- **Flutter Community** - Amazing framework & packages
- **Firebase** - Cloud messaging & backend

---

## 📞 Support

- 📧 Email: your.email@example.com
- 🐛 Issues: [GitHub Issues](https://github.com/yourusername/dgl_ai/issues)
- 📖 Docs: [Documentation](./FITUR_BARU.md)

---

## 🌟 Star History

Jika aplikasi ini bermanfaat, berikan ⭐ di GitHub!

---

**Built with ❤️ for Disaster Preparedness**

*dglAI - Protecting Lives Through Technology*
