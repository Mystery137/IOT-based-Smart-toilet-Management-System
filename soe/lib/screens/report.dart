import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soe/models/currentUser.dart';
import 'package:soe/services/database.dart';
import 'package:soe/shared/constants.dart';
import 'package:soe/shared/loading.dart';
import '../components.dart';

List<String> reports = [
  "All sensors are working properly.",
  "Some of sensors needs servicing.",
  "Hello I am Aniket Jaiswal.\nSecond year B.Tech.\nTech Enthu...\nCompetiti...\nYep\nIt's me"
];

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final _messageTextController = TextEditingController();
  String currentreport;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: kBlue,
                        shape: BoxShape.circle,
                      ),
                      height: 50,
                      width: 50,
                      child: Icon(
                        Icons.arrow_back_outlined,
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Past Reports   ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Pacifico',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: BorderRadius.circular(15.0)),
                      height: MediaQuery.of(context).size.height * .35,
                      child: reportStream(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: _messageTextController,
                      decoration: InputDecoration(
                        fillColor: kBlue,
                        hoverColor: kBlue,
                        focusColor: kBlue,
                        labelText: "Your current report...",
                        hintText: "Type here...",
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kBlue, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                      maxLines: 7,
                      onChanged: (value) {
                        currentreport = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RoundedButton(
                      buttonColor: kBlueColor,
                      buttonTitle: 'Send Report',
                      onPressed: () {
                        if (currentreport != null) {
                          setState(() {
                            _messageTextController.clear();
                            if (isData(currentreport)) {
                              setData(currentreport);
                              showAlertDialog(
                                  context, "Data sent successfully");
                            } else {
                              reports.add(currentreport);
                              addData(currentreport, user);

                              showAlertDialog(
                                  context, "Report sent successfully");
                            }
                            currentreport = null;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool isData(String s) {
  var l = ' '.allMatches(s).length;
  var dot = '.'.allMatches(s).length;
  if (s[0] == '\$' && l == 2 && dot < 3) {
    String ntu = s.substring(2, s.indexOf(' ', 2));
    String mq2 = s.substring(s.indexOf(' ', 2));
    if (isNumeric(ntu) && isNumeric(mq2)) return true;
    return false;
  } else {
    return false;
  }
}

bool isNumeric(String s) {
  if (s == null)
    return false;
  else
    return double.tryParse(s) != null;
}

void setData(String s) async {
  double ntu = double.parse(s.substring(2, s.indexOf(' ', 2)));
  ntu = double.parse((ntu).toStringAsFixed(2));
  double mq2 = double.parse(s.substring(s.indexOf(' ', 2)));
  mq2 = double.parse((mq2).toStringAsFixed(2));
  print("ntu : $ntu");
  print("mq2 : $mq2");
  await DatabaseServices().updateSensorData(ntu.toString(), mq2.toString());
}

void addData(String s, var user) async {
  await DatabaseServices(uid: user.uid).addReport(s);
}

showAlertDialog(BuildContext context, String displayMessage) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text(
      "OK",
      textAlign: TextAlign.center,
      style: TextStyle(color: kBlue),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "\nMessage Info",
      style: TextStyle(color: kBlue),
      textAlign: TextAlign.center,
    ),
    content: Text(
      displayMessage,
      style: TextStyle(color: kBlue),
      textAlign: TextAlign.center,
    ),
    actions: [
      okButton,
    ],
    elevation: 24.0,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class reportStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseServices().reportData.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: kBlue),
                  child: ListView(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: reports[index],
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  height: 150,
                  width: 150,
                ),
              );
            },
          );
        }
        final messages = snapshot.data.docs;
        print(messages);
        reports = [];
        for (var message in messages) {
          if (message.data()[user.uid] != null)
            reports.add(message.data()[user.uid]);
        }
        if (reports.length == 0)
          return Center(
            child: Text("No report send"),
          );
        else
          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: kBlue),
                  child: ListView(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: reports[index],
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  height: 150,
                  width: 150,
                ),
              );
            },
          );
      },
    );
  }
}
