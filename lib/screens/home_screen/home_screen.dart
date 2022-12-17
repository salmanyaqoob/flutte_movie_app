import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/screens/home_screen/home_controller.dart';

import '../../animation.dart';
import '../../constants.dart';
import '../../widgets/header_text.dart';
import '../../widgets/horizontal_list_cards.dart';
import '../../widgets/movie_home.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen() {
    futureCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Obx(() => loadHomeSections(context)),
        ));
  }

  Widget loadHomeSections(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MoviesPage(
          movies: controller.nowPlayingList,
          isLoading: controller.nowPlayingIsLoading.value,
        ),
        getNowPlayingMovies(1),
        getNowPlayingMovies(2),
        const SizedBox(
          height: 14,
        ),
        getTopRatedMovies(1),
        getTopRatedMovies(2),
        const SizedBox(
          height: 14,
        ),
        getUpComingMovies(1),
        getUpComingMovies(2),
      ],
    );
  }

  Widget getNowPlayingMovies(int section) {
    if (controller.nowPlayingIsLoading.isFalse) {
      if (section == 1) {
        return const DelayedDisplay(
            delay: Duration(microseconds: 800),
            child: HeaderText(text: "In Theaters"));
      } else {
        return HorizontalListViewMovies(
          list: controller.topRatedlist,
        );
      }
    } else {
      return SizedBox();
    }
  }

  Widget getTopRatedMovies(int section) {
    if (controller.topRatedIsLoading.isFalse) {
      if (section == 1) {
        return const DelayedDisplay(
            delay: Duration(microseconds: 800),
            child: HeaderText(text: "Top Rated"));
      } else {
        return DelayedDisplay(
          delay: const Duration(microseconds: 800),
          child: HorizontalListViewMovies(
            list: controller.nowPlayingList,
          ),
        );
      }
    } else {
      return SizedBox();
    }
  }

  Widget getUpComingMovies(int section) {
    if (controller.upComingIsLoading.isFalse) {
      if (section == 1) {
        return const DelayedDisplay(
            delay: Duration(microseconds: 800),
            child: HeaderText(text: "Upcoming"));
      } else {
        return DelayedDisplay(
          delay: const Duration(microseconds: 800),
          child: HorizontalListViewMovies(
            list: controller.upCominglist,
          ),
        );
      }
    } else {
      return SizedBox();
    }
  }

  void futureCall() async {
    controller.loadMovies(MoviesType.nowPlaying.toString());
    controller.loadMovies(MoviesType.topRated.toString());
    controller.loadMovies(MoviesType.upComing.toString());
  }
}
