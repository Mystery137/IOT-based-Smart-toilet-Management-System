import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:soe/models/scheduleData.dart';
import 'package:soe/services/database.dart';
import 'package:soe/shared/constants.dart';
import 'package:provider/provider.dart';

class Schedule extends StatelessWidget {
  var date =
      (DateFormat('EEEE, d MMM, yyyy').format(DateTime.now())).toString();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ScheduleData>.value(
      value: DatabaseServices().dataOfSchedule,
      builder: (context, widget) {
        final sData = Provider.of<ScheduleData>(context);
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date : ',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        date,
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
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s Schedule : ',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
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
                        child:
                            SvgPicture.asset("assets/svg/ellipse_top_pink.svg"),
                      ),
                      Positioned(
                        child: SvgPicture.asset(
                            "assets/svg/ellipse_bottom_pink.svg"),
                        bottom: 0,
                        right: 0,
                      ),
                      Positioned(
                        bottom: 100,
                        left: 20,
                        child: Text(
                          "OnDuty Staff : ",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            color: kWhiteColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Positioned(
                        child: Text(
                          (sData == null ? "No one OnDuty" : sData.onDuty),
                          style: TextStyle(
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
              ],
            ),
          ),
        );
      },
    );
  }
}
