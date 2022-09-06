import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soe/models/currentUser.dart';
import 'package:soe/models/dataOfStaff.dart';
import 'package:soe/services/database.dart';
import 'package:soe/shared/constants.dart';
import 'package:provider/provider.dart';

class Staff_data extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage getImage(String email) {
      if (email == "IIT2019085@iiita.ac.in")
        return AssetImage('assets/images/aniket.png');
      else if (email == "IIT2019086@iiita.ac.in")
        return AssetImage('assets/images/ankit.png');
      else if (email == "IIT2019029@iiita.ac.in")
        return AssetImage('assets/images/puneet.png');
      else if (email == "IIT2019030@iiita.ac.in")
        return AssetImage('assets/images/kaushal.png');
      else
        return AssetImage('assets/images/user_image.png');
    }

    final currUser = Provider.of<CurrentUser>(context);
    return StreamProvider<UserData>.value(
      value: DatabaseServices(uid: currUser.uid).userData,
      builder: (context, widget) {
        final user = Provider.of<UserData>(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: kBlue,
            title: Text(
              'Staff Data',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: kBlue,
          body: SafeArea(
            child: Stack(
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
                Positioned(
                  child: SvgPicture.asset("assets/svg/ellipse_bottom_pink.svg"),
                  bottom: 0,
                  right: 0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70.0,
                      backgroundImage:
                          getImage(user == null ? null : user.email),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      (user == null ? "No name" : user.name),
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 40.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "STAFF MEMBER",
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        letterSpacing: 2.5,
                        fontSize: 20.0,
                        color: kPinkColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: kPinkColor,
                        ),
                        title: Text(
                          (user == null ? "+91 63938*****" : user.mobile),
                          style: TextStyle(color: kPinkColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(
                          Icons.email,
                          color: kPinkColor,
                        ),
                        title: Text(
                          (user == null ? "null.." : user.email),
                          style: TextStyle(color: kPinkColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
