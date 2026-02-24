import 'package:sqflite/sqflite.dart';
import '../../models/notification_model.dart';
import 'database_helper.dart';

class NotificationStorage {
  static Future<void> saveNotification(NotificationModel notification) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.insert(
        'notifications',
        notification.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Notification saved to SQLite');
    } catch (e) {
      print('Error saving notification: $e');
    }
  }

  static Future<List<NotificationModel>> getNotifications() async {
    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query(
        'notifications',
        orderBy: 'timestamp DESC',
        limit: 50,
      );
      return result.map((json) => NotificationModel.fromJson(json)).toList();
    } catch (e) {
      print('Error loading notifications: $e');
      return [];
    }
  }

  static Future<void> clearAll() async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete('notifications');
      print('All notifications cleared');
    } catch (e) {
      print('Error clearing notifications: $e');
    }
  }
}
