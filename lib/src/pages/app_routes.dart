import 'package:bay_flutter1/src/pages/loading/loading_page.dart';
import 'package:bay_flutter1/src/pages/management/management_page.dart';
import 'package:bay_flutter1/src/pages/map/map_page.dart';
import 'package:flutter/material.dart';

import 'home/home_page.dart';
import 'login/login_page.dart';

class AppRoute {
  static const home = 'home';
  static const login = 'login';
  static const management = 'management';
  static const map = 'map';
  static const loading = 'loading';

  static get all => <String, WidgetBuilder>{
        login: (context) => const LoginPage(), // demo how to used widget
        home: (context) => const HomePage(),
        management: (context) => const ManagementPage(),
        map: (context) => MapPage(),
        loading: (context) => const LoadingPage(),
      };
}
