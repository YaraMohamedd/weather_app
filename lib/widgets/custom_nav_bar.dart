import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/screens/profile_screen.dart';
import '../constants.dart';

class CustomNavigationBar extends StatelessWidget {
  final int index;

  const CustomNavigationBar({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor:primaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items:  [
        BottomNavigationBarItem(
          label: 'location',
          icon: InkWell(
              onTap: (){
                Get.to(LocationScreen());
              },
              child: Icon(Icons.near_me,color: index==0?primaryColor:Color(0xFF7E7E7E),)),
        ),
        BottomNavigationBarItem(
          label: 'profile',
          icon: InkWell(
              onTap: (){
                Get.to(Profile());
              },
              child:  Icon(Icons.person,color: index==1?primaryColor:Color(0xFF7E7E7E),)),
        ),


      ],
    );
  }
}
