// ignore_for_file: use_build_context_synchronously

import 'package:attend_sys/core/app_snackbars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error getting location: $e');
      return null;
    }
  }

  static void attendance(BuildContext context) async {
    final Position? position = await _getCurrentLocation();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (position == null) {
      return;
    }

    final DateTime now = DateTime.now();
    String today = getFormattedDate();
    final Map<String, dynamic> data = {
      'attendance': now,
      'departure': '',
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
          .set(data, SetOptions(mergeFields: ['attendance', 'location']));
      AppSnackbars.showSuccessSnackbar(
        context,
        'Success Attendance',
        'Success Operation',
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error recording Attendance: $e');
    }
  }

  static void departure(BuildContext context) async {
    final Position? position = await _getCurrentLocation();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (position == null) {
      return;
    }

    final DateTime now = DateTime.now();
    String today = getFormattedDate();
    final Map<String, dynamic> data = {
      'attendance': '',
      'departure': now,
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
          .set(data, SetOptions(mergeFields: ['out_location', 'departure']));

      AppSnackbars.showSuccessSnackbar(
        context,
        'Success Departure',
        'Success Operation',
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error recording Departure: $e');
    }
  }

  static String getFormattedDate([DateTime? date]) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    if (date == null) {
      String date = today.toString();
      return date.substring(0, 10);
    } else {
      String fDate = date.toString();
      return fDate.substring(0, 10);
    }
  }
}
