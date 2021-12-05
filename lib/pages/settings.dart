import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/main.dart';
import 'package:flutter_test_app/models/countries.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsScrean extends StatefulWidget {
  @override
  _SettingsScreanState createState() => _SettingsScreanState();
}

class _SettingsScreanState extends State<SettingsScrean> {
  final scaffoldkey = GlobalKey<ScaffoldState>();

  List<CountriesModel> countries = [];
  List<String> countriesName = [];

  getCountriesData() async {
    final response = await API.getCountries();
    if (response == 'error')
      return Alert.errorAlert(ctx: context, title: errorMsg);
    if (response != null) {
      if (response['success']) {
        countries = (response['data'] ?? [])
            .map<CountriesModel>((e) => CountriesModel.fromJson(e))
            .toList();
        countriesName = countries.map<String>((e) => e.name).toList();
        final selected = await getValue(key: 'selectedCountry');
        if (selected != null) {
          selectedCountry = CountriesModel.fromJson(jsonDecode(selected));
        } else {
          selectedCountry = countries.first;
        }

        setState(() {});
      }
    }
  }

  saveCountry() async {
    await setValue(
        key: 'selectedCountry', value: jsonEncode(selectedCountry.toMap()));
  }

  @override
  void initState() {
    getCountriesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer: buildDrawer(context),
      body: SafeArea(
        child: Column(
          children: [
            buildAppBarForPages(context, tr('setting'),
                () => scaffoldkey.currentState.openDrawer(),
                showProfile: false),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  buldinputContainer(
                    withoutIcon: true,
                    text: tr("lang"),
                    controller: TextEditingController(text: ''),
                    widget: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownSearch<String>(
                          searchBoxDecoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          dropdownSearchDecoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          mode: Mode.MENU,
                          maxHeight: MediaQuery.of(context).size.height * 0.14,
                          dropdownBuilder:
                              (context, selectedItem, itemAsString) => Text(
                                    selectedItem,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18),
                                  ),
                          items: [tr('ar'), tr('en')],
                          popupBackgroundColor: kcolor1.withOpacity(0.9),
                          hint: "Choose your language ...",
                          onChanged: (v) async {
                            final val = v == tr('ar');
                            await setboolValue(key: 'isArabic', value: val);
                            await context.setLocale(Locale(val ? 'ar' : 'en'));

                            setState(() {
                              isArabic = val;
                            });
                            goToWithRemoveUntill(context, HomeScrean());
                          },
                          selectedItem: isArabic ? tr('ar') : tr('en')),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //   child: SwitchListTile.adaptive(
                  //       contentPadding: EdgeInsets.zero,
                  //       title: buildText(isArabic ? 'English' : 'Arabic'),
                  //       value: isArabic,
                  //       onChanged: (bool val) async {
                  //         await setboolValue(key: 'isArabic', value: val);
                  //         context.setLocale(Locale(val ? 'ar' : 'en'));
                  //         setState(() {
                  //           isArabic = val;
                  //         });
                  //       }),
                  // ),
                  SizedBox(height: 16),
                  buldinputContainer(
                    withoutIcon: true,
                    text: tr("country"),
                    controller: TextEditingController(text: ''),
                    widget: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownSearch<String>(
                          searchBoxDecoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          dropdownSearchDecoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          mode: Mode.MENU,
                          dropdownBuilder:
                              (context, selectedItem, itemAsString) => Text(
                                    selectedItem,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18),
                                  ),
                          items: countriesName,
                          popupBackgroundColor: kcolor1.withOpacity(0.9),
                          hint: "Choose your country ...",
                          onChanged: (g) async {
                            selectedCountry =
                                countries.firstWhere((e) => e.name == g);

                            await saveCountry();

                            setState(() {});
                            goToWithRemoveUntill(context, HomeScrean());
                          },
                          selectedItem:
                              countries.length > 0 ? selectedCountry.name : ''),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
