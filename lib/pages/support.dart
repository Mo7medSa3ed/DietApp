import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/custum.dart';

class SupportScrean extends StatelessWidget {
  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
            ],
          ),
        ),
      ),
    );
  }
}
