import 'dart:convert';

class TaskModel {
  final DateTime timeNeeded;
  final String taskName;
  final String priority;
  bool isCompleted;
  TaskModel({
    required this.timeNeeded,
    required this.taskName,
    required this.priority,
    required this.isCompleted,
  });

  TaskModel copyWith({
    DateTime? timeNeeded,
    String? taskName,
    String? priority,
    bool? isCompleted,
  }) {
    return TaskModel(
      timeNeeded: timeNeeded ?? this.timeNeeded,
      taskName: taskName ?? this.taskName,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timeNeeded': timeNeeded.millisecondsSinceEpoch,
      'taskName': taskName,
      'priority': priority,
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      timeNeeded: DateTime.fromMillisecondsSinceEpoch(map['timeNeeded'] as int),
      taskName: map['taskName'] as String,
      priority: map['priority'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(timeNeeded: $timeNeeded, taskName: $taskName, priority: $priority, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.timeNeeded == timeNeeded &&
        other.taskName == taskName &&
        other.priority == priority &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return timeNeeded.hashCode ^
        taskName.hashCode ^
        priority.hashCode ^
        isCompleted.hashCode;
  }
}
