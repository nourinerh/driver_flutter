import 'dart:io';

import 'package:driver/controllers/drivers_controller.dart';
import 'package:driver/global/global.dart';
import 'package:driver/splashScreen/splash_screen.dart';
import 'package:driver/tabPages/update_car.dart';
import 'package:driver/tabPages/update_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
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

  final driver = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
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
            SizedBox(
              height: 8,
            ),
            Text(
              'nourine',
              style: TextStyle(fontSize: 23),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'nourine@gmail.com',
              style: TextStyle(fontSize: 23),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(fontSize: 20)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(15)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: const Text("   Modifier votre profil   "),
              onPressed: () {
                fAuth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const UpdateTabPage()));
              },
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(fontSize: 20)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(15)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: const Text("Modifier Voiture détails"),
              onPressed: () {
                fAuth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const UpdateCarPage()));
              },
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(fontSize: 20)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(15)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: const Text("           Sign out               "),
              onPressed: () {
                fAuth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const MySplashScreen()));
              },
            ),
          ],
        ),
      ),
    ));
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
