import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_it/core/netowoks/api_result.dart';
import '../../sign_up/data/models/sign_up_request_body.dart';
import '../../sign_up/data/repos/sign_up_repo.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo _signUpRepo;
  SignUpCubit(this._signUpRepo) : super(const SignUpState.initial());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  Future<void> emitSignUpState() async {
    if (!formKey.currentState!.validate()) return;

    emit(const SignUpState.loading());

    final result = await _signUpRepo.signUp(
      SignUpRequestBody(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
      ),
    );

    result.when(
      success: (data) => emit(const SignUpState.success("Sign Up Successful")),
      failure: (error) => emit(SignUpState.failure(error.message ?? "Error")),
    );
  }
}
