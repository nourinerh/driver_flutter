import 'package:flutter/material.dart';

class UpdateCarPage extends StatefulWidget {
  const UpdateCarPage({super.key});

  @override
  State<UpdateCarPage> createState() => _UpdateCarPageState();
}

class _UpdateCarPageState extends State<UpdateCarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: Form(
            child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(children: [
                  const SizedBox(
                    height: 90.0,
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Nom de Voiture",
                      hintText: "Nom de Voiture",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Coleur de Voiture",
                      hintText: "Coleur de Voiture",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Numero de Voiture",
                      hintText: "Numero de Voiture",
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      child: const Text(
                        "Modifier",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ]))));
  }
}
