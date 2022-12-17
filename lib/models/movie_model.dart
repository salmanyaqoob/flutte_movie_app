import 'formated_time_genrator.dart';

class MovieModel {
  final String title;
  final String poster;
  final String id;
  final String backdrop;
  final double voteAverage;
  final String releaseDate;
  MovieModel({
    required this.title,
    required this.poster,
    required this.id,
    required this.backdrop,
    required this.voteAverage,
    required this.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    var string = "Not Available";
    getString() {
      try {
        string =
            "${monthgenrater(json['release_date'].split("-")[1])} ${json['release_date'].split("-")[2]}, ${json['release_date'].split("-")[0]}";
        // ignore: empty_catches
      } catch (e) {}
    }

    getString();
    return MovieModel(
      backdrop: json['backdrop_path'] != null
          ? "https://image.tmdb.org/t/p/w500" + json['backdrop_path']
          : "https://images.pexels.com/photos/4089658/pexels-photo-4089658.jpeg?cs=srgb&dl=pexels-victoria-borodinova-4089658.jpg&fm=jpg",
      poster: json['poster_path'] != null
          ? "https://image.tmdb.org/t/p/w500" + json['poster_path']
          : "https://images.pexels.com/photos/4089658/pexels-photo-4089658.jpeg?cs=srgb&dl=pexels-victoria-borodinova-4089658.jpg&fm=jpg",
      id: json['id'].toString(),
      title: json['title'] ?? '',
      voteAverage: json['vote_average'].toDouble() ?? 0.0,
      releaseDate: string,
    );
  }
}

class MovieModelList {
  final List<MovieModel> movies;
  MovieModelList({
    required this.movies,
  });
  factory MovieModelList.fromJson(List<dynamic> json) {
    return MovieModelList(
        movies: (json).map((list) => MovieModel.fromJson(list)).toList());
  }
}

class MovieInfoModel {
  final String tmdbId;
  final String overview;
  final String title;
  final List languages;
  final String backdrops;
  final String poster;
  final int budget;
  final String tagline;
  final double rateing;
  final String dateByMonth;
  final int runtime;
  final String homepage;
  final String imdbid;
  final List genres;
  final String releaseDate;
  MovieInfoModel({
    required this.tmdbId,
    required this.overview,
    required this.title,
    required this.languages,
    required this.backdrops,
    required this.poster,
    required this.budget,
    required this.tagline,
    required this.rateing,
    required this.dateByMonth,
    required this.runtime,
    required this.homepage,
    required this.imdbid,
    required this.genres,
    required this.releaseDate,
  });
  factory MovieInfoModel.fromJson(json) {
    var string = "";
    getString() {
      try {
        string =
            "${monthgenrater(json['release_date'].split("-")[1])} ${json['release_date'].split("-")[2]}, ${json['release_date'].split("-")[0]}";
        // ignore: empty_catches
      } catch (e) {}
    }

    getString();
    return MovieInfoModel(
      budget: json['budget'],
      title: json['title'] ?? '',
      homepage: json['homepage'] ?? "",
      imdbid: json['imdb_id'] ?? "",
      languages: (json['spoken_languages'] as List)
          .map((laung) => laung['english_name'])
          .toList(),
      genres: (json['genres'] as List).map((laung) => laung['name']).toList(),
      overview: json['overview'] ?? json['actors'] ?? '',
      backdrops: json['backdrop_path'] != null
          ? "https://image.tmdb.org/t/p/original" + json['backdrop_path']
          : "https://images.pexels.com/photos/4089658/pexels-photo-4089658.jpeg?cs=srgb&dl=pexels-victoria-borodinova-4089658.jpg&fm=jpg",
      poster: json['poster_path'] != null
          ? "https://image.tmdb.org/t/p/w500" + json['poster_path']
          : "https://images.pexels.com/photos/4089658/pexels-photo-4089658.jpeg?cs=srgb&dl=pexels-victoria-borodinova-4089658.jpg&fm=jpg",
      rateing: json['vote_average'].toDouble() ?? 0.0,
      runtime: json['runtime'],
      tagline: json['tagline'] ?? json['actors'] ?? '',
      tmdbId: json['id'].toString(),
      releaseDate: json['release_date'] ?? '',
      dateByMonth: string,
    );
  }
}

class FavoriteModel {
  String? id;
  String? title;
  String? poster;
  double? rating;
  String? type;
  String? date;
  bool isLike;
  FavoriteModel({
    this.id,
    this.title,
    this.poster,
    this.rating,
    this.type,
    this.date,
    required this.isLike,
  });
}
