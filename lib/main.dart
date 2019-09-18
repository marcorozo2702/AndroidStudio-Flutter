import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';
void main(){
  // Set portrait orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(
      MaterialApp(
        title: 'Flutter Screens',
        home: Home(),
        debugShowCheckedModeBanner: false,
      )
  );
}
