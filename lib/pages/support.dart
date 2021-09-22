import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
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
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: Card(
                  color: kwhite.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Column(
                      children: [
                        buildText2("Conversation"),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: 10,
                            itemBuilder: (ctx, index) =>
                                buildMessageCard(index, context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              buildCardForChat()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardForChat() {
    return Card(
      color: kwhite.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: ksecondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Message...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            SizedBox(
                width: 70,
                height: 50,
                child: buildFillElevatedButton(
                    widget: Icon(Icons.send),
                    borderRadius: 10,
                    onpressed: () {}))
          ],
        ),
      ),
    );
  }

  Widget buildMessageCard(int index, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          index % 2 == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        index % 2 == 0
            ? Container()
            : Container(
                margin: EdgeInsets.only(right: 8),
                padding: EdgeInsets.only(right: 8),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: kscaffoldcolor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/girl.png'))),
              ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: index % 2 != 0 ? kscaffoldcolor.withOpacity(0.5) : kprimary2,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              index % 2 != 0
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: buildText2("Order Problem",
                          color: index % 2 != 0 ? kprimary : kwhite)),
              Flexible(
                  child: buildText2(
                      "I have a question about clean 9 sadsd asdas sadasd sadasd asdasd",
                      color: index % 2 != 0 ? kprimary : kwhite))
            ],
          ),
        ),
      ],
    );
  }
}
