import 'package:get_it/get_it.dart';
import 'package:tick_it/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:tick_it/features/sign_in/data/repos/sign_in_repo.dart';
import 'package:tick_it/features/sign_in/data/services/sign_in_api_service.dart';
import 'package:tick_it/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:tick_it/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:tick_it/features/sign_up/data/services/sign_up_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Feature Imports

import 'package:tick_it/features/home/cubit/home_cubit.dart';
import 'package:tick_it/features/todo/cubit/todo_cubit.dart';
import 'package:tick_it/features/todo/data/repos/todo_repo.dart';
import 'package:tick_it/features/todo/data/services/todo_api_service.dart';
import 'package:tick_it/features/verify_otp/cubit/verify_otp_cubit.dart';
import 'package:tick_it/features/verify_otp/data/repos/verify_otp_repo.dart';
import 'package:tick_it/features/verify_otp/data/services/verify_otp_api_service.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // 1. External Services (Supabase)
  final supabase = Supabase.instance.client;
  getIt.registerLazySingleton<SupabaseClient>(() => supabase);

  // 2. Auth - Login
  getIt.registerLazySingleton<SignInApiService>(
    () => SignInApiService(getIt()),
  );
  getIt.registerLazySingleton<SignInRepo>(() => SignInRepo(getIt()));
  getIt.registerFactory<SignInCubit>(() => SignInCubit(getIt()));

  // 3. Auth - Signup
  getIt.registerLazySingleton<SignUpApiService>(
    () => SignUpApiService(getIt()),
  );
  getIt.registerLazySingleton<SignUpRepo>(() => SignUpRepo(getIt()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));

  // 4. Auth - Verify OTP (Added)
  getIt.registerLazySingleton<VerifyOtpApiService>(
    () => VerifyOtpApiService(getIt()),
  );
  getIt.registerLazySingleton<VerifyOtpRepo>(() => VerifyOtpRepo(getIt()));
  getIt.registerFactoryParam<VerifyOtpCubit, String, void>(
    (email, _) => VerifyOtpCubit(getIt(), email),
  );

  // 4. Home
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));

  // 5. Todo Feature
  getIt.registerLazySingleton<TodoApiService>(() => TodoApiService(getIt()));
  getIt.registerLazySingleton<TodoRepo>(() => TodoRepo(getIt()));
  getIt.registerFactory<TodoCubit>(() => TodoCubit(getIt()));
}
