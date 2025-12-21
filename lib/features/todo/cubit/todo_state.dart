import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/todo_model.dart';

part 'todo_state.freezed.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState.initial() = _Initial;
  const factory TodoState.loading() = Loading;
  const factory TodoState.loaded(List<TodoModel> todos) = Loaded;
  const factory TodoState.error(String message) = Error;
}
