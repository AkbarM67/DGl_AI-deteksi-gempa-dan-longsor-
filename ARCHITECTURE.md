# 🏗️ dglAI - Architecture & Flow Diagram

## 📐 Application Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         dglAI Application                        │
└─────────────────────────────────────────────────────────────────┘
                                 │
                    ┌────────────┴────────────┐
                    │                         │
            ┌───────▼────────┐       ┌───────▼────────┐
            │   Presentation │       │   State Mgmt   │
            │     Layer      │◄──────┤   (Provider)   │
            └───────┬────────┘       └───────▲────────┘
                    │                        │
        ┌───────────┼────────────┬───────────┤
        │           │            │           │
    ┌───▼───┐   ┌───▼───┐   ┌───▼───┐   ┌───▼───┐
    │Gempa  │   │Longsor│   │Analyt │   │Setting│
    │Page   │   │Page   │   │Page   │   │Page   │
    └───────┘   └───────┘   └───────┘   └───────┘
                                 │
                    ┌────────────┴────────────┐
                    │                         │
            ┌───────▼────────┐       ┌───────▼────────┐
            │  Business Logic│       │   Data Layer   │
            │   (Services)   │◄──────┤   (Models)     │
            └───────┬────────┘       └────────────────┘
                    │
        ┌───────────┼────────────┬───────────┐
        │           │            │           │
    ┌───▼───┐   ┌───▼───┐   ┌───▼───┐   ┌───▼───┐
    │BMKG   │   │Weather│   │GPS    │   │Storage│
    │API    │   │API    │   │Service│   │Service│
    └───────┘   └───────┘   └───────┘   └───────┘
```

---

## 🔄 Data Flow Diagram

### 1. Earthquake Alert Flow

```
┌─────────┐
│  User   │
│ Opens   │
│  App    │
└────┬────┘
     │
     ▼
┌─────────────────┐
│ DisasterProvider│
│   .loadData()   │
└────┬────────────┘
     │
     ├──────────────────────┐
     │                      │
     ▼                      ▼
┌──────────────┐    ┌──────────────┐
│LocationService│    │EarthquakeAPI │
│  Get GPS     │    │  Get BMKG    │
│  Position    │    │    Data      │
└──────┬───────┘    └──────┬───────┘
       │                   │
       └─────────┬─────────┘
                 │
                 ▼
        ┌────────────────┐
        │  RiskEngine    │
        │ Calculate Risk │
        │ (Magnitude,    │
        │  Depth,        │
        │  Distance)     │
        └────────┬───────┘
                 │
                 ▼
        ┌────────────────┐
        │SettingsProvider│
        │ Check User     │
        │ Preferences:   │
        │ - Alert Radius │
        │ - Min Magnitude│
        └────────┬───────┘
                 │
         ┌───────┴───────┐
         │               │
    ✅ Within Zone   ❌ Outside Zone
         │               │
         ▼               ▼
┌─────────────────┐  ┌──────────────┐
│ Send Notification│  │ Show "AMAN"  │
│ Update UI Status │  │ (Di Luar     │
│ (BAHAYA/WASPADA)│  │  Zona Alert) │
└─────────────────┘  └──────────────┘
```

### 2. Settings Update Flow

```
┌─────────┐
│  User   │
│ Changes │
│Settings │
└────┬────┘
     │
     ▼
┌──────────────────┐
│  SettingsPage    │
│  Slider/Toggle   │
└────┬─────────────┘
     │
     ▼
┌──────────────────┐
│SettingsProvider  │
│ .updateSettings()│
└────┬─────────────┘
     │
     ▼
┌──────────────────┐
│ SettingsService  │
│ .saveSettings()  │
└────┬─────────────┘
     │
     ▼
┌──────────────────┐
│SharedPreferences │
│  Store to Disk   │
└────┬─────────────┘
     │
     ▼
┌──────────────────┐
│ notifyListeners()│
│  Update UI       │
└──────────────────┘
     │
     ▼
┌──────────────────┐
│ User Refreshes   │
│ Dashboard        │
└────┬─────────────┘
     │
     ▼
┌──────────────────┐
│ DisasterProvider │
│ Uses New Settings│
│ for Risk Calc    │
└──────────────────┘
```

### 3. Analytics Data Flow

```
┌─────────┐
│  User   │
│ Opens   │
│Analytics│
└────┬────┘
     │
     ▼
┌──────────────────┐
│  AnalyticsPage   │
│  Consumer Widget │
└────┬─────────────┘
     │
     ├──────────────────────┐
     │                      │
     ▼                      ▼
┌──────────────┐    ┌──────────────┐
│DisasterProv. │    │LandslideProv.│
│ - earthquake │    │ - rainfall   │
│ - magnitude  │    │ - slope      │
│ - depth      │    │ - soilType   │
│ - distance   │    │ - riskStatus │
│ - riskStatus │    │              │
└──────┬───────┘    └──────┬───────┘
       │                   │
       └─────────┬─────────┘
                 │
                 ▼
        ┌────────────────┐
        │ Display Stats  │
        │ - Real-time    │
        │ - Trend Cards  │
        │ - Recommend.   │
        └────────────────┘
```

---

## 🗂️ Folder Structure

```
dgl_ai/
│
├── lib/
│   ├── main.dart                          # Entry point + Navigation
│   │
│   ├── core/                              # Core functionality
│   │   ├── services/                      # Business logic
│   │   │   ├── earthquake_service.dart    # BMKG API
│   │   │   ├── weather_service.dart       # Weather API
│   │   │   ├── location_service.dart      # GPS
│   │   │   ├── risk_engine.dart           # Earthquake risk calc
│   │   │   ├── landslide_risk_engine.dart # Landslide risk calc
│   │   │   ├── notification_service.dart  # Push notifications
│   │   │   ├── settings_service.dart      # ✨ NEW: User settings
│   │   │   └── ...
│   │   └── utils/
│   │       └── geo_utils.dart             # Distance calculation
│   │
│   ├── models/                            # Data models
│   │   ├── earthquake_model.dart
│   │   ├── landslide_model.dart
│   │   ├── notification_model.dart
│   │   └── user_settings_model.dart       # ✨ NEW: Settings model
│   │
│   ├── providers/                         # State management
│   │   ├── disaster_provider.dart         # ✏️ UPDATED: Zone-based
│   │   ├── landslide_provider.dart        # ✏️ UPDATED: Getters
│   │   └── settings_provider.dart         # ✨ NEW: Settings state
│   │
│   └── features/                          # UI pages
│       ├── dashboard/
│       │   ├── dashboard_page.dart        # Gempa dashboard
│       │   └── risk_detail_page.dart
│       ├── landslide/
│       │   └── landslide_dashboard_page.dart
│       ├── analytics/
│       │   └── analytics_page.dart        # ✨ NEW: Analytics
│       ├── settings/
│       │   └── settings_page.dart         # ✨ NEW: Settings
│       ├── maps/
│       ├── notification/
│       └── emergency/
│
├── FITUR_BARU.md                          # ✨ NEW: Feature docs
├── TESTING_GUIDE.md                       # ✨ NEW: Testing guide
├── SUMMARY.md                             # ✨ NEW: Quick summary
├── ARCHITECTURE.md                        # ✨ NEW: This file
└── README.md                              # Project overview
```

---

## 🔌 Integration Points

### External APIs:
```
┌─────────────────────────────────────────┐
│           External Services             │
├─────────────────────────────────────────┤
│                                         │
│  1. BMKG API (data.bmkg.go.id)         │
│     └─> Earthquake data                │
│                                         │
│  2. Open-Meteo API                     │
│     └─> Weather & rainfall data        │
│                                         │
│  3. Firebase Cloud Messaging           │
│     └─> Push notifications             │
│                                         │
│  4. Google Maps API                    │
│     └─> Map visualization              │
│                                         │
│  5. Geolocator (Device GPS)            │
│     └─> User location                  │
│                                         │
└─────────────────────────────────────────┘
```

### Local Storage:
```
┌─────────────────────────────────────────┐
│          Local Persistence              │
├─────────────────────────────────────────┤
│                                         │
│  1. SharedPreferences                  │
│     └─> User settings                  │
│                                         │
│  2. SQLite (sqflite)                   │
│     └─> Notification history           │
│                                         │
└─────────────────────────────────────────┘
```

---

## 🎯 Key Components

### 1. DisasterProvider (Updated)
**Responsibilities:**
- Fetch earthquake data from BMKG
- Get user GPS location
- Calculate risk using RiskEngine
- **NEW:** Check user settings (radius, magnitude)
- **NEW:** Zone-based alert filtering
- Send notifications if criteria met

**Key Methods:**
```dart
Future<void> loadData()
void _calculateRisk({UserSettings? settings})  // ✨ UPDATED
void _sendAutoAlert(String riskLevel, double distance)
```

### 2. SettingsProvider (New)
**Responsibilities:**
- Load user settings from storage
- Update settings when user changes preferences
- Notify listeners on changes
- Persist settings to SharedPreferences

**Key Methods:**
```dart
Future<void> loadSettings()
Future<void> updateSettings(UserSettings newSettings)
Future<void> updateAlertRadius(double radius)
Future<void> toggleEarthquakeAlert(bool enabled)
```

### 3. AnalyticsPage (New)
**Responsibilities:**
- Display real-time statistics
- Show trend analysis
- Provide AI recommendations
- Consume data from multiple providers

**Data Sources:**
```dart
Consumer<DisasterProvider>    // Earthquake stats
Consumer<LandslideProvider>   // Landslide stats
```

### 4. SettingsPage (New)
**Responsibilities:**
- Render settings UI
- Handle user input (sliders, toggles)
- Update SettingsProvider
- Show current settings values

**UI Components:**
- Slider for alert radius (50-1000 km)
- Slider for min magnitude (3.0-7.0 SR)
- Switch for earthquake alert
- Switch for landslide alert

---

## 🔐 Security & Privacy

### Data Privacy:
```
┌─────────────────────────────────────────┐
│         User Data Handling              │
├─────────────────────────────────────────┤
│                                         │
│  ✅ GPS location: Used locally only    │
│  ✅ Settings: Stored on device         │
│  ✅ No personal data sent to server    │
│  ✅ No user tracking                   │
│  ✅ No analytics collection            │
│                                         │
└─────────────────────────────────────────┘
```

### Permissions Required:
- 📍 Location (GPS) - For distance calculation
- 🔔 Notifications - For emergency alerts
- 🌐 Internet - For API calls

---

## ⚡ Performance Optimization

### Strategies Implemented:
1. **Lazy Loading** - Data loaded only when needed
2. **Caching** - Settings cached in memory
3. **Smart Refresh** - Pull to refresh instead of auto-refresh
4. **Zone Filtering** - Reduce unnecessary calculations
5. **Efficient State Management** - Provider pattern

### Future Optimizations:
- [ ] Implement data caching for offline mode
- [ ] Debounce slider updates
- [ ] Lazy load analytics data
- [ ] Optimize map rendering

---

## 🧪 Testing Strategy

### Unit Tests:
```dart
// RiskEngine
test('Calculate BAHAYA for high magnitude close distance')
test('Calculate AMAN for low magnitude far distance')

// SettingsService
test('Save and load settings correctly')
test('Default settings when no data')

// GeoUtils
test('Calculate distance between coordinates')
```

### Integration Tests:
```dart
// DisasterProvider + SettingsProvider
test('Alert only sent when within user radius')
test('Alert only sent when above min magnitude')

// SettingsProvider + SharedPreferences
test('Settings persist after app restart')
```

### Widget Tests:
```dart
// SettingsPage
test('Slider updates settings value')
test('Toggle switches work correctly')

// AnalyticsPage
test('Displays data from providers')
```

---

## 🚀 Deployment Checklist

### Pre-deployment:
- [ ] Run `flutter analyze` (no errors)
- [ ] Run `flutter test` (all tests pass)
- [ ] Test on Android device
- [ ] Test on iOS device (if available)
- [ ] Verify all permissions in manifest
- [ ] Check Firebase configuration
- [ ] Test notifications on real device
- [ ] Verify API keys are valid

### Build Commands:
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web (if needed)
flutter build web --release
```

---

## 📊 Metrics & KPIs

### Success Metrics:
- ✅ Alert accuracy: >90%
- ✅ Response time: <3 seconds
- ✅ User satisfaction: Settings usage >70%
- ✅ False positive rate: <10%
- ✅ App crash rate: <1%

### Monitoring:
- Track notification delivery rate
- Monitor API response times
- Log error rates
- Measure user engagement with settings

---

## 🔄 Version History

### v1.0.0 (Initial)
- Basic earthquake monitoring
- BMKG API integration
- GPS location tracking
- Simple risk calculation

### v1.1.0 (Current) ✨
- **NEW:** User settings & preferences
- **NEW:** Analytics dashboard
- **NEW:** Zone-based alert system
- **NEW:** 4-tab navigation
- **IMPROVED:** Smart notification filtering
- **IMPROVED:** UI/UX enhancements

### v1.2.0 (Planned)
- ML model integration
- IoT sensor support
- Advanced analytics with charts
- Social features

---

**Architecture designed for scalability and maintainability! 🏗️**
