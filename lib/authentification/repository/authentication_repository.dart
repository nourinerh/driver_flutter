import 'package:driver/authentification/repository/signup_email_password_failure.dart';
import 'package:driver/tabPages/home_tab.dart';
import 'package:driver/tabPages/profile_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthentificationRepository extends GetxController {
  static AuthentificationRepository get instance => Get.find();
  //Variables

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const HomeTabPage())
        : Get.offAll(() => const ProfileTabPage());
  }

  void phoneAuthentification(String phone) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (Credential) async {
        await _auth.signInWithCredential(Credential);
      },
      codeSent: ((verificationId, forceResendingToken) {
        this.verificationId.value = verificationId;
      }),
      codeAutoRetrievalTimeout: ((verificationId) {
        this.verificationId.value = verificationId;
      }),
      verificationFailed: (e) {
        if (e.code == "invalid-number") {
          Get.snackbar('error', 'the provided phone number is not valid');
        } else {
          Get.snackbar('error', 'Something went wrong , try again');
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: this.verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }
}
