import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_it/core/netowoks/api_result.dart';
import '../data/models/sign_in_request_body.dart';
import '../data/repos/sign_in_repo.dart';
import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInRepo _signInRepo;
  SignInCubit(this._signInRepo) : super(const SignInState.initial());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> emitLoginState() async {
    if (!formKey.currentState!.validate()) return;

    emit(const SignInState.loading());

    final result = await _signInRepo.login(
      SignInRequestBody(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );

    result.when(
      success: (data) => emit(const SignInState.success("Login Successful")),
      failure: (error) => emit(SignInState.failure(error.message ?? "Error")),
    );
  }
}
