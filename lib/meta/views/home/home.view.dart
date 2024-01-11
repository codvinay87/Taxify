import 'package:androidstudio_flutter/core/notifier/database.notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as pr;
import 'package:supabase/supabase.dart';

import '../../../app/credentials/supabase.credentials.dart';
import '../../../app/routes/app.routes.dart';



class seatsLeft extends StatefulWidget {
  final int ride_id ;
  const seatsLeft({Key? key, required this.ride_id}) : super(key: key);

  @override
  State<seatsLeft> createState() => _seatsLeftState();
}

class _seatsLeftState extends State<seatsLeft> {
  int seats=0;
  @override
  void initState() {
    super.initState();
    fetchName();
  }

  void fetchName() async {
    final supabase = SupabaseCredentials.supabaseClient;
    final User? user = supabase.auth.currentUser;

    var x = user?.id;
    try {
      final seat = await SupabaseCredentials.supabaseClient
          .from('booking')
          .select('counter')
          .eq('ride_id', widget.ride_id)
          .execute();
      // print(seat.data[0]);
      var en =seat.data[0]['counter'];
      setState(() {
        seats=en;


      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text("$seats");
  }
}

class NameWidget extends StatefulWidget {
  @override
  _NameWidgetState createState() => _NameWidgetState();
}

class _NameWidgetState extends State<NameWidget> {
  String name1 = " ";

  @override
  void initState() {
    super.initState();

    fetchName();
  }

  void fetchName() async {
    final supabase = SupabaseCredentials.supabaseClient;
    final User? user = supabase.auth.currentUser;

    var x=user?.id;
    try {
      final name = await SupabaseCredentials.supabaseClient
          .from('user')
          .select('Name')
          .eq('user_id', x)
          .execute();
      String en = name.data[0]['Name'];


      setState(() {
        name1 = name.data[0]['Name'] as String;
      });
    }catch(e){
      print(e);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Text(name1);
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    final TextEditingController enrollController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController mobileController = TextEditingController();

    final DatabaseNotifier databaseNotifier=pr.Provider.of<DatabaseNotifier>(context,listen: false);
    Future Add() async {
      databaseNotifier.addTodo(Enroll: enrollController.text, Name: nameController.text,mobile: mobileController.text);
      Navigator.of(context).pushNamed(AppRoutes.RequestRoute);

    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          final supabase = SupabaseCredentials.supabaseClient;
          final User? user = supabase.auth.currentUser;

          print(user?.email);
          print(user);

          // databaseNotifier.fetchTodo();

        },
      ),
      appBar: AppBar(),
        body: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              TextField(
                controller: enrollController,
                decoration: const InputDecoration(label: Text("Enter Enrollment Number: ")),
              ),
              SizedBox(
                height: 15,
              ),
              // NameWidget(),



              seatsLeft(ride_id: 40),




              TextField(
                controller: nameController,
                decoration: InputDecoration(label: Text("Enter Name: ")),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ), TextField(
                controller: mobileController,
                decoration: const InputDecoration(label: Text("Enter Mobile Number :")),
              ),
              ElevatedButton(onPressed: () async {
                final supabase = SupabaseCredentials.supabaseClient;
                final User? user = supabase.auth.currentUser;

               var x=user?.id;
               final enroll = await SupabaseCredentials.supabaseClient
                    .from('user')
                    .select('EnrollmentNumber')
                    .eq('user_id', x)
                    .execute();
                print(enroll.data);
                Navigator.of(context).pushNamed(AppRoutes.RequestRoute);


                // print(x);
              }, child: Text("Add Todo")
              )
            ],
          ),
        ),
    );
  }
}

// I/flutter (16832): Invalid argument(s): No host specified in URI eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxqampweGFpc2trb2ZvcGZqdnBoIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzY2MjI2MzIsImV4cCI6MTk5MjE5ODYzMn0.7epADfI0pGU814wi1_yaNaFV8OCq137x0EurzwqS7Jw/rest/v1/testdb

