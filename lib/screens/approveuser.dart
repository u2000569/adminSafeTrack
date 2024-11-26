// approve_users_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApproveUsersPage extends StatefulWidget {
  @override
  State<ApproveUsersPage> createState() => _ApproveUsersPageState();
}

class _ApproveUsersPageState extends State<ApproveUsersPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Approve Users')),
      body: StreamBuilder(
        stream: _firestore.collection('Users').where('approved', isEqualTo: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No users to approve.'));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot doc) {
              final user = doc.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(user['email'] ?? 'No Email'),
                subtitle: Text('Role: ${user['role']}'),
                trailing: ElevatedButton(
                  onPressed: () async {
                    await _firestore.collection('users').doc(doc.id).update({'approved': true});
                  },
                  child: Text('Approve'),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
