import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_it/core/routes/my_routes.dart';
import 'package:tick_it/core/widgets/my_text_button.dart';
import 'package:tick_it/core/widgets/spacing_widgets.dart';
import 'package:tick_it/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:tick_it/features/sign_up/ui/widgets/sign_up_bloc_listener.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create Account",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 32),
              Form(
                key: context.read<SignUpCubit>().formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: context.read<SignUpCubit>().nameController,
                      decoration: const InputDecoration(hintText: "Name"),
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    const VerticalSpace(16),
                    TextFormField(
                      controller: context.read<SignUpCubit>().emailController,
                      decoration: const InputDecoration(hintText: "Email"),
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    const VerticalSpace(16),
                    TextFormField(
                      controller: context
                          .read<SignUpCubit>()
                          .passwordController,
                      decoration: const InputDecoration(hintText: "Password"),
                      obscureText: true,
                      validator: (v) => v!.length < 6 ? "Min 6 chars" : null,
                    ),
                  ],
                ),
              ),
              const VerticalSpace(24),

              MyTextButton(
                onPressed: () => context.read<SignUpCubit>().emitSignUpState(),
                text: "Sign Up",
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              const SignUpBlocListener(),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, MyRoutes.login),
                child: const Text("Already have an account? Log In"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
