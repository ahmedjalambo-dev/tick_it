import 'package:tick_it/core/netowoks/api_result.dart';
import 'package:tick_it/core/netowoks/supabase_error_handler.dart';
import 'package:tick_it/features/sign_up/data/models/sign_up_request_body.dart';
import 'package:tick_it/features/sign_up/data/services/sign_up_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpRepo {
  final SignUpApiService _apiService;
  SignUpRepo(this._apiService);

  Future<ApiResult<AuthResponse>> signUp(SignUpRequestBody body) async {
    try {
      final response = await _apiService.signUp(body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
