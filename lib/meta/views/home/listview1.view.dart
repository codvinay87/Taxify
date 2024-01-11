import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../app/credentials/supabase.credentials.dart';
import 'confirmationpage.view.dart';

class MyRecordPage extends StatefulWidget {
  final int recordId;

  const MyRecordPage({Key? key, required this.recordId}) : super(key: key);

  @override
  _MyRecordPageState createState() => _MyRecordPageState();
}

class _MyRecordPageState extends State<MyRecordPage> {
  late final SupabaseClient _client;
  late Future<PostgrestResponse> _futureRecord;

  @override
  void initState() {
    super.initState();
    _client = Supabase.instance.client;
    _futureRecord = _client
        .from('ride_booking')
        .select()
        .eq('ride_id', widget.recordId)
        .single()
        .execute();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> list=[];

    return Scaffold(
      appBar: AppBar(
        title: Text('My Record'),
      ),
      body: FutureBuilder<PostgrestResponse>(
        future: _futureRecord,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final record = snapshot.data!.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(record['pickup']),
                Text(record['destination']),
                Text(record['time']),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Confirm'),
                  onPressed: () async {
                    print(record['ride_id']);
                    final supabase = SupabaseCredentials.supabaseClient;
                    final User? user = supabase.auth.currentUser;

                    var x=user?.id;
                    final enroll = await SupabaseCredentials.supabaseClient
                        .from('user')
                        .select('EnrollmentNumber')
                        .eq('user_id', x)
                        .execute();

                    String en=enroll.data[0]['EnrollmentNumber'];

                    final response = await SupabaseCredentials.supabaseClient
                        .from('booking')
                        .select()
                        .eq('ride_id', widget.recordId)
                        .execute();


                    List<dynamic> paired_enroll =response.data[0]['paired_enroll'];
                    int booking_id=response.data[0]['id'];


                    int counter=response.data[0]['counter'];
                    if (paired_enroll.contains(en)) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Request already created :)")));
                    } else {
                      paired_enroll.add(en);
                      counter = counter + 1;

                    }


                    final response_update = await SupabaseCredentials.supabaseClient
                        .from('booking')
                        .update({"paired_enroll":paired_enroll,'counter':counter})
                        .eq('ride_id',  widget.recordId )
                        .execute();


                    final response_update_chatroom = await SupabaseCredentials.supabaseClient
                        .from('chatroom_profile')
                        .update({"sender_prof":paired_enroll,"reciever_prof":paired_enroll})
                        .eq('booking_id',  booking_id )
                        .execute();

                    final response_after = await SupabaseCredentials.supabaseClient
                        .from('booking')
                        .select()
                        .eq('ride_id', widget.recordId )
                        .execute();
                    list = response_after.data;
                    print(response_after.data);


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DynamicListPage(items: response_after.data[0]['paired_enroll']),
                      ),
                    );


                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error fetching record');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
