
import'package:get/get.dart';
import 'package:movie/screens/movie_info_screen/movie_info_controller.dart';
import 'package:movie/screens/search_screen/search_controller.dart';

import 'app_controller.dart';


class AppBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AppController>(() => AppController());
    Get.lazyPut<MovieInfoController>(() => MovieInfoController());
    Get.lazyPut<SearchController>(() => SearchController());
  }

}