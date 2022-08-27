import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/widgets/custom_nav_bar.dart';
import 'package:weather_app/widgets/custom_text_field.dart';

import '../controller/weather_controller.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({this.locationWeather});


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

    updateUI(widget.locationWeather);
  }
  Future getLocation() async {
    var location = (await FirebaseFirestore.instance.collection('Location').doc(FirebaseAuth.instance.currentUser.uid).get()).data();
    return location;
  }

  void updateUI(dynamic ans) {
    setState(
      () {
        if (ans == null) {
          temp = 0;
          weatherIcon = 'Error';
          weatherMessage = 'Unable to get weather data';
          cityName = 'your location';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: SafeArea(
                child: FutureBuilder(
                  future: getLocation(),
                  builder: (context, AsyncSnapshot snapshot){
                    if(snapshot.hasData){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            label: 'My Location',
                            controller: locationController,
                            hintText: snapshot.data['cityName'],
                        //    controller: mailController,
                          ),
                          // ignore: deprecated_member_use
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RaisedButton(
                                child: const Text('Update Data',style: TextStyle(color: buttonTextColor),),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),color: buttonColor,onPressed: ()async{
                              FirebaseFirestore.instance.collection('Location').doc(FirebaseAuth.instance.currentUser.uid).update({
                                'cityName':locationController.text,

                              });
                            }),
                          )
                        ],
                      );
                    }else{
                      return Center(child: const CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
            Container(
              height: 500,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/mountain.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8), BlendMode.dstATop),
                ),
              ),
              //constraints: BoxConstraints.expand(),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () async {
                            var weatherData = await weatherModel.getLocationWeather();
                            updateUI(weatherData);
                          },
                          child: Icon(
                            Icons.near_me,
                            size: 50.0,
                            color: buttonTextColor,
                          ),
                        ),
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
                            Icons.location_city,
                            size: 50.0,
                            color: buttonTextColor,
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        index: 0,
      ),
    );
  }
}
