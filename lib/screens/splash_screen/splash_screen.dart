import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lottie/lottie.dart';
import 'package:movie/screens/home_screen/home_screen.dart';
import 'package:movie/screens/splash_screen/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Lottie.asset(
                      'assets/lottie/81986-movie.json',
                      controller: controller.animationController,
                      onLoaded: (composition) {
                        controller.animationController
                          ..duration = composition.duration
                          ..forward().whenComplete(() => {Get.offNamed("/home")});
                      },
                    ),
                  ],
                ),
              ))),
    );
  }
}
