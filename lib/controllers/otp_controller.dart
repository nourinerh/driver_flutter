import 'package:driver/authentification/login_screen.dart';
import 'package:driver/authentification/password_forget_screen/password_forget_otp.dart';
import 'package:driver/authentification/repository/authentication_repository.dart';
import 'package:driver/tabPages/home_tab.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthentificationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const HomeTabPage()) : Get.back();
  }
}
