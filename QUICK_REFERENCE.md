# 📋 dglAI - Quick Reference Card

## 🚀 Quick Commands

```bash
# Setup
flutter pub get                    # Install dependencies
flutter run                        # Run app
flutter build apk --release        # Build Android APK

# Development
flutter analyze                    # Code analysis
flutter test                       # Run tests
flutter clean                      # Clean build files

# Debug
flutter logs                       # View logs
flutter devices                    # List devices
```

---

## 📱 App Navigation

```
┌─────────────────────────────────────────┐
│         dglAI - Bottom Navigation       │
├─────────────────────────────────────────┤
│                                         │
│  [🌊 Gempa] [🏔️ Longsor] [📊 Analytics] [⚙️ Settings]
│                                         │
│  Tab 1      Tab 2       Tab 3         Tab 4
│  ↓          ↓           ↓             ↓
│  Earthquake Landslide   Statistics    User
│  Dashboard  Dashboard   & Trends      Preferences
│                                         │
└─────────────────────────────────────────┘
```

---

## ⚙️ Settings Quick Guide

### Alert Radius
```
Min: 50 km  ━━━━━━━━━━━━━━━━━━━━  Max: 1000 km
             ↑ Drag slider ↑
```
**Purpose**: Set zone for receiving alerts
**Default**: 500 km

### Magnitude Threshold
```
Min: 3.0 SR ━━━━━━━━━━━━━━━━━━━━  Max: 7.0 SR
             ↑ Drag slider ↑
```
**Purpose**: Filter alerts by earthquake strength
**Default**: 5.0 SR

### Notification Toggles
```
🔔 Peringatan Gempa     [ON/OFF]
🔔 Peringatan Longsor   [ON/OFF]
```
**Purpose**: Enable/disable specific disaster alerts

---

## 🎯 Risk Levels

| Level | Color | Icon | Meaning | Action |
|-------|-------|------|---------|--------|
| **BAHAYA** | 🔴 Red | ⚠️ | High risk | Evacuate immediately |
| **WASPADA** | 🟠 Orange | ⚠️ | Medium risk | Stay alert, prepare |
| **AMAN** | 🟢 Green | ✅ | Low risk | Normal monitoring |

---

## 📊 Analytics Dashboard

### Real-Time Stats
```
┌─────────────────────────────────┐
│ 🌊 Gempa Bumi                   │
├─────────────────────────────────┤
│ Magnitudo:    5.5 SR            │
│ Kedalaman:    10 km             │
│ Jarak:        150 km            │
│ Status:       WASPADA           │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│ 🏔️ Tanah Longsor               │
├─────────────────────────────────┤
│ Curah Hujan:  85 mm             │
│ Kemiringan:   25°               │
│ Jenis Tanah:  Liat              │
│ Status:       WASPADA           │
└─────────────────────────────────┘
```

---

## 🔔 Notification Logic

### When You Get Alerts
```
✅ Alert SENT if:
   ├─ Distance ≤ Alert Radius
   ├─ Magnitude ≥ Min Threshold
   └─ Toggle is ON

❌ Alert BLOCKED if:
   ├─ Distance > Alert Radius
   ├─ Magnitude < Min Threshold
   └─ Toggle is OFF
```

### Example Scenarios
```
Scenario 1: User in Jakarta
Settings: Radius 500km, Min 5.0 SR
Event: Gempa 5.5 SR, 150 km away
Result: ✅ ALERT SENT (WASPADA)

Scenario 2: User in Jakarta
Settings: Radius 200km, Min 5.0 SR
Event: Gempa 5.5 SR, 500 km away
Result: ❌ NO ALERT (Outside zone)

Scenario 3: User in Jakarta
Settings: Radius 500km, Min 6.0 SR
Event: Gempa 5.5 SR, 150 km away
Result: ❌ NO ALERT (Below threshold)
```

---

## 🗂️ File Structure Quick Map

```
lib/
├── main.dart                    # Entry point
├── models/                      # Data structures
│   ├── earthquake_model.dart
│   ├── landslide_model.dart
│   └── user_settings_model.dart # ✨ NEW
├── providers/                   # State management
│   ├── disaster_provider.dart
│   ├── landslide_provider.dart
│   └── settings_provider.dart   # ✨ NEW
├── core/services/               # Business logic
│   ├── earthquake_service.dart
│   ├── weather_service.dart
│   ├── risk_engine.dart
│   └── settings_service.dart    # ✨ NEW
└── features/                    # UI pages
    ├── dashboard/
    ├── landslide/
    ├── analytics/               # ✨ NEW
    └── settings/                # ✨ NEW
```

---

## 🔧 Common Tasks

### Change Alert Settings
```
1. Tap "Pengaturan" tab (⚙️)
2. Adjust sliders
3. Toggle switches
4. Settings auto-save
5. Return to dashboard
6. Pull to refresh
```

### View Statistics
```
1. Tap "Analytics" tab (📊)
2. Scroll to view:
   - Real-time stats
   - Trend analysis
   - AI recommendations
```

### Check Earthquake Details
```
1. Tap "Gempa" tab (🌊)
2. Wait for data load
3. Tap "Lihat Detail Analisis"
4. View full information
```

### Test Notifications
```
1. Tap "Gempa" tab
2. Tap "Uji Sistem Peringatan"
3. Check notification panel
```

---

## 🐛 Troubleshooting

### Issue: No GPS Location
```
Solution:
1. Enable Location in device settings
2. Grant location permission to app
3. Restart app
```

### Issue: No Earthquake Data
```
Solution:
1. Check internet connection
2. Pull to refresh
3. Wait for BMKG API response
```

### Issue: Settings Not Applying
```
Solution:
1. Change settings
2. Return to dashboard
3. Pull to refresh (swipe down)
```

### Issue: No Notifications
```
Solution:
1. Check notification toggle is ON
2. Check device notification settings
3. Verify event meets criteria:
   - Within alert radius
   - Above magnitude threshold
```

---

## 📞 Emergency Contacts

### Indonesia Disaster Hotlines
```
🚨 BNPB:        117
🚑 Ambulance:   118 / 119
🚒 Fire Dept:   113
👮 Police:      110
🌊 BMKG:        (021) 4246321
```

---

## 💡 Pro Tips

### Battery Optimization
```
✅ Set smaller alert radius (200-300 km)
✅ Set higher magnitude threshold (6.0+ SR)
✅ Disable unused disaster types
✅ Use pull-to-refresh instead of auto-refresh
```

### For High-Risk Areas
```
✅ Set larger alert radius (800-1000 km)
✅ Set lower magnitude threshold (4.0-5.0 SR)
✅ Enable all disaster types
✅ Check analytics daily
```

### For Low-Risk Areas
```
✅ Set medium alert radius (300-500 km)
✅ Set medium magnitude threshold (5.5-6.0 SR)
✅ Enable only relevant disaster types
✅ Check analytics weekly
```

---

## 🎓 Key Concepts

### Alert Radius
> Maximum distance from your location to receive alerts

### Magnitude Threshold
> Minimum earthquake strength to trigger alerts

### Zone-Based Alert
> Smart filtering based on your location and preferences

### Risk Engine
> Algorithm that calculates danger level based on:
> - Magnitude
> - Depth
> - Distance
> - User settings

---

## 📚 Documentation Links

| Document | Purpose |
|----------|---------|
| [README.md](README.md) | Project overview |
| [SUMMARY.md](SUMMARY.md) | Quick summary |
| [FITUR_BARU.md](FITUR_BARU.md) | Feature details |
| [TESTING_GUIDE.md](TESTING_GUIDE.md) | Testing guide |
| [ARCHITECTURE.md](ARCHITECTURE.md) | System design |
| [CHANGELOG.md](CHANGELOG.md) | Version history |

---

## 🔑 Keyboard Shortcuts (Development)

```
r     - Hot reload
R     - Hot restart
h     - Help
d     - Detach (keep app running)
c     - Clear screen
q     - Quit
```

---

## 📊 Performance Metrics

### Target Metrics
```
⚡ App Launch:        < 3 seconds
⚡ Data Refresh:      < 2 seconds
⚡ Settings Save:     < 1 second
⚡ Notification:      < 5 seconds
⚡ Map Load:          < 4 seconds
```

### Memory Usage
```
📱 Idle:              ~50 MB
📱 Active:            ~80 MB
📱 With Maps:         ~120 MB
```

---

## 🎯 Success Checklist

### First Time Setup
- [ ] Install app
- [ ] Grant location permission
- [ ] Grant notification permission
- [ ] Open Settings tab
- [ ] Configure alert radius
- [ ] Configure magnitude threshold
- [ ] Test notification

### Daily Usage
- [ ] Check dashboard status
- [ ] Review analytics trends
- [ ] Update settings if needed
- [ ] Read AI recommendations

### Emergency Preparedness
- [ ] Know evacuation routes
- [ ] Have emergency kit ready
- [ ] Save emergency contacts
- [ ] Test alert system monthly

---

## 🌟 Feature Highlights

```
v1.1.0 New Features:
├─ 👤 Personal Settings
│  ├─ Custom alert radius
│  ├─ Magnitude filtering
│  └─ Toggle notifications
│
├─ 📊 Analytics Dashboard
│  ├─ Real-time statistics
│  ├─ Trend analysis
│  └─ AI recommendations
│
├─ 🎯 Zone-Based Alerts
│  ├─ Smart filtering
│  ├─ Battery efficient
│  └─ Reduced false positives
│
└─ 🔧 Enhanced Navigation
   └─ 4-tab interface
```

---

**Quick Reference v1.1.0**
*Last Updated: 2024-01-XX*

---

**Print this card for quick access! 📄**
