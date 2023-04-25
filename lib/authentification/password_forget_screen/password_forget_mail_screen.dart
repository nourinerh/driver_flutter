import 'package:driver/authentification/password_forget_screen/password_forget_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class PasswordForgetMailScreen extends StatefulWidget {
  const PasswordForgetMailScreen({super.key});

  @override
  State<PasswordForgetMailScreen> createState() =>
      _PasswordForgetMailScreenState();
}

class _PasswordForgetMailScreenState extends State<PasswordForgetMailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                  Image(
                    image: AssetImage('images/reset_password.png'),
                    width: 500.0,
                  ),
                  Text(
                    'Mot de Passe Oublié',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sélectionnez l'une des options ci-dessous pour Réinitialiser votre mot de passe",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Form(
                      child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text('E-mail'), hintText: 'E-mail'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => OTPScreen()));
                            },
                            child: Text('Suivant'),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black)),
                          ))
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
