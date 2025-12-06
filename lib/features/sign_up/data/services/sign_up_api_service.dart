import 'package:tick_it/features/sign_up/data/models/sign_up_request_body.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpApiService {
  final SupabaseClient _supabase;
  SignUpApiService(this._supabase);

  Future<AuthResponse> signUp(SignUpRequestBody body) async {
    return await _supabase.auth.signUp(
      email: body.email,
      password: body.password,
      data: {'name': body.name},
    );
  }
}
