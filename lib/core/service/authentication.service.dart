// import 'dart:ffi';

import '../../app/credentials/supabase.credentials.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

import '../../app/routes/app.routes.dart';
import '../notifier/database.notifier.dart';
import 'package:provider/provider.dart' as pw;
class AuthenticationService{

  Future<String?> signup({
    required BuildContext context,
    required String email,
    required String password,
    required String Enroll,
    required String name,
    required String Mobilenumber,


})
async{
      //check if the user is present or not
      final present = await SupabaseCredentials.supabaseClient.from('user').select().eq('email', email).execute();
      if (present.status == 400) {
        // Error executing query
        print('Error checking user:');
      } else {
        final users = present.data as List<dynamic>;

        if (users.isNotEmpty) {
          // User already exists, prompt to sign in
          Navigator.of(context).pushNamed(AppRoutes.LoginRoute);


        }else{
          try {
            var response = await SupabaseCredentials.supabaseClient.auth.signUp(
                email: email, password: password);

            final DatabaseNotifier databaseNotifier=pw.Provider.of<DatabaseNotifier>(context,listen: false);
            databaseNotifier.adduser(Enroll: Enroll, name: name,mobile: Mobilenumber,password: password,email: email,user_id: response.user!.id);

            Navigator.of(context).pushNamed(AppRoutes.HomeRoute);
          }on AuthException catch (e) {
            if (e.statusCode == 200) {
              print("succesful");
            } else {
              // print('Authentication failed with error message: ${e.message}');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
            }
          }
        }
      }
  }
  Future<String?> login({
    required BuildContext context,
    required final String email,
    required final String password,
  })
  async{

      //check if the user is present or not
      final present = await SupabaseCredentials.supabaseClient.from('user').select().eq('email', email).execute();
      if (present.status == 400) {
        // Error executing query
        print('Error checking user:');
      } else {
        final users = present.data as List<dynamic>;

        if (users.isEmpty) {
          // User already exists, prompt to sign in
          Navigator.of(context).pushNamed(AppRoutes.SignupRoute);

        }
        else{
          try {
            final response = await SupabaseCredentials.supabaseClient.auth
                .signInWithPassword(
              email: email,
              password: password,
            );
            Navigator.of(context).pushNamed(AppRoutes.HomeRoute);
          }on AuthException catch (e) {
            if (e.statusCode == 200) {
              print("succesful");
            } else {
              // print('Authentication failed with error message: ${e.message}');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
            }
          }
        }
      }
  }
}