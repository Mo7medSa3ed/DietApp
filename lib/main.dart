import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/login.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:response/response.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      // dp.DevicePreview(
      // builder: (context) =>
      MyApp(), // Wrap your app
      // ),
    );
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
            //locale: dp.DevicePreview.of(context).locale,
            //
            title: 'Diet App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Nexa',
              primaryColor: kprimary,
              splashColor: kprimary,
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
                //selectionColor: kprimary,
              ),
              scaffoldBackgroundColor: kcolor1,
            ),
            home: LoginScrean(),
          ),
        ),
      ),
    );
  }
}
