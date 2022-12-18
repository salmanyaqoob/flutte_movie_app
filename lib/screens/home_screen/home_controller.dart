import 'package:get/get.dart';
import 'package:movie/constants.dart';
import 'package:movie/data/remote/api_services.dart';

import '../../models/movie_model.dart';

class HomeController extends GetxController {
  var pageIndex = 0.obs;
  var nowPlayingIsLoading = true.obs;
  var topRatedIsLoading = true.obs;
  var upComingIsLoading = true.obs;
  var nowPlayingList = <MovieModel>[].obs;
  var topRatedlist = <MovieModel>[].obs;
  var upCominglist = <MovieModel>[].obs;

  void updatePageIndex(var index) {
    print("index $index");
    pageIndex.value = index;
  }

  Future<List<MovieModel>?> loadMovies(String moviesType) async{
    List<MovieModel>? movies = await ApiService().getMovies(moviesType);
    if(moviesType == MoviesType.nowPlaying.toString()){
      await Future.delayed(Duration(seconds: 1));
      nowPlayingList.value = movies as List<MovieModel>;
      nowPlayingIsLoading.value = false;
    } else if(moviesType == MoviesType.topRated.toString()){
      await Future.delayed(Duration(seconds: 2));
      topRatedlist.value = movies as List<MovieModel>;
      topRatedIsLoading.value = false;
    } else if(moviesType== MoviesType.upComing.toString()){
      await Future.delayed(Duration(seconds: 3));
      upCominglist.value = movies as List<MovieModel>;
      upComingIsLoading.value = false;
    }

    return movies;
  }
}
