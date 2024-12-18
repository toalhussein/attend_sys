// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignRecord {
  SignRecord._();
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<Position?> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Fluttertoast.showToast(msg: 'Location permission denied');
          return null;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(msg: 'Location permission permanently denied');
        return null;
      }
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error getting location: $e');
      return null;
    }
  }

  static void attendance() async {
    final Position? position = await _getCurrentLocation();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (position == null) {
      return;
    }

    final DateTime now = DateTime.now();
    String today = getFormattedDate();
    final Map<String, dynamic> data = {
      'attendance': now,
      'departure':'',
      'location': {
        'latitude': position.latitude,
        'longitude': position.longitude,
      },
    };

    try {
      await _firestore
          .collection('users')
          .doc(
            pref.getString('id'),
          )
          .collection('records')
          .doc(
            today,
          )
          .set(data,SetOptions(mergeFields: ['attendance','location']));
      Fluttertoast.showToast(
          msg: 'Attendance recorded successfully at ${now.toLocal()}');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error recording Attendance: $e');
    }
  }

  static void departure() async {
    final Position? position = await _getCurrentLocation();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (position == null) {
      return;
    }

    final DateTime now = DateTime.now();
    String today = getFormattedDate();
     final Map<String, dynamic> data = {
      'attendance': '',
      'departure':now,
      'out_location': {
        'latitude': position.latitude,
        'longitude': position.longitude,
      },
    };

    try {
      await _firestore
          .collection('users')
          .doc(
            pref.getString('id'),
          )
          .collection('records')
          .doc(
            today,
          )
          .set(data,SetOptions(mergeFields: ['out_location','departure']));

      Fluttertoast.showToast(
          msg: 'Departure recorded successfully at ${now.toLocal()}');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error recording Departure: $e');
    }
  }

  static String getFormattedDate([DateTime? date]) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    if (date == null) {
      String date = today.toString();
      log(date.substring(0, 10));
      return date.substring(0, 10);
    } else {
      String fDate = date.toString();
      log(fDate.substring(0, 10));
      return fDate.substring(0, 10);
    }
  }
}
