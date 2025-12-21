import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_it/core/netowoks/api_result.dart';
import '../data/repos/todo_repo.dart';
import 'todo_state.dart';
import '../data/models/todo_model.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepo _todoRepo;

  TodoCubit(this._todoRepo) : super(const TodoState.initial());

  Future<void> fetchTodos() async {
    emit(const TodoState.loading());
    final result = await _todoRepo.getTodos();

    result.when(
      success: (todos) => emit(TodoState.loaded(todos)),
      failure: (error) =>
          emit(TodoState.error(error.message ?? 'Unknown error')),
    );
  }

  Future<void> addTodo(String title) async {
    // Optimistically could be better, but let's simple reload for now
    final result = await _todoRepo.addTodo(title);

    result.when(
      success: (_) => fetchTodos(), // Refresh list
      failure: (error) =>
          emit(TodoState.error(error.message ?? 'Error adding')),
    );
  }

  Future<void> toggleTodo(TodoModel todo) async {
    final result = await _todoRepo.updateTodo(todo.id, !todo.isCompleted);

    result.when(
      success: (_) => fetchTodos(),
      failure: (error) =>
          emit(TodoState.error(error.message ?? 'Error updating')),
    );
  }

  Future<void> deleteTodo(int id) async {
    final result = await _todoRepo.deleteTodo(id);

    result.when(
      success: (_) => fetchTodos(),
      failure: (error) =>
          emit(TodoState.error(error.message ?? 'Error deleting')),
    );
  }
}
