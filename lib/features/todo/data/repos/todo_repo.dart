import 'package:tick_it/core/netowoks/api_result.dart';
import 'package:tick_it/core/netowoks/supabase_error_handler.dart';
import '../models/todo_model.dart';
import '../services/todo_api_service.dart';

class TodoRepo {
  final TodoApiService _apiService;

  TodoRepo(this._apiService);

  Future<ApiResult<List<TodoModel>>> getTodos() async {
    try {
      final response = await _apiService.readTodos();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<TodoModel>> addTodo(String title) async {
    try {
      final response = await _apiService.createTodo(title);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> updateTodo(int id, bool isCompleted) async {
    try {
      await _apiService.updateTodo(id, isCompleted);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> deleteTodo(int id) async {
    try {
      await _apiService.deleteTodo(id);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
