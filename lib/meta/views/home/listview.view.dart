import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'listview1.view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final SupabaseClient _client;

  Future<void> _refreshData() async {
    await _client.from('ride_booking').select().execute();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _client = Supabase.instance.client;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supabase Data'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],

      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<PostgrestResponse>(
          future: _client.from('ride_booking').select().execute(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // final records = snapshot.data!.data;
              final records = snapshot.data!.data.reversed.toList();
              return ListView.builder(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  return GestureDetector(
                    onTap: () {
                      print(record['ride_id']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MyRecordPage(recordId: record['ride_id']),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(record['pickup']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const Text("                          >"),

                            Text(record['destination']),

                            const Text("                                                                                                                        >" ),

                            Text(record['time']),

                            const Text("                           >"),

                            Text(record['Date']),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {

              return Text('Error fetching data');

            } else {

              return Center(child: CircularProgressIndicator());

            }
          },
        ),
      ),
    );
  }
}
