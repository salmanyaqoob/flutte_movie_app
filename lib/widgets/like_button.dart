import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/movie_model.dart';
import '../screens/movie_info_screen/movie_info_controller.dart';

class LikeButton extends StatelessWidget {
  final FavoriteModel favoriteModel;
  const LikeButton({
    Key? key,
    required this.favoriteModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MovieInfoController>();
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: kElevationToShadow[2]),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 50),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.5),
              ),
              child: InkWell(
                onTap: () {
                  controller.makeMovieFav(favoriteModel);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      (!this.favoriteModel.isLike)?
                      const Icon(
                        CupertinoIcons.heart,
                        color: Colors.white,
                        size: 30,
                      ):const Icon(
                        CupertinoIcons.heart_solid,
                        color: Colors.amber,
                        size: 30,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        (!this.favoriteModel.isLike)?"Add to Favorite":"Your favorite",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
