import 'package:androidstudio_flutter/app/routes/app.routes.dart';
import 'package:androidstudio_flutter/core/notifier/authentication.notifier.dart';
import 'package:androidstudio_flutter/meta/views/authentication/forgetpassword.view.dart';
import 'package:androidstudio_flutter/meta/views/home/uber.view.dart';
import 'package:flutter/material.dart';
import 'package:androidstudio_flutter/core/notifier/database.notifier.dart';
// import 'package:androidstudio_flutter/core/service/database.service.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController enrollController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    enrollController = TextEditingController();
    mobileController = TextEditingController();
    super.initState();
  }

  Widget build(BuildContext context) {
    final DatabaseNotifier databaseNotifier =
        Provider.of<DatabaseNotifier>(context, listen: false);
    final AuthenticationNotifier authenticationNotifier =
        Provider.of<AuthenticationNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up View"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Full Name"),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: enrollController,
              decoration: InputDecoration(hintText: "Enrollment Number"),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: mobileController,
              decoration: InputDecoration(hintText: "Mobile Number"),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Enter email"),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(hintText: "Enter password"),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  String email = emailController.text;
                  String password = passwordController.text;
                  String name = nameController.text;
                  String Enroll = enrollController.text;
                  String number = mobileController.text;

                  if (email.isNotEmpty &&
                      password.isNotEmpty &&
                      name.isNotEmpty &&
                      Enroll.isNotEmpty &&
                      number.isNotEmpty) {
                    await authenticationNotifier.signup(
                        context: context,
                        email: email,
                        password: password,
                        name: name,
                        Enroll: Enroll,
                        Mobilenumber: number);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Fill the credentials")));
                  }

                  // databaseNotifier.adduser(name:nameController.text,Enroll: enrollController.text, mobile: mobileController.text , email: emailController.text,password: passwordController.text);
                },
                child: Text("Signup")),
            SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.LoginRoute);
                },
                child: Text("Already have an account? Login")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => uber(),
                    ),
                  );
                },
                child: Text("uber")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerifyOTPPage(),
                    ),
                  );
                },
                child: Text("Forgot password"))
          ],
        ),
      ),
    );
  }
}
