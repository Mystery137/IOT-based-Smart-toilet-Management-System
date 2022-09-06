import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:soe/models/sensorData.dart';
import 'package:soe/services/database.dart';
import 'package:soe/shared/constants.dart';

class Sensor_data extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: DatabaseServices().dataOfSensor,
      builder: (context, wid) {
        final sData = Provider.of<SensorData2>(context);
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
                        'Sensor Data : ',
                        style: GoogleFonts.inter(
                          fontSize: 25,
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
                  margin: EdgeInsets.all(20),
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
                        bottom: 90,
                        left: 20,
                        child: Text(
                          "Water Quality (NTU) : ",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            color: kWhiteColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Positioned(
                        child: Text(
                          (sData == null ? "0.00" : sData.ntu),
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        bottom: 85,
                        right: 20,
                      ),
                      Positioned(
                        bottom: 40,
                        left: 20,
                        child: Text(
                          "Smell Quality (MQ2) : ",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            color: kWhiteColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Positioned(
                        child: Text(
                          (sData == null ? "0.00" : sData.mq2),
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        bottom: 35,
                        right: 20,
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
