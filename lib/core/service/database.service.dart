// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:androidstudio_flutter/app/credentials/supabase.credentials.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase/supabase.dart';

class DatabaseService {
  //Fetching Data

  Future<PostgrestResponse?> fetchTodo() async {
    try {
      final supabase = SupabaseCredentials.supabaseClient;
      final User? user = supabase.auth.currentUser;

      print(user?.email);
      final data =
          await supabase.from('user').select().eq('email', user?.email);
      // var response =await SupabaseCredentials.supabaseClient.from("user").select().execute();
      print(data.data);
      // print(len(response.data))

      // print(response.data[0]['Name']);
      // print(response.data[0]['Enrollment Number']);
      // print(response.data[0]['Mobile Number']);
      // print(response.data[0]['email']);
      // print(response.data[0]['Name']);
      // print(response.data[0]['password']);
      // return response.data;
    } catch (e) {
      print(e.toString());
    }
  }
  // Future<PostgrestResponse?> logincheck({required String email}) async {
  //   try{
  //     var response =await SupabaseCredentials.supabaseClient.from("user").select().where("");
  //   }catch(e){
  //     print(e.toString());
  //   }

  Future<PostgrestResponse?> update_name({required String name}) async {
    try {
      final supabase = SupabaseCredentials.supabaseClient;
      final User? user = supabase.auth.currentUser;

      print(user?.email);
      final data =
          await supabase.from('user').select().eq('email', user?.email);

      final res = await SupabaseCredentials.supabaseClient
          .from('user')
          .update({'Name': name}).match({'email': user?.email}).execute();
    } catch (e) {
      print(e.toString());
    }
  }

  // }
  //!creating data
  Future<PostgrestResponse?> addTodo(
      {
      // required String title,
      required String Enroll,
      required String name,
      required String mobile,
      required String email,
      required String password}) async {
    try {
      PostgrestResponse? response =
          await SupabaseCredentials.supabaseClient.from("user").insert({
        "Enrollment Number": Enroll,
        "Name": name,
        "Mobile Number": mobile,
        'email': email,
        'password': password
      });
      if (response?.data != null) {
        print(response?.data);
      }

      // else{
      //   print(response.error);
      // }
    } catch (e) {
      print(e.toString());
    }

    // required String title,
    // required String description,
  }

  Future<PostgrestResponse?> create({
    // required String title,
    required String pickup,
    required String destination,
    required String Time,
    required String date,
  }) async {
    try {
      // SupabaseCredentials.supabaseClient
      // final response = await SupabaseCredentials.supabaseClient.from('my_table').insert({
      //   'enrollment': Enroll,
      //   'pickup': pickup,
      //   'destination': destination,
      //   'time':Time
      // }).execute();
      //
      // if (response.error != null) {
      //   // Handle error
      // } else {
      //   try {
      //     final id = response.data[0]['id'] as int;
      //     final selectResponse = await SupabaseCredentials.supabaseClient.from(
      //         'user').select().eq('id', id).execute();
      //   }
      //   else {
      //     final insertedRecord = selectResponse.data[0];
      //     print('Inserted record: $insertedRecord');
      //   }
      // }
      final supabase = SupabaseCredentials.supabaseClient;
      final User? user = supabase.auth.currentUser;

      var x = user?.id;
      final enroll = await SupabaseCredentials.supabaseClient
          .from('user')
          .select('EnrollmentNumber')
          .eq('user_id', x)
          .execute();
      String en = enroll.data[0]['EnrollmentNumber'];

      // final response_driver = await SupabaseCredentials.supabaseClient
      //     .from("Driver_basic_info")
      //     .insert({"enrollment":en,"fullname":fullname,"email":email,"time":Time,"dob":date
      // }).select();
      //
      //

      // final response_driver = await SupabaseCredentials.supabaseClient
      //     .from("driver_vehicle_info")
      //     .insert({"enrollment":en,"driver_id":response.data[0]['id'],"vehicle_type":vehicle_type,"vehicle_num":vehicle_num
      // }).select();

      final response_ride_booking =
          await SupabaseCredentials.supabaseClient.from("ride_booking").insert({
        "enrollment": en,
        "pickup": pickup,
        "destination": destination,
        "time": Time,
        "Date": date
      }).select();

      print("response data in createeee --------------------->>>>>");
      int id = response_ride_booking[0]['ride_id'];
      if (response_ride_booking != null) {
        print("in ifff ------->>>>>>>");
        print(response_ride_booking);
      }
      List<String> paired_enroll = [];
      paired_enroll.add(en);

      final responseBooking = await SupabaseCredentials.supabaseClient
          .from("booking")
          .insert({
        "parentenroll": en,
        "ride_id": id,
        "paired_enroll": paired_enroll,
        "counter": 1
      });
      if (responseBooking?.data != null) {
        print(responseBooking?.data);
      }

      final response = await SupabaseCredentials.supabaseClient
          .from('booking')
          .select()
          .eq('ride_id', id)
          .execute();

      int id_chatroom = response.data[0]['id'];

      final chatroom_ride_booking = await SupabaseCredentials.supabaseClient
          .from("chatroom_profile")
          .insert({
        "sender_prof": paired_enroll,
        "reciever_prof": paired_enroll,
        "booking_id": id_chatroom
      }).select();

      // else{
      //   print(response.error);
      // }
    } catch (e) {
      print(e.toString());
    }
    // required String title,
    // required String description,
  }

  Future fetch_new_rides() async {
    try {
      var response = await SupabaseCredentials.supabaseClient
          .from("ride_booking")
          .select()
          .execute();
      return response.data;
    } catch (e) {
      // print(e.toString());
      // return e;
      return e;
    }
  }

  Future<PostgrestResponse?> adduser(
      {
      // required String title,
      required String Enroll,
      required String name,
      required String mobile,
      required String email,
      required String password,
      required String user_id}) async {
    try {
      PostgrestResponse? response =
          await SupabaseCredentials.supabaseClient.from("user").insert({
        "EnrollmentNumber": Enroll,
        "Name": name,
        "Mobile Number": mobile,
        "email": email,
        "password": password,
        "user_id": user_id
      });

      if (response?.data != null) {
        print(response?.data);
      }

      // else{
      //   print(response.error);
      // }
    } catch (e) {
      print(e.toString());
    }

    // required String title,
    // required String description,
  }

  Future<PostgrestResponse?> pairuser({
    // required String title,
    required String parentenroll,
    // required String pairedenroll,
    // required int counter
  }) async {
    try {
      final supabase = SupabaseCredentials.supabaseClient;
      final User? user = supabase.auth.currentUser;

      var em = user?.email;

      var response = await SupabaseCredentials.supabaseClient
          .from("user")
          .select()
          .execute();

      int len = response.data.length;
      var enroll;
      for (int i = 0; i < len; i++) {
        if (em == response.data[i]['email']) {
          enroll = response.data[i]['Enrollment Number'];
        }
      }
      print(enroll);

      var book = await SupabaseCredentials.supabaseClient
          .from("booking")
          .select()
          .execute();
      int book_len = book.data.length;
      for (int i = 0; i < book_len; i++) {
        if (enroll == book.data[i]['parentenroll']) {
          try {
            // PostgrestResponse? response =await SupabaseCredentials.supabaseClient
            //     .from("user")
            //     .insert({"parentenroll":enroll, "pairedenroll": , "Mobile Number":mobile, "email":email, "password":password
            //
            // });
            var arr = [];
            arr = book.data[i]['pairedenroll'];
            arr.add(enroll);

            final res = await SupabaseCredentials.supabaseClient
                .from('booking')
                .update({'pairedenroll': arr}).match(
                    {'': 'Auckland'}).execute();

            if (response?.data != null) {
              print(response?.data);
            }

            // else{
            //   print(response.error);
            // }
          } catch (e) {
            print(e.toString());
          }
        }
      }

      for (int i = 0; i < len; i++) {
        int len1 = response.data[i]['pairedenroll'];
        if (len1 < 4) {
          List<String> pairedenrolltemp = [];
          pairedenrolltemp = response.data[i]['pairedenroll'];
          pairedenrolltemp.add(parentenroll);
          int counter = response.data[i]['counter'];
          for (int j = 0; j < len1; j++) {
            if (parentenroll == response.data[i]['pairedenroll'][j]) {
              PostgrestResponse? response = await SupabaseCredentials
                  .supabaseClient
                  .from("booking")
                  .insert({
                "pairedenroll": pairedenrolltemp,
                "parentenroll": parentenroll,
                "counter": counter + 1,
              });
              final table = 'ride_booking';
              final condition =
                  'enrollment = $parentenroll'; // Example condition, replace with your own.
              // final response1 = await supabase.from(table).select().eq('column-name', 1).execute();

              // final res = await client.from('my_table').update({'age': 30}).eq('id', 1).execute();
              // var response1 =await SupabaseCredentials.supabaseClient.from("ride_booking").update({'counter':counter+1}).eq('enrollment',parentenroll).execute();
            }
          }
        } else {
          print("rides full");
        }
      }

      if (response?.data != null) {
        print(response?.data);
      }

      // else{
      //   print(response.error);
      // }
    } catch (e) {
      print(e.toString());
    }

    // required String title,
    // required String description,
  }

  Future<PostgrestResponse?> login(
      {
      // required String title,
      required String email,
      required String password}) async {
    try {
      var response = await SupabaseCredentials.supabaseClient
          .from("user")
          .select()
          .execute();
      int len = response.data.length;
      for (int i = 0; i < len; i++) {
        if (response.data[i]['email'] != email) {
          print("go to signup");
        } else {
          print("email okk");
          if (response.data[i]['password'] == password) {
            print("Logged in");
          }
        }
      }
      if (response?.data != null) {
        print(response?.data);
      }
      // else{
      //   print(response.error);
      // }
    } catch (e) {
      print(e.toString());
    }
    // required String title,
    // required String description,
  }
}
// [{id: 2, created_at: 2023-02-18T13:55:50.295602+00:00, title: hi, description: hi}, {id: 9, created_at: 2023-02-18T13:56:59.773292+00:00, title: hi, description: hi my name is vinay}]