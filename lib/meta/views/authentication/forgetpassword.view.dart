import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart' as pv;
import '../../../app/credentials/supabase.credentials.dart';
import '../../../core/notifier/authentication.notifier.dart';
import '../../../core/notifier/database.notifier.dart';
class VerifyOTPPage extends StatefulWidget {
  const VerifyOTPPage({Key? key}) : super(key: key);

  @override
  _VerifyOTPPageState createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  final TextEditingController _emailController = TextEditingController();
  final _supabaseClient = SupabaseClient(
      'https://ljjjpxaiskkofopfjvph.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxqampweGFpc2trb2ZvcGZqdnBoIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzY2MjI2MzIsImV4cCI6MTk5MjE5ODYzMn0.7epADfI0pGU814wi1_yaNaFV8OCq137x0EurzwqS7Jw'
  );


  Future<void> _verifyOTP() async {
    final supabase = Supabase.instance;
    final response = await _supabaseClient.auth
        .resetPasswordForEmail(_emailController.text);
    final AuthenticationNotifier authenticationNotifier = pv.Provider.of<AuthenticationNotifier>(context,listen: false);


    final supabase1 = SupabaseCredentials.supabaseClient;

    final User? user = supabase1.auth.currentUser;
    var x=user?.email;
    final data = await supabase1
        .from('user')
        .select()
        .eq('email',user?.email
    );
    if(_emailController.text==x){

      await authenticationNotifier.login(context: context, email: _emailController.text, password: data.data[0]['password']);
      final UserResponse res = await SupabaseCredentials.supabaseClient.auth.updateUser(
        UserAttributes(
          password: 'newpassword',
        ),
      );
      final User? updatedUser = res.user;




    }




    // final response = await supabase.auth.verifyOTP(
    //   token: _otpController.text,
    //   email: _emailController.text,
    //   type: OtpType.recovery,
    // );
    // Handle response here
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseNotifier databaseNotifier=pv.Provider.of<DatabaseNotifier>(context,listen: false);



    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
          ),

          ElevatedButton(
            onPressed: _verifyOTP,
            child: const Text('Verify OTP'),
          ),
        ],
      ),
    );
  }
}
