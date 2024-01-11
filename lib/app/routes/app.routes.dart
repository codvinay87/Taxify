

// import 'dart:js';

// import 'dart:js';

import 'package:androidstudio_flutter/meta/views/authentication/login.view.dart';
import 'package:androidstudio_flutter/meta/views/authentication/signup.view.dart';
import 'package:androidstudio_flutter/meta/views/home/animation.view.dart';
import 'package:androidstudio_flutter/meta/views/home/fetch.view.dart';
import 'package:androidstudio_flutter/meta/views/home/home.view.dart';
import 'package:androidstudio_flutter/meta/views/home/listview.view.dart';
import 'package:androidstudio_flutter/meta/views/home/listview1.view.dart';
import 'package:androidstudio_flutter/meta/views/home/request.view.dart';
import 'package:androidstudio_flutter/meta/views/home/newRequest.view.dart';

class AppRoutes{
  static const String LoginRoute = "/login";
  static const String SignupRoute = "/signup";
  static const String HomeRoute="/lib/meta/views/home/home.view.dart";
  static const String RequestRoute = "/lib/meta/views/home/request.view.dart";
  static const String newRequestRoute = "/lib/meta/views/home/newRequest.view.dart";
  static const String fetchRoute = "/lib/meta/views/home/fetch.view.dart";
  static const String listviewroute = "lib/meta/views/home/listview.view.dart";
  static const String animationviewroute = "lib/meta/views/home/animation.view.dart";
  // static const String recordshow = "lib/meta/views/home/listview1.view.dart";







  static final routes ={
    LoginRoute : (context)=> const LoginView(),
    SignupRoute :(context)=> const SignupView(),
    HomeRoute : (context)=> const HomeView(),
    RequestRoute: (context)=> const RequestView(),
    newRequestRoute:(context)=>const NewRequestView(),
    fetchRoute:(context)=>const fetchView(),
    listviewroute: (context)=>const MyHomePage(),
    animationviewroute:(context)=>const AnimationScreen(),

    // recordshow: (context)=MyRecordPage(recordId: recordId)

  };

  static get key => null;
}