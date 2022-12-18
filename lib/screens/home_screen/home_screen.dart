import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/screens/home_screen/home_controller.dart';
import 'package:shimmer/shimmer.dart';

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
        loadHomeSlider(context),
        getNowPlayingMovies(1, context),
        getNowPlayingMovies(2, context),
        const SizedBox(
          height: 14,
        ),
        getTopRatedMovies(1, context),
        getTopRatedMovies(2, context),
        const SizedBox(
          height: 14,
        ),
        getUpComingMovies(1, context),
        getUpComingMovies(2, context),
      ],
    );
  }

  Widget loadHomeSlider(BuildContext context) {
    if (controller.nowPlayingIsLoading.isFalse) {
      return MoviesPage(
        movies: controller.nowPlayingList,
        isLoading: controller.nowPlayingIsLoading.value,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 80),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          period: const Duration(milliseconds: 1500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                width: double.infinity,
                height: 200.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                width: double.infinity,
                height: 20.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                width: double.infinity,
                height: 14.0,
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget getNowPlayingMovies(int section, BuildContext context) {
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
      if(section == 1) {
        return const DelayedDisplay(
          delay: Duration(microseconds: 800),
          child: HeaderText(text: "In Theaters"));
      }
      return loadMoviesShimmer(context);
    }
  }

  Widget getTopRatedMovies(int section, BuildContext context) {
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
      if(section == 1) {
        return const DelayedDisplay(
            delay: Duration(microseconds: 800),
            child: HeaderText(text: "Top Rated"));
      }
      return loadMoviesShimmer(context);
    }
  }

  Widget getUpComingMovies(int section, BuildContext context) {
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
      if(section == 1) {
        return const DelayedDisplay(
            delay: Duration(microseconds: 800),
            child: HeaderText(text: "Upcoming"));
      }
      return loadMoviesShimmer(context);
    }
  }


  Widget loadMoviesShimmer(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        period: const Duration(milliseconds: 1500),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 150.0,
                  width: (MediaQuery.of(context).size.width / 2) - 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 20.0,
                  width: (MediaQuery.of(context).size.width / 2) - 30,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
            ),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 150.0,
                  width: (MediaQuery.of(context).size.width / 2) - 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 20.0,
                  width: (MediaQuery.of(context).size.width / 2) - 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void futureCall() async {
    controller.loadMovies(MoviesType.nowPlaying.toString());
    controller.loadMovies(MoviesType.topRated.toString());
    controller.loadMovies(MoviesType.upComing.toString());
  }
}
