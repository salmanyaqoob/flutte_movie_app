
import'package:get/get.dart';
import 'package:movie/screens/splash_screen/splash_controller.dart';


class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }

}