import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'package:flutter_app_screens/helper/usuario_helper.dart';

void main() async{
  // Set portrait orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  UserHelper user = new UserHelper();




  runApp(
      MaterialApp(
        home: (await user.getVerifica()) == true ? Home() : LoginPage(),
        debugShowCheckedModeBanner: false,
      )
  );
}
