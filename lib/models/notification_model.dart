class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String riskLevel;
  final DateTime timestamp;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.riskLevel,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'riskLevel': riskLevel,
    'timestamp': timestamp.toIso8601String(),
  };

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json['id'],
    title: json['title'],
    body: json['body'],
    riskLevel: json['riskLevel'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}
