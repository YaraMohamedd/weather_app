import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/widgets/custom_nav_bar.dart';

class CityScreen extends StatelessWidget {

   String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mountain.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration:  InputDecoration(
                    filled: true,
                    suffixIcon: InkWell(
                      onTap: (){
                        Navigator.pop(context, cityName);

                      },
                        child: Icon(Icons.search)),
                    fillColor: Colors.white,
                    icon: const Icon(
                      Icons.location_city,
                      color: Colors.white,
                    ),
                    hintText: 'Enter City Name',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        index: 1,
      ),
    );
  }
}
