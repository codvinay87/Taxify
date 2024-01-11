import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../app/routes/app.routes.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({Key? key}) : super(key: key);

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();

}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate to the next page
        Navigator.of(context).pushNamed(AppRoutes.SignupRoute);


      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
            'https://assets2.lottiefiles.com/packages/lf20_Ut9xeSTQIf.json',
            controller: _controller,
            onLoaded: (composition) {
              // Start the animation when the Lottie file is loaded
              _controller..duration = composition.duration;
              _controller.forward();
            }),
      ),
    );
  }
}
