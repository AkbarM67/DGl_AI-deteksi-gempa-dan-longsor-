class UserSettings {
  final double alertRadius;
  final bool enableEarthquakeAlert;
  final bool enableLandslideAlert;
  final double minMagnitudeAlert;
  final String notificationSound;

  UserSettings({
    this.alertRadius = 500.0,
    this.enableEarthquakeAlert = true,
    this.enableLandslideAlert = true,
    this.minMagnitudeAlert = 5.0,
    this.notificationSound = 'default',
  });

  Map<String, dynamic> toJson() => {
    'alertRadius': alertRadius,
    'enableEarthquakeAlert': enableEarthquakeAlert,
    'enableLandslideAlert': enableLandslideAlert,
    'minMagnitudeAlert': minMagnitudeAlert,
    'notificationSound': notificationSound,
  };

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
    alertRadius: json['alertRadius'] ?? 500.0,
    enableEarthquakeAlert: json['enableEarthquakeAlert'] ?? true,
    enableLandslideAlert: json['enableLandslideAlert'] ?? true,
    minMagnitudeAlert: json['minMagnitudeAlert'] ?? 5.0,
    notificationSound: json['notificationSound'] ?? 'default',
  );

  UserSettings copyWith({
    double? alertRadius,
    bool? enableEarthquakeAlert,
    bool? enableLandslideAlert,
    double? minMagnitudeAlert,
    String? notificationSound,
  }) => UserSettings(
    alertRadius: alertRadius ?? this.alertRadius,
    enableEarthquakeAlert: enableEarthquakeAlert ?? this.enableEarthquakeAlert,
    enableLandslideAlert: enableLandslideAlert ?? this.enableLandslideAlert,
    minMagnitudeAlert: minMagnitudeAlert ?? this.minMagnitudeAlert,
    notificationSound: notificationSound ?? this.notificationSound,
  );
}
