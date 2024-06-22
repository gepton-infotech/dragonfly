import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

final supabase = Supabase.instance.client;

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial()) {
    User? currentUser = supabase.auth.currentUser;
    if (currentUser != null) {
      emit(AuthLoggedInState(currentUser: currentUser));
    } else {
      emit(AuthLoggedOutState());
    }
  }

  // Method to verify phone number and send OTP
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    emit(AuthLoadingState());
    try {
      await supabase.auth.signInWithOtp(
        phone: "+91$phoneNumber",
      );
      emit(AuthCodeSentState(phoneNumber: phoneNumber));
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  // Method to verify OTP and sign in
  Future<void> verifyOtp(String phoneNumber, String otp) async {
    emit(AuthLoadingState());
    try {
      final AuthResponse res = await supabase.auth.verifyOTP(
        type: OtpType.sms,
        token: otp,
        phone: "+91$phoneNumber",
      );
      final User? currentUser = res.user;
      emit(AuthLoggedInState(currentUser: currentUser!));
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  // Method to sign out
  Future<void> signOut() async {
    emit(AuthLoadingState());
    await supabase.auth.signOut();
    emit(AuthLoggedOutState());
  }
}
