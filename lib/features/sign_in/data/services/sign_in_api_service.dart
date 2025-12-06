import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/sign_in_request_body.dart';

class SignInApiService {
  final SupabaseClient _supabase;
  SignInApiService(this._supabase);

  Future<AuthResponse> login(SignInRequestBody body) async {
    return await _supabase.auth.signInWithPassword(
      email: body.email,
      password: body.password,
    );
  }
}
