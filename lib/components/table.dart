// table.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TableWidget extends StatelessWidget {
  final List<QueryDocumentSnapshot> userData;

  TableWidget({required this.userData});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Full Name')),
        DataColumn(label: Text('Email')),
        DataColumn(label: Text('Phone Number')),
        DataColumn(label: Text('Role')),
      ],
      rows: userData.map((user) {
        return DataRow(cells: [
          DataCell(Text(user['fullName'])),
          DataCell(Text(user['email'])),
          DataCell(Text(user['phoneNumber'])),
          DataCell(Text(user['role'])),
        ]);
      }).toList(),
    );
  }
}
