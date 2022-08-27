import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/controller/authentication_controller.dart';
import 'package:weather_app/widgets/custom_nav_bar.dart';
import 'package:weather_app/widgets/custom_text_field.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController=TextEditingController();
  TextEditingController mailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  String name;
  String password;
  String mail;
  Future getUsers() async {
    var data = (await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser.uid).get()).data();
    return data;
  }
  Future getLocation() async {
    var location = (await FirebaseFirestore.instance.collection('Location').doc(FirebaseAuth.instance.currentUser.uid).get()).data();
    return location;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: getUsers(),
                builder: (context, AsyncSnapshot snapshot){
                      if(snapshot.hasData){
                        return Column(
                            children: [

                  CustomTextField(
                    label: 'Name',
                  //   controller: nameController,
                  hintText: snapshot.data['name'],
                  controller: nameController,
                  ),
                              CustomTextField(
                                label: 'Email',
                                //  controller: mailController,
                                hintText: snapshot.data['email'],
                                controller: mailController,
                              ),
                              CustomTextField(
                                label: 'Password',
                                //  controller: mailController,
                                hintText: snapshot.data['password'],
                                controller: passwordController,
                              ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(

                        onPressed: (){
                    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser.uid).update({
                    'email':mailController.text,
                    'name':nameController.text,
                      'password':passwordController.text,


                    });
                    },
                    child: const Text('Update Data',style: TextStyle(color: buttonTextColor),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),color: buttonColor,),
                  ),
                  ],
                  );
                      }else{
                        return Center(child: CircularProgressIndicator());
                      }
                },
              ),
            ),

          ],
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     CustomTextField(
        //
        //     ),
        //     CustomTextField(
        //
        //     ),
        //     CustomTextField(
        //
        //     ),
        //   ],
        // ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        index: 1,
      ),
    );
  }
}
