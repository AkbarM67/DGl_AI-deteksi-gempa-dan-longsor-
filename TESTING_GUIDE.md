# 🧪 Testing Guide - Fitur Baru dglAI

## 🚀 Quick Start Testing

### 1. Run Aplikasi
```bash
flutter pub get
flutter run
```

### 2. Test User Settings

#### Test Case 1: Ubah Radius Alert
**Steps:**
1. Buka tab "Pengaturan" (icon ⚙️)
2. Geser slider "Radius Peringatan" ke 200 km
3. Kembali ke tab "Gempa"
4. Pull to refresh
5. **Expected:** Jika gempa > 200 km → Status "AMAN (Di Luar Zona Alert)"

#### Test Case 2: Ubah Magnitudo Minimum
**Steps:**
1. Buka tab "Pengaturan"
2. Geser slider "Magnitudo Minimum" ke 6.0 SR
3. Kembali ke tab "Gempa"
4. Pull to refresh
5. **Expected:** Jika gempa < 6.0 SR → Status "AMAN (Magnitudo Rendah)"

#### Test Case 3: Toggle Notifikasi
**Steps:**
1. Buka tab "Pengaturan"
2. Matikan switch "Peringatan Gempa"
3. Kembali ke tab "Gempa"
4. Tekan tombol "Uji Sistem Peringatan"
5. **Expected:** Notifikasi tetap muncul (simulasi bypass settings)
6. Untuk test real: tunggu gempa real atau trigger auto-alert

### 3. Test Analytics Dashboard

#### Test Case 4: Lihat Statistik Real-Time
**Steps:**
1. Buka tab "Analytics" (icon 📊)
2. **Expected:** Melihat:
   - Card "Gempa Bumi" dengan data magnitudo, kedalaman, jarak
   - Card "Tanah Longsor" dengan data curah hujan, kemiringan, tanah
   - Status risiko untuk masing-masing

#### Test Case 5: Baca Trend Analysis
**Steps:**
1. Scroll ke bawah di tab "Analytics"
2. **Expected:** Melihat:
   - "Aktivitas Gempa 7 Hari Terakhir" (info card)
   - "Prediksi Cuaca & Longsor" (info card)
   - "Rekomendasi AI" dengan checklist keamanan

### 4. Test Zone-Based Alert

#### Test Case 6: Alert Dalam Zona
**Steps:**
1. Set radius alert = 1000 km (max)
2. Set magnitudo minimum = 3.0 SR (min)
3. Kembali ke tab "Gempa"
4. Pull to refresh
5. **Expected:** Jika ada gempa dalam 1000 km → Alert muncul

#### Test Case 7: Alert Di Luar Zona
**Steps:**
1. Set radius alert = 50 km (min)
2. Kembali ke tab "Gempa"
3. Pull to refresh
4. **Expected:** Jika gempa > 50 km → Status "AMAN (Di Luar Zona Alert)"

### 5. Test Persistence (Settings Tersimpan)

#### Test Case 8: Settings Persist After Restart
**Steps:**
1. Buka tab "Pengaturan"
2. Ubah radius alert ke 300 km
3. Ubah magnitudo minimum ke 5.5 SR
4. **Close aplikasi** (force stop)
5. **Buka aplikasi lagi**
6. Buka tab "Pengaturan"
7. **Expected:** Settings masih 300 km dan 5.5 SR (tersimpan)

---

## 🐛 Known Issues & Workarounds

### Issue 1: Settings Tidak Langsung Apply
**Problem:** Setelah ubah settings, status risiko tidak langsung update
**Workaround:** Pull to refresh di tab Gempa/Longsor

**Fix (Future):**
```dart
// Di SettingsProvider, tambahkan callback
void updateSettings(UserSettings newSettings, {VoidCallback? onUpdate}) async {
  _settings = newSettings;
  await _service.saveSettings(_settings);
  notifyListeners();
  onUpdate?.call(); // Trigger reload di provider lain
}
```

### Issue 2: Analytics Data Statis
**Problem:** Trend analysis masih hardcoded text
**Workaround:** Ini placeholder untuk future ML integration

**Fix (Future):**
- Implementasi database untuk historical data
- Query data 7 hari terakhir
- Generate trend chart dengan fl_chart package

---

## 📊 Test Scenarios

### Scenario A: User di Jakarta (Zona Rawan Gempa)
```
Location: -6.2088, 106.8456 (Jakarta)
Settings: Radius 500 km, Min Magnitude 5.0 SR

Expected Behavior:
- Gempa Jawa Barat (5.5 SR, 100 km) → WASPADA + Alert ✅
- Gempa Sumatra (6.0 SR, 800 km) → AMAN (Di Luar Zona) ✅
- Gempa Jawa Tengah (4.5 SR, 200 km) → AMAN (Magnitudo Rendah) ✅
```

### Scenario B: User di Papua (Zona Rawan Longsor)
```
Location: -4.2699, 138.0804 (Papua)
Settings: Landslide Alert ON

Expected Behavior:
- Curah hujan > 100 mm → BAHAYA + Alert ✅
- Curah hujan 50-100 mm → WASPADA + Alert ✅
- Curah hujan < 50 mm → AMAN ✅
```

### Scenario C: User Konservatif (Hanya Alert Penting)
```
Settings: 
- Radius 200 km
- Min Magnitude 6.5 SR
- Earthquake Alert ON
- Landslide Alert OFF

Expected Behavior:
- Gempa 7.0 SR, 150 km → BAHAYA + Alert ✅
- Gempa 6.0 SR, 100 km → AMAN (Magnitudo Rendah) ✅
- Longsor BAHAYA → Tidak ada alert (toggle OFF) ✅
```

---

## 🔍 Debug Tips

### Check SharedPreferences
```dart
// Di SettingsService, tambahkan debug method
Future<void> debugPrintSettings() async {
  final prefs = await SharedPreferences.getInstance();
  print('Stored settings: ${prefs.getString(_settingsKey)}');
}
```

### Check Alert Logic
```dart
// Di DisasterProvider._calculateRisk(), sudah ada print statements:
print('Calculating risk: magnitude=..., depth=..., distance=...');
print('Risk result: $risk');
print('UI updated with status: $_riskStatus');

// Lihat di console untuk debug flow
```

### Check Settings Provider
```dart
// Di SettingsProvider, tambahkan debug
void debugPrintCurrentSettings() {
  print('Current Settings:');
  print('- Alert Radius: ${_settings.alertRadius} km');
  print('- Min Magnitude: ${_settings.minMagnitudeAlert} SR');
  print('- Earthquake Alert: ${_settings.enableEarthquakeAlert}');
  print('- Landslide Alert: ${_settings.enableLandslideAlert}');
}
```

---

## ✅ Testing Checklist

### Functional Testing
- [ ] Settings page dapat dibuka
- [ ] Slider radius berfungsi (50-1000 km)
- [ ] Slider magnitudo berfungsi (3.0-7.0 SR)
- [ ] Toggle earthquake alert berfungsi
- [ ] Toggle landslide alert berfungsi
- [ ] Settings tersimpan setelah restart
- [ ] Analytics page menampilkan data real-time
- [ ] Zone-based alert bekerja sesuai radius
- [ ] Magnitude threshold bekerja sesuai setting
- [ ] Bottom navigation 4 tab berfungsi

### UI/UX Testing
- [ ] Gradient backgrounds tampil dengan baik
- [ ] Shadow effects terlihat
- [ ] Color-coded status jelas (merah/orange/hijau)
- [ ] Icons intuitif dan sesuai
- [ ] Slider label update real-time
- [ ] Responsive di berbagai ukuran layar
- [ ] Smooth transition antar tab
- [ ] Loading states jelas

### Integration Testing
- [ ] Settings mempengaruhi DisasterProvider
- [ ] Analytics membaca data dari providers
- [ ] Notifikasi respek settings toggle
- [ ] Pull to refresh update data dengan settings baru

---

## 🎯 Success Criteria

Aplikasi dianggap **PASS** jika:
1. ✅ User dapat mengatur radius alert (50-1000 km)
2. ✅ User dapat mengatur magnitudo minimum (3.0-7.0 SR)
3. ✅ Settings tersimpan dan persist setelah restart
4. ✅ Alert hanya muncul jika dalam zona & memenuhi threshold
5. ✅ Analytics menampilkan statistik real-time
6. ✅ 4 tab navigation berfungsi dengan baik
7. ✅ UI/UX smooth dan intuitif

---

## 📝 Test Report Template

```
Test Date: [DATE]
Tester: [NAME]
Device: [DEVICE MODEL]
OS: [ANDROID/iOS VERSION]

Test Results:
┌─────────────────────────────────────┬──────────┬─────────┐
│ Test Case                           │ Status   │ Notes   │
├─────────────────────────────────────┼──────────┼─────────┤
│ TC1: Ubah Radius Alert              │ ✅ PASS  │         │
│ TC2: Ubah Magnitudo Minimum         │ ✅ PASS  │         │
│ TC3: Toggle Notifikasi              │ ✅ PASS  │         │
│ TC4: Lihat Statistik Real-Time      │ ✅ PASS  │         │
│ TC5: Baca Trend Analysis            │ ✅ PASS  │         │
│ TC6: Alert Dalam Zona               │ ✅ PASS  │         │
│ TC7: Alert Di Luar Zona             │ ✅ PASS  │         │
│ TC8: Settings Persist After Restart │ ✅ PASS  │         │
└─────────────────────────────────────┴──────────┴─────────┘

Overall Result: ✅ PASS / ❌ FAIL
```

---

**Happy Testing! 🚀**
