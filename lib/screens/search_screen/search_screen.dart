import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:movie/screens/home_screen/home_screen.dart';
import 'package:movie/screens/search_screen/search_controller.dart';
import 'package:movie/screens/splash_screen/splash_controller.dart';

import '../../constants.dart';

class SearchScreen extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            largeTitle: Text(
              'Search',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            border: Border(
              bottom: BorderSide(
                width: .6,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ValueListenableBuilder<Box>(
                valueListenable: Hive.box('Search').listenable(),
                builder: (context, box, child) {
                  return Container(
                    height: MediaQuery.of(context).size.height * .8,
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_rounded,
                            size: 45,
                            color: Colors.white.withOpacity(.6),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Search is Coming Soon.",
                            style: heading.copyWith(color: Colors.white.withOpacity(.9)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
