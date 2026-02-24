# Changelog

All notable changes to dglAI project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.1.0] - 2024-01-XX (Current Release)

### ✨ Added
- **User Settings & Preferences**
  - Custom alert radius (50-1000 km)
  - Minimum magnitude threshold (3.0-7.0 SR)
  - Toggle notifications for earthquake & landslide
  - Settings persistence with SharedPreferences
  
- **Analytics Dashboard**
  - Real-time statistics for earthquake & landslide
  - Trend analysis cards
  - AI-powered safety recommendations
  - Multi-disaster view in single dashboard
  
- **Zone-Based Alert System**
  - Smart filtering based on user radius
  - Magnitude threshold filtering
  - Reduced false positive alerts
  - Battery-efficient notification system
  
- **Navigation Improvements**
  - Added "Analytics" tab with statistics
  - Added "Settings" tab for preferences
  - 4-tab bottom navigation (Gempa | Longsor | Analytics | Pengaturan)
  
- **Documentation**
  - FITUR_BARU.md - Detailed feature documentation
  - TESTING_GUIDE.md - Comprehensive testing guide
  - ARCHITECTURE.md - System architecture & flow diagrams
  - SUMMARY.md - Quick overview & summary
  - CHANGELOG.md - Version history tracking

### 🔧 Changed
- **DisasterProvider**
  - Updated `_calculateRisk()` to accept UserSettings parameter
  - Added zone-based filtering logic
  - Added magnitude threshold checking
  - Improved notification logic with settings integration
  
- **LandslideProvider**
  - Added getter methods for rainfall, slope, soilType
  - Improved data exposure for analytics
  
- **Main.dart**
  - Added SettingsProvider to MultiProvider
  - Updated bottom navigation to 4 tabs
  - Added routes for new pages

### 🎨 Improved
- UI/UX enhancements with gradient backgrounds
- Shadow effects for better depth perception
- Color-coded status indicators (Red/Orange/Green)
- Responsive sliders with real-time labels
- Smooth animations and transitions
- Better error handling and loading states

### 📚 Documentation
- Complete feature documentation in multiple files
- Architecture diagrams and flow charts
- Testing guide with test cases
- Quick start guide and examples

---

## [1.0.0] - 2024-01-XX (Initial Release)

### ✨ Added
- **Earthquake Monitoring**
  - Real-time data from BMKG API
  - Magnitude, depth, and location tracking
  - Distance calculation from user location
  - Risk level calculation (BAHAYA/WASPADA/AMAN)
  
- **Landslide Detection**
  - Weather data integration (Open-Meteo API)
  - Rainfall monitoring
  - Slope and soil type analysis
  - Risk assessment engine
  
- **Location Services**
  - GPS location tracking
  - Automatic distance calculation
  - Geo-utils for coordinate calculations
  
- **Notifications**
  - Firebase Cloud Messaging integration
  - Local notifications
  - Emergency alert system
  - Notification history storage
  
- **Maps Integration**
  - Google Maps visualization
  - Earthquake epicenter markers
  - User location marker
  - Interactive map controls
  
- **UI Features**
  - Dashboard for earthquake monitoring
  - Dashboard for landslide monitoring
  - Risk detail page
  - Emergency guide page
  - Notification history page
  - Map visualization pages
  
- **Core Services**
  - EarthquakeService - BMKG API integration
  - WeatherService - Weather data fetching
  - LocationService - GPS handling
  - RiskEngine - Earthquake risk calculation
  - LandslideRiskEngine - Landslide risk calculation
  - NotificationService - Push notification handling
  - DatabaseHelper - SQLite for local storage

### 🎨 UI/UX
- Material Design implementation
- Responsive layouts
- Pull-to-refresh functionality
- Loading indicators
- Error handling UI
- Color-coded risk levels

### 🔧 Technical
- Flutter 3.8.1 framework
- Provider state management
- Firebase integration
- SQLite local database
- RESTful API integration
- Geolocator for GPS

---

## [Unreleased]

### 🔮 Planned for v1.2.0
- [ ] Machine Learning integration (TensorFlow Lite)
- [ ] Historical data charts (fl_chart package)
- [ ] Export data functionality (CSV/PDF)
- [ ] Offline mode with data caching
- [ ] Multi-language support (i18n)
- [ ] Dark mode theme
- [ ] Widget for home screen

### 🚀 Planned for v2.0.0
- [ ] IoT sensor integration (MQTT)
- [ ] Social features (share status with family)
- [ ] Community alert system
- [ ] Emergency contact quick dial
- [ ] AR evacuation guide
- [ ] Voice alerts
- [ ] Wearable device support

---

## Version Comparison

| Feature | v1.0.0 | v1.1.0 | v1.2.0 (Planned) |
|---------|--------|--------|------------------|
| Earthquake Monitoring | ✅ | ✅ | ✅ |
| Landslide Detection | ✅ | ✅ | ✅ |
| GPS Tracking | ✅ | ✅ | ✅ |
| Push Notifications | ✅ | ✅ | ✅ |
| Maps Integration | ✅ | ✅ | ✅ |
| **User Settings** | ❌ | ✅ | ✅ |
| **Analytics Dashboard** | ❌ | ✅ | ✅ |
| **Zone-Based Alerts** | ❌ | ✅ | ✅ |
| **Smart Filtering** | ❌ | ✅ | ✅ |
| ML Integration | ❌ | ❌ | ✅ |
| Historical Charts | ❌ | ❌ | ✅ |
| Offline Mode | ❌ | ❌ | ✅ |
| Multi-language | ❌ | ❌ | ✅ |

---

## Migration Guide

### Upgrading from v1.0.0 to v1.1.0

#### 1. Update Dependencies
```bash
flutter pub get
```

#### 2. New Providers
Add `SettingsProvider` to your app:
```dart
// Already done in main.dart
ChangeNotifierProvider(create: (_) => SettingsProvider()..loadSettings()),
```

#### 3. User Settings
First-time users will get default settings:
- Alert Radius: 500 km
- Min Magnitude: 5.0 SR
- Earthquake Alert: ON
- Landslide Alert: ON

#### 4. Breaking Changes
None! v1.1.0 is fully backward compatible.

#### 5. New Features Available
- Navigate to "Pengaturan" tab to customize alerts
- Navigate to "Analytics" tab to view statistics
- Pull to refresh to apply new settings

---

## Known Issues

### v1.1.0
- [ ] Settings changes require manual refresh (pull to refresh)
- [ ] Analytics trend data is currently static (placeholder for ML)
- [ ] Map markers don't update automatically with settings

### Workarounds
1. **Settings not applying**: Pull to refresh on dashboard
2. **Static trend data**: Will be dynamic in v1.2.0 with ML
3. **Map markers**: Reopen map page to refresh

---

## Contributors

### v1.1.0
- [Your Name] - Lead Developer
- Feature implementation: User Settings, Analytics, Zone-Based Alerts
- Documentation: Complete docs suite

### v1.0.0
- [Your Name] - Lead Developer
- Initial implementation: Core features, BMKG integration, UI/UX

---

## Acknowledgments

### v1.1.0
- Flutter community for Provider pattern best practices
- SharedPreferences package maintainers
- UI/UX inspiration from modern disaster apps

### v1.0.0
- BMKG for earthquake data API
- Open-Meteo for weather data API
- Firebase team for cloud messaging
- Google Maps Flutter plugin team

---

## Support

For issues, questions, or feature requests:
- 📧 Email: your.email@example.com
- 🐛 GitHub Issues: [Create Issue](https://github.com/yourusername/dgl_ai/issues)
- 📖 Documentation: [Read Docs](./FITUR_BARU.md)

---

**Last Updated**: 2024-01-XX
**Current Version**: 1.1.0
**Next Release**: 1.2.0 (Q2 2024)
