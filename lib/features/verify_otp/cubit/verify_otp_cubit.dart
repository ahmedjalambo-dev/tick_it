import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_it/core/netowoks/api_result.dart';
import '../data/models/verify_otp_request_body.dart';
import '../data/repos/verify_otp_repo.dart';
import 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final VerifyOtpRepo _verifyOtpRepo;
  final String email;

  VerifyOtpCubit(this._verifyOtpRepo, this.email)
    : super(const VerifyOtpState.initial());

  final otpController = TextEditingController();

  Future<void> emitVerifyOtpState() async {
    emit(const VerifyOtpState.loading());

    final result = await _verifyOtpRepo.verifyOtp(
      VerifyOtpRequestBody(email: email, token: otpController.text.trim()),
    );

    result.when(
      success: (data) =>
          emit(const VerifyOtpState.success("Verification Successful")),
      failure: (error) =>
          emit(VerifyOtpState.failure(error.message ?? "Error")),
    );
  }
}
