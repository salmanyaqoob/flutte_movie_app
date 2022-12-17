import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie/screens/bottom_nav_bar.dart';
import 'package:movie/screens/home_screen/home_bindings.dart';
import 'package:movie/screens/home_screen/home_screen.dart';
import 'package:movie/screens/movie_info_screen/movie_info_bindings.dart';
import 'package:movie/screens/movie_info_screen/movie_info_screen.dart';
import 'package:movie/screens/search_screen/search_bindings.dart';
import 'package:movie/screens/search_screen/search_screen.dart';
import 'package:movie/screens/splash_screen/splash_bindings.dart';
import 'package:movie/screens/splash_screen/splash_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'app_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('Movies');
  await Hive.openBox('Search');
  await Hive.openBox('Favorites');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // like this movie detail page?
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.black,
        // scaffoldBackgroundColor: const Color(0xFF0C0303),
        primarySwatch: Colors.blue,
        splashColor: Colors.transparent,
        primaryColor: Colors.cyanAccent,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      builder: (context, child) {
        return MediaQuery(
          child: ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: child!,
          ),
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      initialRoute: '/',
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.onlyBuilder,
      getPages: [
        GetPage(
            name: '/', page: () => SplashScreen(), binding: SplashBinding()),
        GetPage(
            name: '/home', page: () => BottomNavBar(), binding: HomeBinding()),
        GetPage(
            name: '/search', page: () => SearchScreen(), binding: SearchBinding()),
        GetPage(
            name: '/movie/:id/:backdrop',
            page: () => MovieInfoScreen(),
            binding: MovieInfoBinding(),
            transition: Transition.zoom
        ),
      ],
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
