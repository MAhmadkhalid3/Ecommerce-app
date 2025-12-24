import 'package:ecommerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app.dart';


void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
      widgetsBinding: widgetsBinding);
  /// Initialize Get Storage
  /// Initialize Firebase
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Preserve splash screen
  runApp(const App());
}

