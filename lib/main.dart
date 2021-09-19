import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/splashScrean.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:response/response.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
        // dp.DevicePreview(
        // builder: (context) =>
        EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: Locale('en'),
      startLocale: Locale('ar'),
      child: MyApp(), // Wrap your app
      // ),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (_) => AppProvider(),
        ),
      ],
      child: Response(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: 'Diet App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Nexa',
                primaryColor: kprimary,
                splashColor: kprimary,
                indicatorColor: kprimary,
                // ignore: deprecated_member_use
                accentColor: kprimary,
                inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(
                        color: kprimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    hintStyle: TextStyle(fontSize: 14)),
                textSelectionTheme: TextSelectionThemeData(
                  selectionHandleColor: kprimary,
                  cursorColor: kprimary,
                ),
                scaffoldBackgroundColor: kcolor1,
              ),
              home: SplashScrean()),
        ),
      ),
    );
  }
}
