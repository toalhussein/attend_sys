import 'package:attend_sys/features/super_admin_feature/views/widgets/user_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserSearchDelegate extends SearchDelegate<dynamic> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _firestore
          .collection('users')
          .where('work_id', isEqualTo: query)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No users found'));
        }

        final users = snapshot.data!.docs;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              title: Text(user['name'] ?? 'Unknown'),
              subtitle: Text('Work ID: ${user['work_id'] ?? 'N/A'}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UserDetailsPage(
                        name: user['name'],
                        workId: user['work_id'],
                        role: user['role'],
                        residenceCity: user['residence_city'],
                        workCity: user['work_city'],
                      );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Search for a user by their Work ID'),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('users')
          .where('work_id', isGreaterThanOrEqualTo: query)
          .where('work_id', isLessThanOrEqualTo: '$query\uf8ff')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Users available'));
        }

        final suggestions = snapshot.data!.docs;

        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];

            return ListTile(
              title: Text(suggestion['name'] ?? 'Unknown'),
              subtitle: Text('Work ID: ${suggestion['work_id'] ?? 'N/A'}'),
              onTap: () {
                query = suggestion['work_id'];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UserDetailsPage(
                        name: suggestion['name'],
                        workId: suggestion['work_id'],
                        role: suggestion['role'],
                        residenceCity: suggestion['residence_city'],
                        workCity: suggestion['work_city'],
                      );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}