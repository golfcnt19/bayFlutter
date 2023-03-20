import 'package:bay_flutter1/src/bloc/home/home_bloc.dart';
import 'package:bay_flutter1/src/bloc/management/management_bloc.dart';
import 'package:bay_flutter1/src/constants/network_api.dart';
import 'package:bay_flutter1/src/pages/app_routes.dart';
import 'package:bay_flutter1/src/pages/home/home_page.dart';
import 'package:bay_flutter1/src/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/login/login_bloc.dart';

final formatCurrency = NumberFormat('#,###.000');
final formatNumber = NumberFormat('#,###');
final navigatorState = GlobalKey<NavigatorState>();

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    colors: true,
  ),
);

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // HOC -- Higher Order Widget
  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider<LoginBloc>(create: (context) => LoginBloc());
    final homeBloc = BlocProvider<HomeBloc>(create: (context) => HomeBloc());
    final managementBloc = BlocProvider<ManagementBloc>(create: (context) => ManagementBloc());

    return MultiBlocProvider(
      providers: [
        homeBloc,
        loginBloc,
        managementBloc,
      ],
      child: MaterialApp(
        title: "App",
        navigatorKey: navigatorState,
        routes: AppRoute.all,
        home: _buildInitialPage(),
      ),
    );
  }

  _buildInitialPage() {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        // return loading page while processing...
        if (!snapshot.hasData) return const SizedBox();
        final token = snapshot.data!.getString(NetworkAPI.token);
        return token != null ? const HomePage() : const LoginPage();
      },
    );
  }
}
