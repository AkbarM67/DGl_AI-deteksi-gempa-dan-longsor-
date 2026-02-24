# Testing Guide - dglAI

## Quick Start Testing

### 1. Run Application
```bash
flutter pub get
flutter run
```

### 2. Test User Settings

#### Test Case 1: Change Alert Radius
**Steps:**
1. Open "Pengaturan" tab
2. Slide "Radius Peringatan" to 200 km
3. Return to "Gempa" tab
4. Pull to refresh
5. **Expected:** If earthquake > 200 km, status shows "AMAN (Di Luar Zona Alert)"

#### Test Case 2: Change Minimum Magnitude
**Steps:**
1. Open "Pengaturan" tab
2. Slide "Magnitudo Minimum" to 6.0 SR
3. Return to "Gempa" tab
4. Pull to refresh
5. **Expected:** If earthquake < 6.0 SR, status shows "AMAN (Magnitudo Rendah)"

#### Test Case 3: Toggle Notifications
**Steps:**
1. Open "Pengaturan" tab
2. Turn off "Peringatan Gempa" switch
3. Return to "Gempa" tab
4. Press "Uji Sistem Peringatan" button
5. **Expected:** Notification still appears (simulation bypasses settings)
6. For real test: wait for actual earthquake or trigger auto-alert

### 3. Test Analytics Dashboard

#### Test Case 4: View Real-Time Statistics
**Steps:**
1. Open "Analytics" tab
2. **Expected:** See:
   - "Gempa Bumi" card with magnitude, depth, distance data
   - "Tanah Longsor" card with rainfall, slope, soil type data
   - Risk status for each disaster type

#### Test Case 5: Read Trend Analysis
**Steps:**
1. Scroll down in "Analytics" tab
2. **Expected:** See:
   - "Aktivitas Gempa 7 Hari Terakhir" info card
   - "Prediksi Cuaca & Longsor" info card
   - "Rekomendasi Sistem" with safety checklist

### 4. Test Zone-Based Alert

#### Test Case 6: Alert Within Zone
**Steps:**
1. Set alert radius = 1000 km (max)
2. Set minimum magnitude = 3.0 SR (min)
3. Return to "Gempa" tab
4. Pull to refresh
5. **Expected:** If earthquake within 1000 km, alert appears

#### Test Case 7: Alert Outside Zone
**Steps:**
1. Set alert radius = 50 km (min)
2. Return to "Gempa" tab
3. Pull to refresh
4. **Expected:** If earthquake > 50 km, status shows "AMAN (Di Luar Zona Alert)"

### 5. Test Persistence (Settings Saved)

#### Test Case 8: Settings Persist After Restart
**Steps:**
1. Open "Pengaturan" tab
2. Change alert radius to 300 km
3. Change minimum magnitude to 5.5 SR
4. **Close application** (force stop)
5. **Open application again**
6. Open "Pengaturan" tab
7. **Expected:** Settings still show 300 km and 5.5 SR (saved)

---

## Test Scenarios

### Scenario A: User in Jakarta (Earthquake-Prone Zone)
```
Location: -6.2088, 106.8456 (Jakarta)
Settings: Radius 500 km, Min Magnitude 5.0 SR

Expected Behavior:
- West Java earthquake (5.5 SR, 100 km) -> WASPADA + Alert
- Sumatra earthquake (6.0 SR, 800 km) -> AMAN (Outside Zone)
- Central Java earthquake (4.5 SR, 200 km) -> AMAN (Low Magnitude)
```

### Scenario B: User in Papua (Landslide-Prone Zone)
```
Location: -4.2699, 138.0804 (Papua)
Settings: Landslide Alert ON

Expected Behavior:
- Rainfall > 100 mm -> BAHAYA + Alert
- Rainfall 50-100 mm -> WASPADA + Alert
- Rainfall < 50 mm -> AMAN
```

### Scenario C: Conservative User (Only Important Alerts)
```
Settings: 
- Radius 200 km
- Min Magnitude 6.5 SR
- Earthquake Alert ON
- Landslide Alert OFF

Expected Behavior:
- Earthquake 7.0 SR, 150 km -> BAHAYA + Alert
- Earthquake 6.0 SR, 100 km -> AMAN (Low Magnitude)
- Landslide BAHAYA -> No alert (toggle OFF)
```

---

## Testing Checklist

### Functional Testing
- [ ] Settings page opens correctly
- [ ] Radius slider works (50-1000 km)
- [ ] Magnitude slider works (3.0-7.0 SR)
- [ ] Earthquake alert toggle works
- [ ] Landslide alert toggle works
- [ ] Settings persist after restart
- [ ] Analytics page displays real-time data
- [ ] Zone-based alert works per radius
- [ ] Magnitude threshold works per setting
- [ ] Bottom navigation 4 tabs work

### UI/UX Testing
- [ ] Gradient backgrounds display properly
- [ ] Shadow effects visible
- [ ] Color-coded status clear (red/orange/green)
- [ ] Icons intuitive and appropriate
- [ ] Slider labels update in real-time
- [ ] Responsive on various screen sizes
- [ ] Smooth transitions between tabs
- [ ] Loading states clear

### Integration Testing
- [ ] Settings affect DisasterProvider
- [ ] Analytics reads data from providers
- [ ] Notifications respect settings toggle
- [ ] Pull to refresh updates data with new settings

---

## Success Criteria

Application passes if:
1. User can set alert radius (50-1000 km)
2. User can set minimum magnitude (3.0-7.0 SR)
3. Settings persist after restart
4. Alerts only appear if within zone & meet threshold
5. Analytics displays real-time statistics
6. 4-tab navigation works properly
7. UI/UX smooth and intuitive

---

## Test Report Template

```
Test Date: [DATE]
Tester: [NAME]
Device: [DEVICE MODEL]
OS: [ANDROID/iOS VERSION]

Test Results:
+-------------------------------------+----------+---------+
| Test Case                           | Status   | Notes   |
+-------------------------------------+----------+---------+
| TC1: Change Alert Radius            | PASS     |         |
| TC2: Change Minimum Magnitude       | PASS     |         |
| TC3: Toggle Notifications           | PASS     |         |
| TC4: View Real-Time Statistics      | PASS     |         |
| TC5: Read Trend Analysis            | PASS     |         |
| TC6: Alert Within Zone              | PASS     |         |
| TC7: Alert Outside Zone             | PASS     |         |
| TC8: Settings Persist After Restart | PASS     |         |
+-------------------------------------+----------+---------+

Overall Result: PASS / FAIL
```

---

**Testing Version**: 1.1.0
**Last Updated**: 2024
