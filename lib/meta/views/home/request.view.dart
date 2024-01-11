import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/app.routes.dart';
import '../../../core/notifier/database.notifier.dart';

class RequestView extends StatefulWidget {
  const RequestView({Key? key}) : super(key: key);

  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  @override
  Widget build(BuildContext context) {
    final DatabaseNotifier databaseNotifier=Provider.of<DatabaseNotifier>(context,listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamed(AppRoutes.newRequestRoute);

            }, child: Text("New Request")



            ),
      ElevatedButton(onPressed: (){
        // Navigator.of(context).pushNamed(AppRoutes.newRequestRoute);
        // print(databaseNotifier.fetch_new_rides()[0]['pickup']);
        // databaseNotifier.fetchTodo();
        Navigator.of(context).pushNamed(AppRoutes.fetchRoute);


      },
        child: Text("Fetch"),
      ),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamed(AppRoutes.newRequestRoute);
              // print(databaseNotifier.fetch_new_rides()[0]['pickup']);



            },
              child: Text("botanical garden"),
            ),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamed(AppRoutes.listviewroute);

            }, child: Text("ListView")



            ),


          ],
        ),
      ),



    );

  }
}
