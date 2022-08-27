
import 'package:get/get.dart';
import 'package:weather_app/controller/weather_controller.dart';

import '../controller/authentication_controller.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController());
  Get.lazyPut(() => WeatherController());


    // TODO: implement dependencies
  }

}