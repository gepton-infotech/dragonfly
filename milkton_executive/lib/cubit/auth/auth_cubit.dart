import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String _verificationId;

  AuthCubit() : super(AuthInitial()) {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      emit(AuthLoggedInState(firebaseUser: currentUser));
    } else {
      emit(AuthLoggedOutState());
    }
  }

  // Method to verify phone number and send OTP
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    emit(AuthLoadingState());
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          // This callback will be invoked if the verification is done automatically
          await _firebaseAuth.signInWithCredential(credential);
          emit(AuthLoggedInState(firebaseUser: _firebaseAuth.currentUser!));
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(AuthErrorState(error: e.toString()));
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          emit(AuthCodeSentState());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  // Method to verify OTP and sign in
  Future<void> verifyOtp(String otp) async {
    emit(AuthLoadingState());
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
      await _firebaseAuth.signInWithCredential(credential);
      emit(AuthLoggedInState(firebaseUser: _firebaseAuth.currentUser!));
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(error: e.code));
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  // Method to sign out
  Future<void> signOut() async {
    emit(AuthLoadingState());
    await _firebaseAuth.signOut();
    emit(AuthLoggedOutState());
  }
}
