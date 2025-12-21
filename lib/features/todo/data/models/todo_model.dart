import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  // Supabase returns 'bigint' as int, but sometimes JSON mapping needs specific handling
  // if IDs get too large, but for standard usage int is fine.
  final int id;

  final String title;

  @JsonKey(name: 'is_completed')
  final bool isCompleted;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  TodoModel({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.createdAt,
  });

  // Connect the generated _FromJson method
  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  // Connect the generated _ToJson method
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}
