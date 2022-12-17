import 'package:get/get.dart';
import 'package:movie/screens/movie_info_screen/movie_info_controller.dart';

class MovieInfoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MovieInfoController>(() => MovieInfoController());
  }

}