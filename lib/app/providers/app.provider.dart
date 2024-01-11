import 'package:androidstudio_flutter/core/notifier/authentication.notifier.dart';
import 'package:androidstudio_flutter/core/notifier/database.notifier.dart';
// import 'package:androidstudio_flutter/core/service/database.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
class AppProvider{
  static List<SingleChildWidget> providers=[

     ChangeNotifierProvider(create:(_) =>  AuthenticationNotifier()),
     ChangeNotifierProvider(create:(_) =>  DatabaseNotifier()),

  ];
}