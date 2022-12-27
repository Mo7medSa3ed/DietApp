import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/models/countries.dart';
import 'package:flutter_test_app/pages/splashScrean.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:response/response.dart';
import 'package:easy_localization/easy_localization.dart';

bool isArabic = false;
CountriesModel selectedCountry;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final sc = await getValue(key: 'selectedCountry');
  isArabic = await getboolValue(key: 'isArabic') ?? false;

  final date = DateTime.now();
  final endDate = DateTime.parse("2023-01-01");
  if (date.isAfter(endDate)) {
    exit(0);
  }

  if (sc == null || sc.trim().length == 0) {
    await getCountriesData();
  } else {
    selectedCountry = CountriesModel.fromJson(jsonDecode(sc));
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
        // dp.DevicePreview(
        // builder: (context) =>
        EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: Locale('en'),
      startLocale: Locale(isArabic ? 'ar' : 'en'),
      child: MyApp(), // Wrap your app
      // ),
    ));
  });
}

getCountriesData() async {
  final response = await API.getCountries();

  if (response == 'error') return exit(0);
  if (response != null) {
    if (response['success']) {
      if (response['data'].length > 0) {
        selectedCountry = CountriesModel.fromJson(response['data'][0]);
      } else {
        return exit(0);
      }

      await saveCountry();
    }
  }
}

saveCountry() async {
  await setValue(
      key: 'selectedCountry', value: jsonEncode(selectedCountry.toMap()));
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
                fontFamily: isArabic ? 'SSTArabic' : 'Nexa',
                primaryColor: kprimary,
                splashColor: kprimary.withOpacity(0.1),
                indicatorColor: kprimary,

                colorScheme: ColorScheme.light(
                  primary: kprimary2, // header background color
                ),
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
