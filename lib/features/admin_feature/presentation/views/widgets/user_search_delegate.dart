import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserSearchDelegate extends SearchDelegate<dynamic> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
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
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No users found'));
        }

        final users = snapshot.data!.docs;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final name = user['name'] ?? 'Unknown';
            final workId = user['work_id'] ?? 'N/A';

            return ListTile(
              title: Text(name),
              subtitle: Text('Work ID: $workId'),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text('Search for a user by their Work ID'),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('users')
          .where('work_id', isGreaterThanOrEqualTo: query)
          .where('work_id', isLessThanOrEqualTo: query + '\uf8ff')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No Users available'));
        }

        final suggestions = snapshot.data!.docs;

        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            final name = suggestion['name'] ?? 'Unknown';
            final workId = suggestion['work_id'] ?? 'N/A';

            return ListTile(
              title: Text(name),
              subtitle: Text('Work ID: $workId'),
              onTap: () {
                query = suggestion['work_id'];
                showResults(context);
              },
            );
          },
        );
      },
    );
  }
}
