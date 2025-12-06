import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_it/core/extentions/extentions.dart';
import 'package:tick_it/core/routes/my_routes.dart';
import 'package:tick_it/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:tick_it/features/sign_up/cubit/sign_up_state.dart'
    hide Success, Failure;

class SignUpBlocListener extends StatelessWidget {
  const SignUpBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          },
          success: (accessToken) {
            Navigator.of(context).pop(); // Close dialog
            context.pushNamedAndRemoveUntil(
              MyRoutes.login,
              predicate: (route) => false,
            );
          },
          failure: (error) {
            Navigator.of(context).pop(); // Close dialog
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(error),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
