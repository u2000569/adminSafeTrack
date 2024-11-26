import 'package:adminpickready/screens/adminsignin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isExpanded = false;

  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => AdminSignIn()));
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Attendance').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Student Attendance List Empty'),
            );
          }
          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              icon: const Icon(Icons.menu),
                            ),
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://mighty.tools/mockmind-api/content/human/44.jpg",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Row(
                                  children: [
                                    Card(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.article,
                                                size: 30,
                                              ),
                                              SizedBox(width: 15.0),
                                              Text(
                                                "Dashboard",
                                                style: TextStyle(fontSize: 24.0),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20.0),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Attendance Analysis",
                                              style: TextStyle(
                                                fontSize: 32.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                     SizedBox(width: 10,),
                                     Card(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.article,
                                                size: 30,
                                              ),
                                              SizedBox(width: 15.0),
                                              Text(
                                                "Report",
                                                style: TextStyle(fontSize: 24.0),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20.0),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Total Students",
                                              style: TextStyle(
                                                fontSize: 32.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                     )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        ListView.builder(
                          shrinkWrap: true,
                          //physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var userDoc = snapshot.data!.docs[index];
                            var userData = userDoc.data() as Map<String, dynamic>;
                            Timestamp timestamp = userData['timestamp'] as Timestamp;
                            String formattedTime = formatTimestamp(timestamp);
                            return Card(
                              margin: const EdgeInsets.all(16),
                              child: ListTile(
                                title: Text(userData['studentId'] ?? 'No ID'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Time Check In:'),
                                    Text(formattedTime),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
