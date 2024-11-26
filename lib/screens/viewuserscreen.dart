import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_services.dart';

class ViewUserScreen extends StatefulWidget {
  const ViewUserScreen({super.key});

  @override
  State<ViewUserScreen> createState() => _ViewUserScreenState();
}

class _ViewUserScreenState extends State<ViewUserScreen> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();

  // Open a dialog to add or update info
  void openInfoBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              try {
                if (docID == null) {
                  // Add new info
                  await firestoreService.addStudentInfo(textController.text);
                } else {
                  // Update existing info
                  await firestoreService.updateInfo(docID, textController.text);
                }

                // Clear the input
                textController.clear();
                // Close the dialog
                Navigator.pop(context);
              } on FirebaseException catch (e) {
                print('Error: $e');
              }
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View User"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openInfoBox(),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getInfoStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data.'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Info...'));
          }
          List<DocumentSnapshot> infoList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: infoList.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = infoList[index];
              String docID = document.id;

              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              String infoText = data['info'];

              return ListTile(
                title: Text(infoText),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Update button
                    IconButton(
                      onPressed: () => openInfoBox(docID: docID),
                      icon: const Icon(Icons.settings),
                    ),
                    // Delete button
                    IconButton(
                      onPressed: () => firestoreService.deleteInfo(docID),
                      icon: const Icon(Icons.delete_forever),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
