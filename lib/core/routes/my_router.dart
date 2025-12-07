import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_it/core/di/injection.dart';
import 'package:tick_it/core/routes/my_routes.dart';
import 'package:tick_it/features/home/cubit/home_cubit.dart';
import 'package:tick_it/features/home/ui/home_screen.dart';
import 'package:tick_it/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:tick_it/features/sign_in/ui/sign_in_screen.dart';
import 'package:tick_it/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:tick_it/features/sign_up/ui/sign_up_screen.dart';
import 'package:tick_it/features/verify_otp/cubit/verify_otp_cubit.dart';
import 'package:tick_it/features/verify_otp/ui/verify_otp_screen.dart';

class MyRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyRoutes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignInCubit>(),
            child: const SignInScreen(),
          ),
        );
      case MyRoutes.signup:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: const SignUpScreen(),
          ),
        );
      case MyRoutes.verifyOtp:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<VerifyOtpCubit>(param1: email),
            child: VerifyOtpScreen(email: email),
          ),
        );
      case MyRoutes.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: const HomeScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
