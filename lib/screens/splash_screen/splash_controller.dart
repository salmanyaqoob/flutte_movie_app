import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    animationController.forward();
    animationController.repeat(reverse: true);
    super.onInit();
  }
}
