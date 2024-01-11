import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:androidstudio_flutter/core/notifier/database.notifier.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:supabase_flutter/src/supabase.dart';
import 'package:provider/provider.dart' as prov;

import '../../../app/credentials/supabase.credentials.dart';
// import 'package:flutter_rounded_date_picker/rounded_picker.dart';

// void _showTimePicker() {
//   d.DatePicker.showPicker(
//     context,
//     pickerMode: d.DateTimePickerMode.time,
//     onConfirm: (time) {
//       setState(() {
//         _timeController.text = DateFormat('hh:mm a').format(time);
//       });
//     },
//   );
// }

class NewRequestView extends StatefulWidget {
  const NewRequestView({Key? key}) : super(key: key);

  @override
  State<NewRequestView> createState() => _NewRequestViewState();
}

class _NewRequestViewState extends State<NewRequestView> {
  late DateTime _selectedTime;
  late String _formattedtime = DateFormat('hh:mm a').format(DateTime.now());
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  void initState() {
    super.initState();
    _selectedTime = DateTime.now();
  }

  void _showTimePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: _selectedTime,
            use24hFormat: false,
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                _selectedTime = newDateTime;
                String formattedTime =
                    DateFormat('hh:mm a').format(_selectedTime);
                _formattedtime = formattedTime;
              });
            },
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    final DatabaseNotifier databaseNotifier =
        prov.Provider.of<DatabaseNotifier>(context, listen: false);
    return Scaffold(
      backgroundColor: CupertinoDynamicColor.withBrightness(
        color: CupertinoColors.black,
        darkColor: CupertinoColors.black,
      ),
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _pickupController,
                    // obscureText: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Pickup Location"),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _destinationController,
                    // obscureText: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Where To?"),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),

            // GestureDetector(
            //   onTap: () {
            //     DatePicker.showDatePicker(context,
            //         showTitleActions: true,
            //         minTime: DateTime(2018, 3, 5),
            //         maxTime: DateTime(2019, 6, 7),
            //         onChanged: (date) {
            //           print('change $date');
            //         },
            //         onConfirm: (date) {
            //           print('confirm $date');
            //           _dateController.text = date.toString(); // update the text field value
            //         },
            //         currentTime: DateTime.now(),
            //         locale: LocaleType.en
            //     );
            //   },
            //   child: TextField(
            //     controller: _dateController,
            //     decoration: InputDecoration(
            //         labelText: 'Select date',
            //         labelStyle: TextStyle(color: Colors.blue),
            //         border: OutlineInputBorder()
            //     ),
            //     readOnly: true, // make the text field read-only to prevent manual input
            //   ),
            // ),

            TextButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2020, 3, 5),
                      maxTime: DateTime(2024, 6, 7), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    print('confirm $date');
                    // String formattedDate = date.format('yyyy-MM-dd');
                    String formattedDate =
                        DateFormat('dd-MM-yyyy EEEE').format(date);
                    print(formattedDate);

                    setState(() {
                      _dateController.text = formattedDate;
                      //   // DateTime date1=DateFormat.jm().parse(date.format(context).toString());
                      //
                      //   // _dateController.text = date as String; //set the value of text field.
                      //   // print(timeController.text);
                      //   // print(_dateController.text);
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Text(
                  'When u wanna go',
                  style: TextStyle(color: Colors.blue),
                )),
            TextButton(
              onPressed: _showTimePicker,
              child: Text(
                'Select Time: ${_formattedtime}',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: () {
                  final supabase = SupabaseCredentials.supabaseClient;
                  final User? user = supabase.auth.currentUser;

                  print(user?.email);
                  timeController.text = _formattedtime;
                  print(timeController.text);
                  databaseNotifier.create(
                      pickup: _pickupController.text,
                      destination: _destinationController.text,
                      Time: timeController.text,
                      date: _dateController.text);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                    child: Text(
                      'Create',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
