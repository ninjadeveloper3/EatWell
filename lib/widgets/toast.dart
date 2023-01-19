import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void flutterToast(String msg) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(msg: msg, backgroundColor: Colors.grey[300]);
}
