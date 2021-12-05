import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as td;
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/main.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:provider/provider.dart';

class SupportScrean extends StatefulWidget {
  final id;
  SupportScrean(this.id);

  @override
  _SupportScreanState createState() => _SupportScreanState();
}

class _SupportScreanState extends State<SupportScrean> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final mController = TextEditingController();

  bool status = false;
  getData() async {
    final res = await API.getOneTicket(widget.id);
    if (res == 'error') return Alert.errorAlert(ctx: context, title: errorMsg);
    if (res != null) {
      status = res['success'];
      Provider.of<AppProvider>(context, listen: false).initChatList([
        {
          "id": res['data']['id'],
          "comment": res['data']['description'],
          "user_id": res['data']['user_id'],
          "status": res['data']['status'],
          "commented": {
            "name": res['data']['title'],
          }
        },
        ...res['data']['comments']
      ]);

      setState(() {});
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      body: SafeArea(
          child: Consumer<AppProvider>(
        builder: (context, pro, child) => Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildBackButton(context, isArabic, margin: 0),
                  SizedBox(
                    width: 16,
                  ),
                  buildText(tr('support'))
                ],
              ),
              SizedBox(
                height: 16,
              ),
              !status
                  ? Center(
                      child: CircularProgressIndicator(color: kprimary),
                    )
                  : pro.chatList.length == 0
                      ? Center(
                          child: buildText(tr("nodata")),
                        )
                      : Expanded(
                          child: Card(
                            color: kwhite.withOpacity(0.9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              child: Column(
                                children: [
                                  buildText2(tr("conversation")),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      reverse: true,
                                      itemCount: pro.chatList.reversed.length,
                                      itemBuilder: (ctx, index) =>
                                          buildMessageCard(
                                              pro.chatList[pro.chatList.length -
                                                  index -
                                                  1],
                                              context),
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
              buildCardForChat(pro)
            ],
          ),
        ),
      )),
    );
  }

  Widget buildCardForChat(pro) {
    return Directionality(
      textDirection: td.TextDirection.ltr,
      child: Card(
        color: kwhite.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: ksecondary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8)),
                  child: TextFormField(
                    controller: mController,
                    onChanged: (String v) {
                      if (v.trim().length == 0 || v.trim().length == 1) {
                        setState(() {});
                      }
                    },
                    textDirection:
                        isArabic ? td.TextDirection.rtl : td.TextDirection.ltr,
                    decoration: InputDecoration(
                      hintText: tr('message'),
                      hintTextDirection: isArabic
                          ? td.TextDirection.rtl
                          : td.TextDirection.ltr,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              if (mController.text.trim().length > 0)
                SizedBox(
                  width: 60,
                  height: 45,
                  child: buildFillElevatedButton(
                    widget: Icon(Icons.send),
                    borderRadius: 10,
                    onpressed: () async => await addMessage(pro),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMessageCard(data, BuildContext context) {
    bool isUser = data['commented'] != 'Admin';
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        isUser
            ? Container()
            : Container(
                // margin: EdgeInsets.only(right: 8),
                padding: EdgeInsets.all(2),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: kscaffoldcolor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset('assets/images/support.svg'),
              ),
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 16, left: 8, right: 8),
          decoration: BoxDecoration(
            color: !isUser ? kscaffoldcolor.withOpacity(0.5) : kprimary2,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !isUser
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: buildText2(data['commented']['name'],
                          color: !isUser ? kprimary : kwhite)),
              Flexible(
                  child: buildText2(data['comment'] ?? '',
                      color: !isUser ? kprimary : kwhite))
            ],
          ),
        ),
      ],
    );
  }

  addMessage(pro) async {
    if (mController.text.trim().length == 0) return;
    // Alert.loadingAlert(ctx: context);

    final res = await API.addNewcomment(
        comment: mController.text.trim(), ticketId: widget.id.toString());

    // Navigator.of(context).pop();
    if (res == 'error') {
      return Alert.errorAlert(ctx: context, title: tr('error404'));
    }

    final data = res.data;

    if ((res.statusCode == 200 || res.statusCode == 201) && data['success']) {
      mController.clear();

      pro.initChatList([
        {
          "id": data['data']['id'],
          "comment": data['data']['description'],
          "user_id": data['data']['user_id'],
          "status": data['data']['status'],
          "commented": {
            "name": data['data']['title'],
          }
        },
        ...data['data']['comments']
      ]);
    } else if (res.statusCode != 200 || !data['success']) {
      return Alert.errorAlert(ctx: context, title: data['message']);
    } else {
      return Alert.errorAlert(ctx: context, title: tr('error404'));
    }
  }
}
