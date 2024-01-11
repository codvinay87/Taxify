import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

import '../../../app/credentials/supabase.credentials.dart';

class fetchView extends StatefulWidget {
  const fetchView({Key? key}) : super(key: key);


  @override
  State<fetchView> createState() => _fetchViewState();
}

class _fetchViewState extends State<fetchView> {
  @override
  Future<List<int>> fetch_new_rides() async {
    try{
      var response =await SupabaseCredentials.supabaseClient.from("ride_booking").select().execute();
      final data = response.data;
      final ids = <int>[];

      for (final row in data) {
        final id = row['ride_id'] as int;
        ids.add(id);
      }
      print("ids in function");
      print(ids);

      return ids;
    }catch(e){
      // print(e.toString());
      // return e;
      print(e);
      final error = <int>[];
      return error;
    }


  }


  Widget build(BuildContext context) {
    List<dynamic> list=[];
    return Scaffold(
      appBar: AppBar(),

      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () async {
              final ride_id = await fetch_new_rides();
              print(ride_id);
              final supabase = SupabaseCredentials.supabaseClient;
              final User? user = supabase.auth.currentUser;

              var x=user?.id;
              final enroll = await SupabaseCredentials.supabaseClient
                  .from('user')
                  .select('EnrollmentNumber')
                  .eq('user_id', x)
                  .execute();
              String en=enroll.data[0]['EnrollmentNumber'];
              // var response =await SupabaseCredentials.supabaseClient.from("booking").select().execute();
              final response = await SupabaseCredentials.supabaseClient
                  .from('booking')
                  .select()
                  .eq('ride_id', ride_id[3])
                  .execute();
              List<dynamic> paired_enroll =response.data[0]['paired_enroll'];
              int counter=response.data[0]['counter'];
              paired_enroll.add(en);
              counter=counter+1;




              final response_update = await SupabaseCredentials.supabaseClient
                  .from('booking')
                  .update({"paired_enroll":paired_enroll,'counter':counter})
                  .eq('ride_id', ride_id[3])
                  .execute();

              final response_after = await SupabaseCredentials.supabaseClient
                  .from('booking')
                  .select()
                  .eq('ride_id', ride_id[3])
                  .execute();
              list= response_after.data;
              print(response_after.data);
            }, child: Text('press kro'),






            ),
          ],
        ),
      ),
    );
  }
}
