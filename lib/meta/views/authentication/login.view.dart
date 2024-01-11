import 'package:androidstudio_flutter/app/routes/app.routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/notifier/authentication.notifier.dart';
import '../../../core/notifier/database.notifier.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState(){
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }
  Widget build(BuildContext context) {
    final DatabaseNotifier databaseNotifier=Provider.of<DatabaseNotifier>(context,listen: false);
    final AuthenticationNotifier authenticationNotifier = Provider.of<AuthenticationNotifier>(context,listen: false);


    return Scaffold(
      appBar: AppBar(title: Text("Login View"),),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Enter email"),

            ),
            SizedBox(height: 10,),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(hintText: "Enter password"),

            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () async {
              String email = emailController.text;
              String password=passwordController.text;
              // email="";
              // password="";
              if(email.isNotEmpty && password.isNotEmpty){
                await authenticationNotifier.login(context: context, email: email, password: password);
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fill the credentials")));
              }


              // databaseNotifier.login(email:emailController.text,password: passwordController.text);



            }, child:
            Text("Login")
            ),
            SizedBox(height: 30,),

            TextButton(onPressed: (){
              Navigator.of(context).pushNamed(AppRoutes.SignupRoute);
            }, child: const Text("New here Sign Up Now"))
            
          ],
        ),
      ),
    );
  }
}
