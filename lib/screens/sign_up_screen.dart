import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/widgets/custom_text_field.dart';

import '../controller/authentication_controller.dart';

class SignUp extends StatelessWidget {
  final RxBool isVisible = RxBool(false);

  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _mailFocus = FocusNode();
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  final weatherModel = Get.put(WeatherController());

  SignUp({Key key}) : super(key: key);


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
                          controller: nameController,
                          hintText: 'Full Name',

                        ),
                        CustomTextField(
                          label: '',
                          controller: emailController,
                          hintText: 'Email Address',
                        ),
                     Obx(()=>    CustomTextField(
                       label: '',
                       maxLines: 1,
                       secureText:
                       isVisible.value ? false : true,
                       suffixIcon: InkWell(
                           onTap: () {
                             isVisible.value = !isVisible.value;
                           },
                           child: Icon(
                               isVisible.value == true
                                   ? Icons.visibility_off
                                   : Icons.visibility,
                               size: 15,
                               color: Colors.grey
                           )),
                       controller: passController,
                       hintText: 'Password',
                     ),),
                        // ignore: deprecated_member_use

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                              child: Text('Sign Up',style: TextStyle(color: buttonTextColor),),
                              color:Colors.redAccent ,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: buttonColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              onPressed: (

                                  )async{
                                 weatherModel.getLocationWeather();
                                controller.registerUser(emailController.text, passController.text, nameController.text);
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
