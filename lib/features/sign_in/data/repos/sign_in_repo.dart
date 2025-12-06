import 'package:tick_it/core/netowoks/api_result.dart';
import 'package:tick_it/core/netowoks/supabase_error_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/sign_in_request_body.dart';
import '../services/sign_in_api_service.dart';

class SignInRepo {
  final SignInApiService _apiService;
  SignInRepo(this._apiService);

  Future<ApiResult<AuthResponse>> login(SignInRequestBody body) async {
    try {
      final response = await _apiService.login(body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
