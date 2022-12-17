import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie/models/movie_model.dart';

import '../../constants.dart';
import 'api_constants.dart';

class ApiService {
  Future<List<MovieModel>?> getMovies(String moviesType) async {
    var pageLink;
    if(moviesType == MoviesType.nowPlaying.toString()){
      pageLink = ApiConstants.nowPlaying;
    } else if(moviesType == MoviesType.topRated.toString()){
      pageLink = ApiConstants.topRated;
    } else if(moviesType== MoviesType.upComing.toString()){
      pageLink = ApiConstants.upcoming;
    }
    print("pageLink: $pageLink");
    List<MovieModel> nowPlayingData;
    var url = Uri.parse(
        ApiConstants.baseUrl + pageLink + ApiConstants.apiKey);
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });
    print("statusCode: ${response.statusCode}");
    print("body: ${response.body}");
    if (response.statusCode >= 200 && response.statusCode < 400) {
      nowPlayingData =
          MovieModelList.fromJson(json.decode(response.body)['results']).movies;
      return nowPlayingData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<MovieInfoModel?> getMovieInfo(String id) async {

    MovieInfoModel movieData;
    var url = Uri.parse(
        ApiConstants.baseUrl + id + ApiConstants.apiKey);
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });
    print("statusCode: ${response.statusCode}");
    print("body: ${response.body}");
    if (response.statusCode >= 200 && response.statusCode < 400) {
      movieData =
          MovieInfoModel.fromJson(json.decode(response.body));
      return movieData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
