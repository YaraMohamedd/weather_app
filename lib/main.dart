import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/screens/login_screen.dart';

import 'helpers/binding.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  var password = prefs.getString('password');
  runApp(GetMaterialApp(
    initialBinding: Binding(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(

      primarySwatch: Colors.blue,
    ),
    home:email==null?  Login():LocationScreen(),
  ));

}


