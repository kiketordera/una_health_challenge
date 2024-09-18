class BloodGlucoseSampleModel {
  final double value;
  final DateTime timestamp;
  final String unit;

  BloodGlucoseSampleModel({
    required this.value,
    required this.timestamp,
    required this.unit,
  });

  factory BloodGlucoseSampleModel.fromJson(Map<String, dynamic> json) {
    return BloodGlucoseSampleModel(
      value: (json['value'] is String)
          ? double.tryParse(json['value']) ?? 0.0
          : json['value']?.toDouble() ?? 0.0,
      timestamp: DateTime.tryParse(json['timestamp']) ?? DateTime.now(),
      unit: json['unit'] ?? 'mg/dL',
    );
  }
}
