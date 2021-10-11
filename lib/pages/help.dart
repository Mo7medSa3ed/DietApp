import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/support.dart';
import 'package:flutter_test_app/widgets/custum.dart';

class HelpScrean extends StatelessWidget {
  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                ],
              ),
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
                  Column(
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
                          onpressed: () {})),
                  SizedBox(width: 8),
                  SizedBox(
                      width: 90,
                      height: 45,
                      child: buildFillElevatedButton(
                          text: 'Send',
                          onpressed: () {
                            goTo(context, SupportScrean());
                          })),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
