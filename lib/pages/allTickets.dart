import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/support.dart';
import 'package:flutter_test_app/widgets/custum.dart';

class AllTicketsScrean extends StatefulWidget {
  @override
  _AllTicketsScreanState createState() => _AllTicketsScreanState();
}

class _AllTicketsScreanState extends State<AllTicketsScrean> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  var tickets = [];
  var status = false;

  getData() async {
    tickets.clear();
    final res = await API.getAllTickets();
    if (res == 'error') return Alert.errorAlert(ctx: context, title: errorMsg);
    if (res != null) {
      status = res['success'];
      if (res['data'].length > 0) {
        tickets = res['data'];
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldkey,
      drawer: buildDrawer(context),
      body: Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildAppBarForPages(
                context,
                tr('alltickets'),
                () => scaffoldkey.currentState.openDrawer(),
              ),
              !status
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(color: kprimary),
                      ),
                    )
                  : tickets.length == 0
                      ? Expanded(
                          child: Center(
                            child: buildText(tr("nodata")),
                          ),
                        )
                      : Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async => await getData(),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 28),
                                    itemBuilder: (c, i) => Card(
                                      margin: EdgeInsets.only(bottom: 8),
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: ListTile(
                                          title: buildText(tickets[i]['title'],
                                              fontsize: 16),
                                          subtitle: buildText2(
                                              tickets[i]['description'],
                                              fontsize: 14),
                                          leading: CircleAvatar(
                                              backgroundColor: tickets[i]
                                                              ['status']
                                                          .toLowerCase() ==
                                                      'completed'
                                                  ? Colors.green
                                                  : tickets[i]['status']
                                                              .toLowerCase() ==
                                                          'closed'
                                                      ? Colors.red
                                                      : tickets[i]['status']
                                                                  .toLowerCase() ==
                                                              'pending'
                                                          ? Colors.yellow
                                                          : Colors.blueAccent),
                                          trailing:
                                              Icon(Icons.arrow_forward_ios),
                                          onTap: () => goTo(context,
                                              SupportScrean(tickets[i]['id']))),
                                    ),
                                    itemCount: tickets.length,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
            ]),
      ),
    ));
  }
}
