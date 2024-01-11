import 'package:androidstudio_flutter/core/service/database.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:supabase/supabase.dart';

class DatabaseNotifier extends ChangeNotifier {
  final DatabaseService _databaseService = new DatabaseService();

  Future fetchTodo() async {
    await _databaseService.fetchTodo();
  }

  Future<PostgrestResponse?> addTodo(
      {required String Enroll,
      required String Name,
      required String mobile}) async {
    await _databaseService.addTodo(
        Enroll: Enroll,
        name: Name,
        mobile: mobile,
        email: 'email',
        password: 'password');
  }

  Future<PostgrestResponse?> create(
      {required String pickup,
      required String destination,
      required String Time,
      required String date}) async {
    await _databaseService.create(
        pickup: pickup, destination: destination, Time: Time, date: date);
  }

  Future fetch_new_rides() async {
    await _databaseService.fetch_new_rides();
  }

  Future<PostgrestResponse?> adduser(
      {required String Enroll,
      required String name,
      required String mobile,
      required String email,
      required String password,
      required String user_id}) async {
    await _databaseService.adduser(
        Enroll: Enroll,
        name: name,
        mobile: mobile,
        email: email,
        password: password,
        user_id: user_id);
  }

  Future<PostgrestResponse?> pairuser({required String parentenroll}) async {
    await _databaseService.pairuser(parentenroll: parentenroll);
  }

  Future<PostgrestResponse?> login(
      {required String email, required String password}) async {
    await _databaseService.login(email: email, password: password);
  }
}
