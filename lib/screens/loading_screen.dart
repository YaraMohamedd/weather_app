import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../controller/weather_controller.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {

  const LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    WeatherController weatherModel = WeatherController();
    var ans = await weatherModel.getLocationWeather();

   Get.to(LocationScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SpinKitSpinningLines(
            color: Colors.white,
            size: 100.0,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text('Collecting Weather Data ...'),
        ],
      )),
    );
  }
}
