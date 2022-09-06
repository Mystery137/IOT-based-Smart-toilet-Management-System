import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:soe/models/currentUser.dart';
import 'package:soe/models/dataOfStaff.dart';
import 'package:soe/models/sensorData.dart';
import 'package:soe/services/database.dart';
import 'package:soe/shared/constants.dart';
import 'package:soe/screens/report.dart';
import 'package:soe/screens/schedule.dart';
import 'package:soe/screens/sensor_data.dart';
import 'package:soe/screens/staff_data.dart';
import 'package:soe/services/auth.dart';

class Home2 extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final currUser = Provider.of<CurrentUser>(context);
    return StreamProvider<UserData>.value(
      value: DatabaseServices(uid: currUser.uid).userData,
      catchError: (context, e) {
        print(e);
        return null;
      },
      builder: (context, wid) {
        final user = Provider.of<UserData>(context);
        print(user);
        return StreamProvider<SensorData2>.value(
          value: DatabaseServices().dataOfSensor,
          builder: (context, wid) {
            final forColor = Provider.of<SensorData2>(context);
            return Scaffold(
              backgroundColor: getBackgroundColor(forColor),
              body: SafeArea(
                child: Container(
                  margin: EdgeInsets.only(top: 8),
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlatButton.icon(
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              color: kBlue,
                              label: Text(
                                'Log Out',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                await _auth.signOut();
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Staff_data(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 59,
                                width: 59,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/user_image.png'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello!',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              (user == null ? 'No name' : user.name),
                              style: GoogleFonts.inter(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Sensor_data(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          height: 200,
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: kBlue,
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                child: SvgPicture.asset(
                                    "assets/svg/ellipse_top_pink.svg"),
                              ),
                              Positioned(
                                child: SvgPicture.asset(
                                    "assets/svg/ellipse_bottom_pink.svg"),
                                bottom: 0,
                                right: 0,
                              ),
                              Positioned(
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/sensor_logo.png'),
                                    ),
                                  ),
                                ),
                                right: 25,
                                top: 25,
                              ),
                              Positioned(
                                bottom: 90,
                                left: 20,
                                child: Text(
                                  "Access",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    color: kWhiteColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Text(
                                  "Sensor Data",
                                  style: TextStyle(
                                    fontFamily: 'Pacifico',
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                bottom: 40,
                                left: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Schedule(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          height: 200,
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: kBlue,
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                child: SvgPicture.asset(
                                    "assets/svg/ellipse_top_pink.svg"),
                              ),
                              Positioned(
                                child: SvgPicture.asset(
                                    "assets/svg/ellipse_bottom_pink.svg"),
                                bottom: 0,
                                right: 0,
                              ),
                              Positioned(
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/schedule_logo.png'),
                                    ),
                                  ),
                                ),
                                right: 25,
                                top: 25,
                              ),
                              Positioned(
                                bottom: 90,
                                left: 20,
                                child: Text(
                                  "Access",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    color: kWhiteColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Text(
                                  "Schedule Data",
                                  style: TextStyle(
                                    fontFamily: 'Pacifico',
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                bottom: 40,
                                left: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Report(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          height: 200,
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: kBlue,
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                child: SvgPicture.asset(
                                    "assets/svg/ellipse_top_pink.svg"),
                              ),
                              Positioned(
                                child: SvgPicture.asset(
                                    "assets/svg/ellipse_bottom_pink.svg"),
                                bottom: 0,
                                right: 0,
                              ),
                              Positioned(
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/report_logo.png'),
                                    ),
                                  ),
                                ),
                                right: 25,
                                top: 25,
                              ),
                              Positioned(
                                bottom: 90,
                                left: 20,
                                child: Text(
                                  "Send",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    color: kWhiteColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Text(
                                  "Report",
                                  style: TextStyle(
                                    fontFamily: 'Pacifico',
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                bottom: 40,
                                left: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Color getBackgroundColor(SensorData2 forColor) {
  if (forColor == null) return Colors.white;
  double ntu = double.parse(forColor.ntu);
  double mq2 = double.parse(forColor.mq2);
  if (ntu <= 1.00 && mq2 <= 1.00) return Colors.white;
  if ((ntu + mq2) <= 3.0) return Colors.red[100];
  if ((ntu + mq2) <= 3.5) return Colors.red[200];
  if ((ntu + mq2) <= 4.0) return Colors.red[300];
  if ((ntu + mq2) <= 4.5) return Colors.red[400];
  if ((ntu + mq2) <= 5.0) return Colors.red[500];
  if ((ntu + mq2) <= 5.5) return Colors.red[600];
  if ((ntu + mq2) <= 6.0) return Colors.red[700];
  if ((ntu + mq2) <= 6.5) return Colors.red[800];
  if ((ntu + mq2) > 6.5) return Colors.red[900];
}
