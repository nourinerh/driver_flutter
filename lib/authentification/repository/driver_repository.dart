import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/authentification/repository/driver_repository.dart';
import 'package:driver/model/driver_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'driver_repository.dart';

class DriverRepository extends GetxController {
  static DriverRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  createDriver(DriversModel driver) async {
    await _db
        .collection("drivers")
        .add(driver.toJson())
        .whenComplete(() => Get.snackbar(
              " Success ",
              "you account has benn created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green,
            ))
        .catchError((error, StackTrace) {
      Get.snackbar(
        " Success ",
        "you account has benn created.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print(error.toString());
    });
  }

  //Fetch User
  Future<DriversModel> getDriver(String email) async {
    final snapchot =
        await _db.collection("Drivers").where("email", isEqualTo: email).get();
    final driverData =
        snapchot.docs.map((e) => DriversModel.fromSnapchot(e)).single;
    return driverData;
  }
}
