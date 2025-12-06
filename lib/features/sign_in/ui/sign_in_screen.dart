import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_it/core/routes/my_routes.dart';
import 'package:tick_it/core/theme/my_theme.dart';
import 'package:tick_it/core/widgets/my_text_button.dart';
import 'package:tick_it/core/widgets/my_text_form_field.dart';
import 'package:tick_it/core/widgets/spacing_widgets.dart';
import 'package:tick_it/features/sign_in/cubit/sign_in_cubit.dart';
import 'widgets/sign_in_bloc_listener.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                "Welcome Back",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const VerticalSpace(32),
              Form(
                key: context.read<SignInCubit>().formKey,
                child: Column(
                  children: [
                    MyTextFormField(
                      controller: context.read<SignInCubit>().emailController,
                      validator: (v) => v!.isEmpty ? "Required" : null,
                      hintText: "Email",
                      textInputType: TextInputType.emailAddress,
                    ),
                    const VerticalSpace(16),
                    MyTextFormField(
                      controller: context
                          .read<SignInCubit>()
                          .passwordController,
                      hintText: "Password",
                      textInputType: TextInputType.text,
                      isObscureText: true,
                      validator: (v) => v!.length < 6 ? "Min 6 chars" : null,
                    ),
                  ],
                ),
              ),
              const VerticalSpace(24),
              MyTextButton(
                text: "Sign In",
                onPressed: () => context.read<SignInCubit>().emitLoginState(),
                backgroundColor: MyTheme.darkTheme.colorScheme.primary,
              ),
              const SignInBlocListener(),
              const VerticalSpace(24),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, MyRoutes.signup),
                child: const Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
