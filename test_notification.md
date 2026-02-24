# ✅ Checklist Notifikasi dglAI

## Yang Sudah Diperbaiki:

### 1. **AndroidManifest.xml**
- ✅ Tambah permission `VIBRATE` dan `RECEIVE_BOOT_COMPLETED`
- ✅ Tambah Firebase Messaging Service
- ✅ Tambah default notification channel ID

### 2. **NotificationService.dart**
- ✅ Background message handler (`_firebaseMessagingBackgroundHandler`)
- ✅ Notification channel untuk Android 8.0+
- ✅ Foreground message listener
- ✅ Permission request dengan `criticalAlert`
- ✅ FCM token logging
- ✅ Notification click handler

## Cara Test Notifikasi:

### Test 1: Local Notification (Simulasi)
1. Buka aplikasi
2. Klik tombol **"Uji Sistem Peringatan"**
3. Notifikasi lokal harus muncul dengan judul "🚨 PERINGATAN GEMPA"

### Test 2: Firebase Cloud Messaging (FCM)
1. Jalankan aplikasi dan cek console untuk FCM Token
2. Copy FCM Token dari log
3. Kirim test notification dari Firebase Console:
   - Buka: https://console.firebase.google.com
   - Pilih project: dglai-5f88c
   - Cloud Messaging → Send test message
   - Paste FCM Token
   - Kirim

### Test 3: Background Notification
1. Minimize aplikasi (jangan close)
2. Kirim notifikasi dari Firebase Console
3. Notifikasi harus muncul di notification tray

## Troubleshooting:

### Jika notifikasi tidak muncul:
1. **Cek permission**: Settings → Apps → dgl_ai → Notifications → Allow
2. **Cek Do Not Disturb**: Pastikan tidak aktif
3. **Rebuild app**: `flutter clean && flutter run`
4. **Cek log**: Lihat console untuk error messages

### Jika FCM token null:
1. Pastikan internet aktif
2. Pastikan google-services.json sudah benar
3. Rebuild aplikasi

## Status: ✅ SUDAH BENAR

Implementasi notifikasi sekarang sudah lengkap dengan:
- Local notifications ✅
- Firebase Cloud Messaging ✅
- Background handler ✅
- Notification channels ✅
- Permission handling ✅
