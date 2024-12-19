// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:attend_sys/features/admin_feature/presentation/views/widgets/user_arrival_data.dart';
import 'package:attend_sys/features/admin_feature/presentation/views/widgets/user_name_location.dart';
import 'package:flutter/material.dart';

class UserDetailsCard extends StatelessWidget {
  const UserDetailsCard({
    super.key,
    required this.userName,
    required this.workId,
    this.arrivalTime,
    this.departTime,
    this.workingTime,
    required this.lat,
    required this.lang,
    required this.outLat,
    required this.outLang,
  });

  final String userName;
  final String workId;
  final String? arrivalTime;
  final String? departTime;
  final String? workingTime;
  final double lat;
  final double lang;
  final double outLat;
  final double outLang;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserNameAndLocation(
              userName: userName,
              lat: lat,
              lang: lang,
              fontColor: Colors.black,
              buttonColor: Colors.green,
            ),
            UserNameAndLocation(
              userName: 'Employee No: $workId',
              lat: outLat,
              lang: outLang,
              fontColor: Colors.red,
              fontSize: 12,
              buttonColor: Colors.red,
            ),
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            UserArrivalData(
              arrivalTime: arrivalTime,
              departueTime: departTime,
              workingTime: workingTime,
            ),
          ],
        ),
      ),
    );
  }
}
