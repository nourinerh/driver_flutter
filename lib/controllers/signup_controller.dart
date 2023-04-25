import 'package:driver/authentification/repository/authentication_repository.dart';
import 'package:driver/authentification/repository/driver_repository.dart';
import 'package:driver/model/driver_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../authentification/password_forget_screen/password_forget_otp.dart';

class SignUpCOntroller extends GetxController {
  static SignUpCOntroller get instance => Get.find();

//TextField Controlllers to get data from TextField
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();

  final userRepo = Get.put(DriverRepository());

  void phoneAuthentification(String phone) {
    AuthentificationRepository.instance.phoneAuthentification(phone);
  }

  void createDriver(DriversModel driver) async {
    await userRepo.createDriver(driver);
    phoneAuthentification(driver.phone);
    Get.to(() => const OTPScreen());
  }
//call this functions from design & it will do the rest
}
