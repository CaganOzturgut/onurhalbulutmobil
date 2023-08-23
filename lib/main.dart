import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:onurhalbulutmobil/dto/loginRequestDto.dart';
import 'package:onurhalbulutmobil/pages/loginpage.dart';
import 'package:onurhalbulutmobil/src/config/app_settings.dart';
import 'package:onurhalbulutmobil/src/config/routes.dart';

import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterSecureStorage.setMockInitialValues({});
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(OnurHalBulutApp());
}

class OnurHalBulutApp extends StatelessWidget {
  static late LoginRequestDto2 userDto;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        // Desteklenen diller buraya eklenmeli
        const Locale('en', 'US'), // Örnek: İngilizce (ABD)
        const Locale('tr', 'TR'), // Örnek: Türkçe (Türkiye)
      ],
      routes: onurhalroutes,
      title: OnurHalBulutAppSetting.ProjectName,
      debugShowCheckedModeBanner: false,
      initialRoute: RouterSettings.root,
      // home: AnimatedSplashScreen(
      //   splash: Image.asset("assets/images/logo.jpg"),
      // duration: 4000,
      // splashIconSize: 250,
      //   nextScreen: Login(),)
      home: Login(),
    );
  }
}

