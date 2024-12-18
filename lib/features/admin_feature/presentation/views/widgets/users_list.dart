// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:attend_sys/core/calendar_notifier.dart';
import 'package:attend_sys/core/record.dart';
import 'package:attend_sys/features/admin_feature/presentation/views/widgets/user_details_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  const UsersList({
    super.key,
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('users').snapshots(),
      builder: (context, users) {
        if (!users.hasData) {
          return const Center(child: Text('Loading'));
        } else if (users.hasError) {
          return const Center(child: Text('Error'));
        } else {
          return ValueListenableBuilder(
            valueListenable: CustomNotifier.selectedDate,
            builder: (context, value, child) => Expanded(
              child: ListView.builder(
                itemCount: users.data!.docs.length,
                itemBuilder: (context, index) {
                  return StreamBuilder(
                    stream: _firestore
                        .collection('users')
                        .doc(users.data!.docs[index].id)
                        .collection('records')
                        .doc(SignRecord.getFormattedDate(value))
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error data'));
                      } else if (!snapshot.hasData) {
                        return Center(child: Text('No Users Found'));
                      } else {
                        Timestamp? attend =
                            snapshot.data?.data()?['attendance'];

                        Timestamp? depart = snapshot.data?.data()?['departure'];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: UserDetailsCard(
                            userName: users.data!.docs[index].data()['name'],
                            workId: users.data!.docs[index].data()['work_id'],
                            arrivalTime: attend != null
                                ? formatDate(
                                    attend.toDate(), [hh, ':', mm, ' ', am])
                                : '-',
                            departTime: depart != null
                                ? formatDate(
                                    depart.toDate(), [hh, ':', mm, ' ', am])
                                : '-',
                            workingTime: (attend != null && depart != null)
                                ? '${(depart.toDate().hour - attend.toDate().hour).abs()} H'
                                : '-',
                            lang: snapshot.data?.data()?['location']
                                    ?['longitude'] ??
                                0,
                            lat: snapshot.data?.data()?['location']
                                    ?['latitude'] ??
                                0,
                                outLang: snapshot.data?.data()?['out_location']
                                    ?['longitude'] ??
                                0,
                            outLat: snapshot.data?.data()?['out_location']
                                    ?['latitude'] ??
                                0,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
