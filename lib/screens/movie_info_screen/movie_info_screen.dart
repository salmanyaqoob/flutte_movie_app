import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/screens/home_screen/home_controller.dart';
import 'package:movie/screens/movie_info_screen/movie_info_controller.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../animation.dart';
import '../../constants.dart';
import '../../widgets/draggable_sheet.dart';
import '../../widgets/header_text.dart';
import '../../widgets/horizontal_list_cards.dart';
import '../../widgets/like_button.dart';
import '../../widgets/movie_home.dart';
import '../../widgets/star_icon_display.dart';

class MovieInfoScreen extends GetView<MovieInfoController> {
  final String? id;
  final String? backdrop;
  MovieInfoModel? movieData;

  MovieInfoScreen({this.backdrop, this.id}) {
    futureCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Obx(() => loadMovieSection(context)));
  }

  Widget loadMovieSection(BuildContext context) {
    if (controller.movieInfoState.value == MovieInfoState.loaded.toString()) {
      return MovieDetailScreenWidget(
        info: movieData!,
        backdrop: backdrop!,
        isLoading: false,
      );
    } else if (controller.movieInfoState.value ==
        MovieInfoState.error.toString()) {
      return const Scaffold();
    } else if (controller.movieInfoState.value ==
        MovieInfoState.loading.toString()) {

      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.grey.shade700,
            strokeWidth: 2,
            backgroundColor: Colors.cyanAccent,
          ),
        ),
      );
    }

    return const Scaffold();
  }

  void futureCall() async {
    controller.movieInfoState.value = MovieInfoState.loading.toString();
    print("movie id: $id");
    print("movie backdrop: $backdrop");
    movieData = await controller.loadMovieData(id!);
  }
}

class MovieDetailScreenWidget extends StatelessWidget {
  final MovieInfoModel info;
  final String backdrop;
  final bool isLoading;

  const MovieDetailScreenWidget({
    Key? key,
    required this.info,
    required this.backdrop,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MovieInfoController>();
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(info.poster),
              fit: BoxFit.cover,
              alignment: Alignment.topLeft,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 50),
            child: Container(
              color: Colors.black.withOpacity(.5),
              child: Stack(
                // physics: BouncingScrollPhysics(),
                children: [
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          // pushNewScreen(
                          //   context,
                          //   ViewPhotos(
                          //     imageIndex: 0,
                          //     color: Theme.of(context).primaryColor,
                          //     imageList: backdrops,
                          //   ),
                          // );
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * (1 - 0.63),
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl: info.backdrops,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CreateIcons(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(
                                  CupertinoIcons.back,
                                  color: Colors.white,
                                ),
                              ),
                              CreateIcons(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor:
                                    const Color.fromARGB(255, 30, 34, 45),
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return Container(
                                        color: Colors.black26,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(
                                              height: 14,
                                            ),
                                            Container(
                                              height: 5,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(20),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  info.title,
                                                  style: normalText.copyWith(
                                                      color: Colors.white),
                                                ),
                                                Divider(
                                                  height: .5,
                                                  thickness: .5,
                                                  color: Colors.grey.shade800,
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                ListTile(
                                                  onTap: () {
                                                    launch(
                                                        "https://www.themoviedb.org/movie/" +
                                                            info.tmdbId);
                                                  },
                                                  leading: Icon(
                                                    CupertinoIcons.share,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  title: Text(
                                                    "Open in Brower ",
                                                    style: normalText.copyWith(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Divider(
                                                  height: .5,
                                                  thickness: .5,
                                                  color: Colors.grey.shade800,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  CupertinoIcons.ellipsis,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  BottomInfoSheet(
                    backdrops: info.backdrops,
                    child: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 1,
                              child: DelayedDisplay(
                                delay: const Duration(microseconds: 500),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: kElevationToShadow[8],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                        imageUrl: info.poster, width: 120),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    DelayedDisplay(
                                      delay: const Duration(microseconds: 700),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: info.title,
                                              style:
                                              heading.copyWith(fontSize: 22),
                                            ),
                                            TextSpan(
                                              text:
                                              " (${info.releaseDate.split("-")[0]})",
                                              style: heading.copyWith(
                                                color:
                                                Colors.white.withOpacity(.8),
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    DelayedDisplay(
                                      delay: const Duration(microseconds: 700),
                                      child: Text(
                                        (info.genres.isNotEmpty)
                                            ? info.genres[0]
                                            : "",
                                        style: normalText.copyWith(
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    DelayedDisplay(
                                      delay: const Duration(microseconds: 700),
                                      child: Row(
                                        children: [
                                          IconTheme(
                                            data: const IconThemeData(
                                              color: Colors.amber,
                                              size: 20,
                                            ),
                                            child: StarDisplay(
                                              value: ((info.rateing * 5) / 10)
                                                  .round(),
                                            ),
                                          ),
                                          Text(
                                            "  " +
                                                info.rateing.toString() +
                                                "/10",
                                            style: normalText.copyWith(
                                              color: Colors.amber,
                                              letterSpacing: 1.2,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    DelayedDisplay(
                                      delay: const Duration(microseconds: 800),
                                      child: Obx(() => LikeButton(
                                        favoriteModel:
                                        controller.movieFav.value,
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      if (info.overview != '')
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DelayedDisplay(
                                  delay: const Duration(microseconds: 800),
                                  child: Text("Overview",
                                      style:
                                      heading.copyWith(color: Colors.white))),
                              const SizedBox(height: 10),
                              DelayedDisplay(
                                delay: const Duration(microseconds: 1000),
                                child: ReadMoreText(
                                  info.overview,
                                  trimLines: 6,
                                  colorClickableText: Colors.pink,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'more',
                                  trimExpandedText: 'less',
                                  style: normalText.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  moreStyle: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  String k_m_b_generator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }
}

class CreateIcons extends StatelessWidget {
  final Widget child;
  final Function()? onTap;

  const CreateIcons({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: kElevationToShadow[2],
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 50),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(.5),
            ),
            child: InkWell(onTap: onTap, child: child),
          ),
        ),
      ),
    );
  }
}
