import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant/data/api/api_service.dart';
import 'package:restaurant/data/db/database_helper.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' show Client;
import 'package:provider/provider.dart';
import 'package:restaurant/utils/background_service.dart';
import 'package:restaurant/utils/notification_helper.dart';
import 'package:restaurant/data/preferences/preferences_helper.dart';
import 'package:restaurant/provider/database_provider.dart';
import 'package:restaurant/provider/preferences_provider.dart';
import 'package:restaurant/provider/restaurant_provider.dart';
import 'package:restaurant/provider/scheduling_provider.dart';
import 'package:restaurant/ui/home_page.dart';
import 'package:restaurant/ui/detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'commons/navigation.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final client = Client();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService(client)),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
      ],

      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) => MaterialApp(
          title: 'Restaurant Yoi',
          theme: provider.themeData,
          builder: (context, child) => CupertinoTheme(
            data: CupertinoThemeData(
              brightness:
              provider.isDarkTheme ? Brightness.dark : Brightness.light,
            ),
            child: Material(
              child: child,
            ),
          ),

          navigatorKey: navigatorKey,
          initialRoute: HomePage.routeName,
          routes: {
            HomePage.routeName: (context) => HomePage(),
            DetailPage.routeName: (context) => DetailPage(
                restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant),
          },
        ),
      ),
    );
  }
}
