import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kBlueColor = Color(0xFF1E1E99);
const kTwentyBlueColor = Color(0x201E1E99);
const kPinkColor = Color(0xFFFF70A3);
const kWhiteColor = Color(0xFFFFFFFF);
const kBlackColor = Color(0xFF3A3A3A);
const kTenBlackColor = Color(0x10000000);
const kBackgroundColor = Color(0xFFFAFAFA);
const kGreyColor = Color(0xff8A959E);
const kBlue = Color(0xFF1E1E99);

const kLoginTextFeildDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kBlue, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kBlue, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kWelcomeText = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'Pacifico',
  fontSize: 30.0,
);
