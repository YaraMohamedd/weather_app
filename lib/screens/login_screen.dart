import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/controller/authentication_controller.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/screens/sign_up_screen.dart';
import 'package:weather_app/widgets/custom_text_field.dart';

class Login extends StatelessWidget {
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _mailFocus = FocusNode();
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();

  Login({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         body: GetBuilder<AuthenticationController>(
           init: AuthenticationController(),
           builder: (controller){
             return SingleChildScrollView(
               child: SafeArea(child:Stack(
                 children: [
                   Image.asset('assets/mountain.png',fit: BoxFit.cover,),
                   // ignore: avoid_unnecessary_containers
                   Container(
                     margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*.34),
                     height: MediaQuery.of(context).size.height*.7,
                     width: double.infinity,
                     decoration: const BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                     ),
                     child: Column(
                       children:  [
                         CustomTextField(
                           label: '',
                        controller: emailController,
                           hintText: 'Email Address',

                         ),
                         CustomTextField(
                           label: '',
                             controller: passController,
                           hintText: 'Password',
                         ),
                         // ignore: deprecated_member_use
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           // ignore: deprecated_member_use
                           child: RaisedButton(
                               color: Colors.redAccent,
                               child: Text('Sign In',style: TextStyle(color: Colors.white),),
                               shape: RoundedRectangleBorder(
                                 side: BorderSide(color: Colors.redAccent),
                                 borderRadius: BorderRadius.circular(20),
                               ),
                               onPressed: (

                                   )async{
                                 SharedPreferences prefs = await SharedPreferences.getInstance();
                                 prefs.setString('email', emailController.text);
                                 prefs.setString('password', passController.text);
                               controller.loginUser(emailController.text, passController.text);
                                 // WeatherController().getWeatherData();
                               }),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           // ignore: deprecated_member_use
                           child: RaisedButton(
                             color: buttonColor,
                               child: const Text('Sign Up',style: TextStyle(color: buttonTextColor),),
                               shape: RoundedRectangleBorder(
                                 side: BorderSide(color: buttonColor),
                                 borderRadius: BorderRadius.circular(20),
                               ),
                               onPressed: (

                                   ){
                                 Get.to(SignUp());
                               }),
                         )
                       ],
                     ),
                   )
                 ],
               ) ),
             );
           },
         )
    );
  }
}
