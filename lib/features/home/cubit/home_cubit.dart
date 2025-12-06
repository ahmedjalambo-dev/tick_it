import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  // SupabaseClient is passed via GetIt dependency injection
  final SupabaseClient _supabase;

  HomeCubit(this._supabase) : super(const HomeState.initial());

  /// Executes the Supabase signOut function.
  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
      // Upon successful sign-out, emit the LoggedOut state
      emit(const HomeState.loggedOut());
    } catch (e) {
      // Handle any potential Supabase sign-out errors
      emit(HomeState.error(e.toString()));
    }
  }
}
