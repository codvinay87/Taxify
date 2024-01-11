import 'package:androidstudio_flutter/app/providers/app.provider.dart';
import 'package:androidstudio_flutter/app/routes/app.routes.dart';
import 'package:androidstudio_flutter/meta/views/home/home.view.dart';
import 'package:androidstudio_flutter/meta/views/home/switch.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/credentials/supabase.credentials.dart';

Future<void> main() async {
  await Supabase.initialize(
      url: "https://ljjjpxaiskkofopfjvph.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxqampweGFpc2trb2ZvcGZqdnBoIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzY2MjI2MzIsImV4cCI6MTk5MjE5ODYzMn0.7epADfI0pGU814wi1_yaNaFV8OCq137x0EurzwqS7Jw");
  // final client = Supabase.instance.client;

  // Check if the user is already logged in
  // final user = Su.auth.user();

  // final client = Supabase.instance.client;
  //
  // // Check if the user is already logged in
  // final user = client.auth.user();

  // final supabase = SupabaseCredentials.supabaseClient;
  // final Session?  user = supabase.auth.currentSession;
  // final supabase = SupabaseCredentials.supabaseClient;
  // final User? user = supabase.auth.currentUser;
  //
  // var x=user?.email;

  final supabase = SupabaseCredentials.supabaseClient;
  final User? user = supabase.auth.currentUser;

  print(user?.email);

  if (user == 'null') {
    runApp(const core2());
  } else {
    runApp(const core());
  }
  // runApp(const core());
}

class DatabaseService {
  final SupabaseClient client;

  DatabaseService(this.client);
}

class core extends StatelessWidget {
  const core({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(child: Lava(), providers: AppProvider.providers);

    //this lava class will return the pages to be shown

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or simply save your changes to "hot reload" in a Flutter IDE).
    //     // Notice that the counter didn't reset back to zero; the application
    //     // is not restarted.
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: MySwitch(),
    // );
  }
}

class core2 extends StatelessWidget {
  const core2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(child: Lava2(), providers: AppProvider.providers);
  }
}

class Lava extends StatelessWidget {
  const Lava({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:
          AppRoutes.animationviewroute, // initializing the first page of app
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner:
          false, //telling where all routes are saved now
      theme: ThemeData.dark(),
    );
  }
}

class Lava2 extends StatelessWidget {
  const Lava2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.HomeRoute, // initializing the first page of app
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner:
          false, //telling where all routes are saved now
      theme: ThemeData.dark(),
    );
  }
}
