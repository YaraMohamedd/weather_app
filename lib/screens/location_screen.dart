import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/screens/loading_screen.dart';
import 'package:weather_app/widgets/custom_nav_bar.dart';
import 'package:weather_app/widgets/custom_text_field.dart';
import 'package:weather_app/widgets/snack_bar.dart';

import '../controller/weather_controller.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
   LocationScreen({this.locationWeather, this.cityName});


  final String cityName;
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  TextEditingController locationController=TextEditingController();

  final weatherModel = Get.put(WeatherController());
   String cityName;
   int temp;
   String weatherIcon;
   String weatherMessage;

  @override
  void initState() {
    super.initState();
    weatherModel.getLocationWeather();
    updateUI(widget.locationWeather);
  }
  Future getLocation() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
   cityName= prefs.getString('cityName');
    // var location = (await FirebaseFirestore.instance.collection('Location').doc(FirebaseAuth.instance.currentUser.uid).get()).data();
    // return location;
  }

  void updateUI(dynamic ans) {
    setState(
      () {
        if (ans == null) {
          temp = 0;
          weatherIcon = 'Error';
          weatherMessage = 'Unable to get weather data';
          //cityName = weatherModel.addresses;
          return;
        } else {
          cityName = ans['name'];
          int condition = ans['weather'][0]['id'];
          weatherIcon = weatherModel.getWeatherIcon(condition);
          temp = ans['main']['temp'].toInt();
          // weatherMessage = weatherModel.getMessage(temp);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder<dynamic>(
        future: weatherModel.getLocationWeather(),
        builder: (context,snapshot){
          return  Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/mountain.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),
            constraints: BoxConstraints.expand(),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          var weatherData = await weatherModel.getLocationWeather();
                          updateUI(weatherData);
                        },
                        child: Icon(
                          Icons.near_me,
                          size: 50.0,
                          color: accentColor,
                        ),
                      ),
                      Text('${cityName}',style: TextStyle(color: accentColor,fontSize: 18,fontWeight: FontWeight.bold),),
                      // Text('${weatherModel.addresses}'),
                      FlatButton(
                        onPressed: () async {
                          String typedName = await Get.to(CityScreen());
                          if (typedName != null) {
                            var weatherData =
                            await weatherModel.getCityWeather(typedName);
                            updateUI(weatherData);
                          }
                        },
                        child: Icon(
                          Icons.search,
                          size: 50.0,
                          color: accentColor,
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          temp==0?'':  '$temp°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          weatherIcon=='Error'?'':  weatherIcon,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomNavigationBar(
        index: 0,
      ),
    );
  }
}
