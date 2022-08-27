import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class Location {
   double latitude;
   double longitude;

  Future<void> getLocation() async {
    try {
      print('request started.');
      LocationPermission permission = await Geolocator.checkPermission();
      print('default permission is $permission');

      while (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        print('permission: $permission');
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );
     //  final coordinates = Coordinates(
     // latitude, longitude);
     //   var address=await Geocoder.local.findAddressesFromCoordinates(
     //      coordinates);
      print(longitude);
      final coordinates = new Coordinates(position.latitude, position.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      FirebaseFirestore.instance.collection('Location').doc(FirebaseAuth.instance.currentUser.uid).set(
          {
            'cityName':first.subAdminArea,
            'lat':position.latitude,
            'lon':position.longitude
          });
      print(first.subAdminArea);

      print('request ended.');

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (exception) {
      print(exception);
    }
  }
}
