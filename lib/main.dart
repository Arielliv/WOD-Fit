import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wod_fit/providers/auth.dart';
import 'package:wod_fit/providers/workouts.dart';
import 'package:wod_fit/screens/add_workout_sceen.dart';
import 'package:wod_fit/screens/splash_screen.dart';
import 'package:wod_fit/screens/workouts_overview_screen.dart';

import './screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Workouts>(
          builder: (ctx, auth, prevWorkouts) => Workouts(
            auth.token,
            auth.userId,
            prevWorkouts == null ? [] : prevWorkouts.workouts,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'W.O.D - Fit',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: auth.isAuth
              ? WorkoutsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : LoginScreen(),
                ),
          routes: {
            AddWorkoutScreen.routeName: (ctx) => AddWorkoutScreen(),
          },
        ),
      ),
    );
  }
}
