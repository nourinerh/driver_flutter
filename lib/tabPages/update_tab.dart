import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class UpdateTabPage extends StatefulWidget {
  const UpdateTabPage({super.key});

  @override
  State<UpdateTabPage> createState() => _UpdateTabPageState();
}

class _UpdateTabPageState extends State<UpdateTabPage> {
  File? _image;
  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      //final imageTemporary = File(image.path);
      final imagePermanent = await saveFilePermantely(image.path);
      setState(() {
        this._image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print("échec de la sélection de l'image  $e");
    }
  }

  Future<File> saveFilePermantely(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: Form(
            child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(children: [
                  SizedBox(
                    height: 40,
                  ),
                  _image != null
                      ? ClipOval(
                          child: Image.file(
                            _image!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipOval(
                          child: Material(
                            child: InkWell(
                              splashColor: Colors.black26,
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Ink.image(
                                    image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7T3qxB6GfbRv1Rstsk_rhb4DmFcPfeE8aA&usqp=CAU',
                                    ),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: 'Choisir votre photo de profil',
                    icon: Icons.image_outlined,
                    onClick: () => getImage(ImageSource.gallery),
                  ),
                  TextFormField(
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

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.black, // background color of button
    textStyle: TextStyle(fontSize: 18), // text style
    padding: EdgeInsets.all(18.0), // button padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25), // button border radius
    ),
  );

  return Container(
    width: 250,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 20,
          ),
          Text(title),
        ],
      ),
    ),
  );
}
