import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/todo_model.dart';

class TodoApiService {
  final SupabaseClient _supabase;

  TodoApiService(this._supabase);

  /// Create a new Todo
  Future<TodoModel> createTodo(String title) async {
    final Map<String, dynamic> response = await _supabase
        .from('todos')
        .insert({
          'title': title,
        }) // We only send title, DB handles ID/Created_at
        .select()
        .single();

    return TodoModel.fromJson(response);
  }

  /// Read all Todos
  Future<List<TodoModel>> readTodos() async {
    final List<dynamic> response = await _supabase
        .from('todos')
        .select()
        .order('created_at', ascending: false);

    // Use the generated fromJson
    return response.map((json) => TodoModel.fromJson(json)).toList();
  }

  /// Update a Todo's completion status
  Future<TodoModel> updateTodo(int id, bool isCompleted) async {
    final Map<String, dynamic> response = await _supabase
        .from('todos')
        .update({'is_completed': isCompleted})
        .eq('id', id)
        .select()
        .single();

    return TodoModel.fromJson(response);
  }

  /// Delete a Todo
  Future<void> deleteTodo(int id) async {
    await _supabase.from('todos').delete().eq('id', id);
  }
}
