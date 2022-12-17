
import'package:get/get.dart';
import 'package:movie/screens/search_screen/search_controller.dart';


class SearchBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController());
  }

}