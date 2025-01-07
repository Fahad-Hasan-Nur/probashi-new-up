import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probashi/controllers/party_controller.dart';
import '../models/party.dart';
import '../models/sales.dart';

class TodaysSalesViewDashboard extends StatefulWidget {
  final Sales sales;
  const TodaysSalesViewDashboard({Key? key, required this.sales})
      : super(key: key);

  @override
  State<TodaysSalesViewDashboard> createState() =>
      _TodaysSalesViewDashboardState();
}

class _TodaysSalesViewDashboardState extends State<TodaysSalesViewDashboard> {
  Party party = Party();
  String today = DateTime.now().toString().substring(0, 10);

  @override
  void initState() {
    super.initState();
    setInitialData();
    today = DateTime.now().toString().substring(0, 10);
    print(today);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5),
                child: widget.sales.sync == 'true' &&
                        widget.sales.salesDate!.contains(today)
                    ? Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 203, 126),
                                  Color.fromARGB(255, 255, 255, 255),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.topRight),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 10,
                                color: Color.fromARGB(255, 176, 148, 107),
                              )
                            ]),
                        child: Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width / 1.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(party.username.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                      textAlign: TextAlign.left),
                                  // Expanded(child: Container()),
                                  // Text(
                                  //   widget.sales.salesInvoice.toString(),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 40,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "SAR ${widget.sales.totalIncludingVAT}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 55, 39, 4)),
                                    ),
                                    // Expanded(child: Container()),
                                    // Text(
                                    //   "SAR ${widget.sales.totalIncludingVAT}",
                                    //   style: TextStyle(
                                    //       color:
                                    //           Color.fromARGB(255, 88, 165, 0),
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 13),
                                    // )
                                  ],
                                )),
                          ),
                        ]),
                      )
                    : Container(
                        color: Colors.red,
                      )),
          ],
        ));
  }

  void setInitialData() async {
    Party ob =
        await Get.find<PartyController>().getPartyById(widget.sales.partyId!);
    setState(() {
      party = ob;
    });
  }
}
