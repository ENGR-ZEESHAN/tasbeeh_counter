import 'dart:convert';

class TasbeehFields {
  static const String id = 'id';
  static const String counterName = 'counterName';
  static const String currentCount = 'currentCount';
  static const String totalCount = 'totalCount';
  static const String timeSnap = 'timeSanp';

  static final List<String> tasbeehList = [
    id,
    counterName,
    currentCount,
    totalCount,
    timeSnap
  ];
}

class Tasbeeh {
  final int? id;
  final String counterName;
  final int currentCount;
  final int totalCount;
  final String timeSnap;
  Tasbeeh({
    this.id,
    required this.counterName,
    required this.currentCount,
    required this.totalCount,
    required this.timeSnap,
  });

  Tasbeeh copyWith({
    int? id,
    String? counterName,
    int? currentCount,
    int? totalCount,
    String? timeSnap,
  }) {
    return Tasbeeh(
      id: id ?? this.id,
      counterName: counterName ?? this.counterName,
      currentCount: currentCount ?? this.currentCount,
      totalCount: totalCount ?? this.totalCount,
      timeSnap: timeSnap ?? this.timeSnap,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TasbeehFields.id: id,
      TasbeehFields.counterName: counterName,
      TasbeehFields.currentCount: currentCount,
      TasbeehFields.totalCount: totalCount,
      TasbeehFields.timeSnap: timeSnap,
    };
  }

  factory Tasbeeh.fromMap(Map<String, dynamic> map) {
    return Tasbeeh(
      id: map[TasbeehFields.id]?.toInt(),
      counterName: map[TasbeehFields.counterName] ?? '',
      currentCount: map[TasbeehFields.currentCount]?.toInt() ?? 0,
      totalCount: map[TasbeehFields.totalCount]?.toInt() ?? 0,
      timeSnap: map[TasbeehFields.timeSnap] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Tasbeeh.fromJson(String source) =>
      Tasbeeh.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Tasbeeh(id: $id, counterName: $counterName, currentCount: $currentCount, totalCount: $totalCount, timeSnap: $timeSnap)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tasbeeh &&
        other.id == id &&
        other.counterName == counterName &&
        other.currentCount == currentCount &&
        other.totalCount == totalCount &&
        other.timeSnap == timeSnap;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        counterName.hashCode ^
        currentCount.hashCode ^
        totalCount.hashCode ^
        timeSnap.hashCode;
  }
}
