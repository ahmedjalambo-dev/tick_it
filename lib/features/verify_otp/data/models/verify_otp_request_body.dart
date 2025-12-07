import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyOtpRequestBody {
  final String email;
  final String token;
  final OtpType type;

  VerifyOtpRequestBody({
    required this.email,
    required this.token,
    this.type = OtpType.signup,
  });
}
