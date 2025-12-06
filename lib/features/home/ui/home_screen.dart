import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_it/core/routes/my_routes.dart';
import 'package:tick_it/features/home/cubit/home_cubit.dart';
import 'package:tick_it/features/home/cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      // Listen for the LoggedOut state to navigate
      listener: (context, state) {
        state.whenOrNull(
          loggedOut: () => Navigator.pushNamedAndRemoveUntil(
            context,
            MyRoutes.login,
            (route) => false,
          ),
          error: (message) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Logout Error: $message"),
              backgroundColor: Colors.red,
            ),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            // This is the trigger for the Sign Out feature
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => context.read<HomeCubit>().logout(),
            ),
          ],
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You are logged in!", style: TextStyle(fontSize: 24)),
              SizedBox(height: 16),
              Text("Tap the icon above to sign out."),
            ],
          ),
        ),
      ),
    );
  }
}
