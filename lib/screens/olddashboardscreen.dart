import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OldDashboardScreen extends StatefulWidget {
  const OldDashboardScreen({super.key});

  @override
  State<OldDashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<OldDashboardScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _approveUser(String userId) async {
    try {
      await _firestore.collection('Users').doc(userId).update({'status': 'approved'});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User approved successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to approve user: $e')),
      );
    }
  }

  Future<void> _deleteUser(String userId) async {
    try {
      await _firestore.collection('Users').doc(userId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Users').where('status', isEqualTo: 'pending').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users need approval'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var userDoc = snapshot.data!.docs[index];
              var userId = userDoc.id;
              var userData = userDoc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  // leading: Text(userData['role']),
                  title: Text(userData['fullName'] ?? 'No Name'),
                  subtitle: Column(
                    children: [
                      Text(userData['email'] ?? 'No Email'),
                      Text(userData['role']),
                    ],
                  ),
                  
              
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () => _approveUser(userId),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteUser(userId),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
