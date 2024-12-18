// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class UserArrivalData extends StatelessWidget {
  const UserArrivalData({
    super.key,
    this.arrivalTime,
    this.departueTime,
    this.workingTime,
  });

  final String? arrivalTime;
  final String? departueTime;
  final String? workingTime;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 13,
      spacing: 10,
      children: [
        Column(
          children: [
            const Text('Arrival'),
            Text(arrivalTime ?? '-'),
          ],
        ),
        const SizedBox(
          height: 30,
          child: VerticalDivider(
            thickness: 1,
          ),
        ),
        Column(
          children: [
            const Text('Departure'),
            Text(departueTime ?? '-'),
          ],
        ),
        const SizedBox(
          height: 30,
          child: VerticalDivider(
            thickness: 1,
          ),
        ),
        Column(
          children: [
            const Text('Working Time'),
            Text(workingTime ?? '-'),
          ],
        ),
      ],
    );
  }
}
