import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test_app/pages/support.dart';
import 'package:flutter_test_app/widgets/custum.dart';

class HelpScrean extends StatelessWidget {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final tController = TextEditingController();
  final sController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // radius: 0.1,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xffe4e6f3),
              Color(0xfffefefe),
              Color(0xffe4e6f3),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                buildBackButton(context, false, margin: 0),
                SizedBox(
                  width: 16,
                ),
                buildText("Custumer Service")
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                children: [
                  Image.asset(
                    'assets/images/girl.png',
                    height: 120,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        buildText('Tell us how we can help', fontsize: 22),
                        SizedBox(height: 10),
                        buildText2(
                            'Our crew are standing by\n for service and support.',
                            align: TextAlign.center),
                        SizedBox(height: 30),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: kprimary2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildText('Title', color: kprimary2),
                              TextFormField(
                                controller: tController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: kprimary2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildText('Subject', color: kprimary2),
                              TextFormField(
                                controller: sController,
                                maxLines: 8,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 100,
                      height: 45,
                      child: buildFillElevatedButton(
                          text: 'Discard',
                          bgcolor: kwhite.withOpacity(0.3),
                          elevation: 0.0,
                          txtcolor: kprimary,
                          onpressed: () {
                            tController.clear();
                            sController.clear();
                            FocusScope.of(context).unfocus();
                          })),
                  SizedBox(width: 8),
                  SizedBox(
                      width: 90,
                      height: 45,
                      child: buildFillElevatedButton(
                          text: 'Send',
                          onpressed: () async => await sendTicket(context))),
                  SizedBox(
                      width: 90,
                      height: 45,
                      child: buildFillElevatedButton(
                          text: 'go',
                          onpressed: () => goTo(context, SupportScrean(1)))),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  sendTicket(context) async {
    if (!(formKey.currentState.validate())) return;
    Alert.loadingAlert(ctx: context);

    final res = await API.addNewTicket(
        title: tController.text.trim(), desc: sController.text.trim());

    Navigator.of(context).pop();
    if (res == 'error') {
      return Alert.errorAlert(ctx: context, title: tr('error404'));
    }

    final data = res.data;

    if ((res.statusCode == 200 || res.statusCode == 201) && data['success']) {
      tController.clear();
      sController.clear();
      return buildDialog(
        context: context,
        test: true,
        text: "Your ticket is added successfully.",
        desc: "Your ticket is added successfully.",
        img: "image5.png",
        homebtnTap: () => goToWithRemoveUntill(context, HomeScrean()),
        gobtnTap: () =>
            goToWithRemoveUntill(context, SupportScrean(data['data']['id'])),
        homebtnText: 'Go To Home',
        gobtnText: 'Continue Chating',
      );
    } else if (res.statusCode != 200 || !data['success']) {
      return Alert.errorAlert(ctx: context, title: data['message']);
    } else {
      return Alert.errorAlert(ctx: context, title: tr('error404'));
    }
  }
}
