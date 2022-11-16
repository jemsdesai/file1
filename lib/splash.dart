import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/homePage/home.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadApp();
  }

  loadApp()async{
    await Future.delayed(Duration(seconds: 10));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return home();
    },));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [
      Lottie.asset("assets/jsonAnimation/notesAnimation.json"),
      SizedBox(height: MediaQuery.of(context).size.height*0.16,),
      Text("SUPER NOTE",style: TextStyle(fontSize: 40,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,)
      ,Text("Notes and check list Wherever you go",style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,)
      ,Lottie.asset("assets/jsonAnimation/lodding.json",height:MediaQuery.of(context).size.height*0.1)
    ],),);
  }
}
