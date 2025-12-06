import 'package:supabase_flutter/supabase_flutter.dart';
import 'api_error_model.dart';

class ErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is AuthException) {
      return ApiErrorModel(
        message: error.message,
        statusCode: int.tryParse(error.statusCode ?? '400'),
      );
    } else if (error is PostgrestException) {
      return ApiErrorModel(
        message: error.message,
        statusCode: int.tryParse(error.code ?? '500'),
      );
    } else {
      return ApiErrorModel(message: error.toString(), statusCode: -1);
    }
  }
}
