import 'package:flutter/material.dart';
import 'splash.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
main() async{
  //off LandScap mode

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


  //runAppp
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: splash(),
  ));
}
