import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/auth.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:response/response.dart';

void main() => runApp(
      //DevicePreview(
      // builder: (context) =>
      MyApp(), // Wrap your app
      // ),
    );

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
        child: MaterialApp(
          //locale: DevicePreview.of(context).locale,
          //builder: DevicePreview.appBuilder,
          title: 'Diet App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Nexa',
            primaryColor: kprimary,
            splashColor: kprimary,
            textSelectionTheme: TextSelectionThemeData( 
              cursorColor: kprimary,
            ),
            scaffoldBackgroundColor: kcolor1,
          ),
          home: AuthScrean(),
        ),
      ),
    );
  }
}
