import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie/constants.dart';
import 'package:movie/data/remote/api_services.dart';

import '../../models/movie_model.dart';

class MovieInfoController extends GetxController {
  var movieInfoState = MovieInfoState.loading.toString().obs;
  var movieFav = FavoriteModel(isLike: false).obs;

  Future<MovieInfoModel?> loadMovieData(String id) async {
    print("movieInfoState: ${MovieInfoState.loaded.toString()}");
    print("movieInfoState: ${movieInfoState.value}");
    MovieInfoModel? movies = await ApiService().getMovieInfo(id);
    if (movies != null) {
      movieInfoState.value = MovieInfoState.loaded.toString();
      print("movieInfoState: ${movieInfoState.value}");
      var box = Hive.box('Favorites');
      final isLiked = box.get(movies.tmdbId);
      print("isLiked: $isLiked");
      movieFav.update((fav) {
        fav?.id = movies.tmdbId;
        fav?.title = movies.title;
        fav?.poster = movies.poster;
        fav?.rating = movies.rateing;
        fav?.date = movies.releaseDate;
        fav?.type = "MOVIE";
        fav?.isLike = (isLiked == null) ? false : true;
      });
    }
    //movieData.value = movies as MovieInfoModel;
    return movies;
  }

  Future<void> makeMovieFav(FavoriteModel favoriteModel) async{
    var box = Hive.box('Favorites');
    if (favoriteModel.isLike) {
      box.delete(favoriteModel.id);
    } else {
      box.put(favoriteModel.id, {
        'id': favoriteModel.id,
        'title': favoriteModel.title,
        'poster': favoriteModel.poster,
        'rating': favoriteModel.rating,
        'type': favoriteModel.type,
        'date': favoriteModel.date,
        'isLiked': favoriteModel.isLike,
      });
    }
    movieFav.update((fav) {
      fav = favoriteModel;
      fav.isLike = (favoriteModel.isLike)?false:true;
    });
  }
}
