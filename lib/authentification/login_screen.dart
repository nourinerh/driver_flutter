import 'package:driver/authentification/password_forget_screen/password_forget_mail_screen.dart';
import 'package:driver/authentification/signup_screen.dart';
import 'package:driver/splashScreen/splash_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:driver/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:driver/global/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  validateForm() {
    if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "L'adresse email n'est pas valide");
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Mot de passe requis.");
    } else {
      loginDriverNow();
    }
  }

  loginDriverNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Traitement , veuillez patienter ",
          );
        });
    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text.trim(),
                password: passwordTextEditingController.text.trim())
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error:" + msg.toString());
    }))
        .user;
    if (firebaseUser != null) {
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Connexion réussie");
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Une erreur s'est produite lors de la connexion");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/logo1.png"),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Se connecter en tant que chauffeur",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
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
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Mot de passe ",
                  hintText: "Mot de passe ",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            builder: (context) => Container(
                                  padding: EdgeInsets.all(30.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Faire une Sélection',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                      Text(
                                          "Sélectionnez l'une des options ci-dessous pour Réinitialiser votre mot de passe",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      PasswordForgetMailScreen()));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(20.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.grey.shade200),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.mail_outline_rounded,
                                                size: 60.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('E-Mail',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  Text(
                                                      'Réinitialiser via la vérification par E-Mail',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(20.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.grey.shade200),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.mobile_friendly_rounded,
                                                size: 60.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Numéro Telephone',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  Text(
                                                      'Réinitialiser via la vérification par Numero',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                      },
                      child: Text('Mot de passe Oubliée'))),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    validateForm();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreenAccent,
                  ),
                  child: const Text(
                    "Connexion",
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  )),
              TextButton(
                child: const Text(
                  "Vous n'avez pas de compte",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => SignUpScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
