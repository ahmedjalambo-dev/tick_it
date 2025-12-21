import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_it/core/routes/my_routes.dart';
import 'package:tick_it/features/home/cubit/home_cubit.dart';
import 'package:tick_it/features/home/cubit/home_state.dart';
import 'package:tick_it/features/todo/cubit/todo_cubit.dart';
import 'package:tick_it/features/todo/cubit/todo_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        state.whenOrNull(
          loggedOut: () => Navigator.pushNamedAndRemoveUntil(
            context,
            MyRoutes.login,
            (route) => false,
          ),
          error: (message) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Welcome to Tick It!"),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => context.read<HomeCubit>().logout(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddDialog(context),
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<TodoCubit, TodoState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (msg) => Center(child: Text(msg)),
              loaded: (todos) {
                if (todos.isEmpty) {
                  return const Center(child: Text("No todos yet! Add one."));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: todos.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return Dismissible(
                      key: Key(todo.id.toString()),
                      background: Container(color: Colors.red),
                      onDismissed: (_) {
                        context.read<TodoCubit>().deleteTodo(todo.id);
                      },
                      child: Card(
                        child: CheckboxListTile(
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              decoration: todo.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: todo.isCompleted
                                  ? Colors.grey
                                  : Colors.white,
                            ),
                          ),
                          value: todo.isCompleted,
                          onChanged: (_) {
                            context.read<TodoCubit>().toggleTodo(todo);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Add Todo"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "What needs to be done?"),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                // Access the cubit from the parent context
                context.read<TodoCubit>().addTodo(controller.text);
                Navigator.pop(dialogContext);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
