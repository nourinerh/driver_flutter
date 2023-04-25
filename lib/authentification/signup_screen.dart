import 'package:driver/authentification/password_forget_screen/password_forget_otp.dart';
import 'package:driver/controllers/signup_controller.dart';
import 'package:driver/model/driver_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:driver/global/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:driver/widgets/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:driver/authentification/car_info_screen.dart';
import 'package:driver/authentification/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driver/authentification/repository/authentication_repository.dart';
import 'package:get/get_core/src/get_main.dart';

import 'repository/authentication_repository.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm() {
    if (nameTextEditingController.text.length < 3) {
      Fluttertoast.showToast(
          msg: "le nom doit comporter au moins 3 caractères");
    } else if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "L'adresse email n'est pas valide");
    } else if (phoneTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Le numéro de téléphone est requis");
    } else if (passwordTextEditingController.text.length < 6) {
      Fluttertoast.showToast(
          msg: "Le mot de passe doit être au moins de 6 caractères");
    } //else {
    //saveDriverInfoNow();
    //}
  }

  saveDriverInfoNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Traitement , veuillez patienter",
          );
        });
    final User? firebaseUser = (await fAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text.trim(),
                password: passwordTextEditingController.text.trim())
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error:" + msg.toString());
    }))
        .user;
    if (firebaseUser != null) {
      Map driverMap = {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "password": passwordTextEditingController.text.trim(),
      };
      DatabaseReference driverRef =
          FirebaseDatabase.instance.ref().child('Drivers');
      driverRef.child(firebaseUser.uid).set(driverMap);
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Le compte a été créé");
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => CarInfoScreen()));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Le compte n'a pas été créé");
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpCOntroller());
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("images/logo1.png"),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "Inscrivez-vous en tant que chauffeur",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: nameTextEditingController,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Nom",
                    hintText: "Nom",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                TextField(
                  controller: emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Email",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                TextField(
                  controller: phoneTextEditingController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Telephone",
                    hintText: "Telephone",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                TextField(
                  controller: passwordTextEditingController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Mot de passe",
                    hintText: "Mot de passe ",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //  SignUpCOntroller.instance.phoneAuthentification(
                      //      phoneTextEditingController.text.trim());
                      //  Get.to(() => const OTPScreen());
                      if (_formKey.currentState!.validate()) {
                        //  validateForm();
                        //get user email and password
                        final driver = DriversModel(
                            name: nameTextEditingController.text.trim(),
                            email: emailTextEditingController.text.trim(),
                            phone: phoneTextEditingController.text.trim(),
                            password:
                                passwordTextEditingController.text.trim());
                        SignUpCOntroller.instance.createDriver(driver);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreenAccent,
                    ),
                    child: const Text(
                      "Créer un compte",
                      style: TextStyle(color: Colors.black54, fontSize: 18),
                    )),
                TextButton(
                  child: const Text(
                    "Vous avez déjà un compte? Connectez-vous ici",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => LoginScreen()));
                  },
                ),
              ],
            ),
          )),
    );
  }
}
