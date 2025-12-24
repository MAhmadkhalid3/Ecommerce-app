import 'package:ecommerce/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'features/authentication/screens/on_boarding/on_boarding.dart';
class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  // Add a method to simulate loading and hide the splash screen after a delay
  Future<void> _initializeApp() async {
    FlutterNativeSplash.remove(); // Remove splash screen after delay
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: TAppTheme.LightTheme,
          darkTheme: TAppTheme.DarkTheme,
          home: OnBoarding()),
    );
  }
}