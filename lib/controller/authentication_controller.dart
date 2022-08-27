import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:weather_app/screens/loading_screen.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/location.dart';
final _firestore = FirebaseFirestore.instance;
User loggedInUser;
final userRef = _firestore.collection('Users');
class AuthenticationController extends GetxController{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // ignore: missing_return
  Future loginUser(String mail,String password)async{
     var result=await firebaseAuth
        .signInWithEmailAndPassword(email: mail
        , password: password);
    User user = result.user;
    if (user != null) {
       Get.to(LoadingScreen());
    }
  }
  Future registerUser(String mail,String password,String name)async{
     firebaseAuth=FirebaseAuth.instance;
    var result= await firebaseAuth.createUserWithEmailAndPassword(email: mail, password:password);
    User user=result.user;
    if (result!=null){
      Location location = Location();
      FirebaseFirestore.instance.collection('Users').doc(firebaseAuth.currentUser.uid).set(
          {
            'email':user.email,
            'name':name,
            'password':password
          });

      Get.to(LocationScreen());
      Get.appUpdate();
         }
  }
  Future updateUserData(String mail ,String name){
        FirebaseFirestore.instance.collection('Users').doc().update(
        {
          'email':mail,
          'name':name,
        });
  }


}