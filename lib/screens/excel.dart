import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
// import 'package:path_provider/path_provider.dart';

class ExcelImportScreen extends StatefulWidget {
  const ExcelImportScreen({Key? key}) : super(key: key);

  @override
  State<ExcelImportScreen> createState() => _ExcelImportScreenState();
}

class _ExcelImportScreenState extends State<ExcelImportScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Logger _logger = Logger();

  Future<void> importExcelData(BuildContext context) async {
  // Pick the Excel file
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx', 'xls'],
  );

  if (result != null) {
    File file = File(result.files.single.path!);

    // Read the Excel file
    try {
      var bytes = file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);

      // Check if Excel file is read correctly
      if (excel.tables.isEmpty) {
        print("No tables found in the Excel file.");
        _logger.i('No tables found in the Excel file.');
        return;
      }

      // Assuming the Excel file has one sheet
      for (var table in excel.tables.keys) {
        _logger.i("Processing table: $table");
        var sheet = excel.tables[table];

        if (sheet != null) {
          for (var row in sheet.rows) {
            // Debug: print each row to see what is being read
            _logger.i("Row: ${row.map((e) => e?.value).toList()}");

            // Example: Assuming the row has [className, studentId, studentName, studentAge]
            String className = row[0]?.value?.toString() ?? '';
            String studentId = row[1]?.value?.toString() ?? '';
            String studentName = row[2]?.value?.toString() ?? '';
            int studentAge = int.tryParse(row[3]?.value?.toString() ?? '0') ?? 0;

            // Debug: print parsed values
            _logger.i("Parsed Data - Class: $className, ID: $studentId, Name: $studentName, Age: $studentAge");

            if (className.isNotEmpty && studentId.isNotEmpty && studentName.isNotEmpty) {
              // Save data to Firestore
              await _firestore
                  .collection('Classes')
                  .doc(className)
                  .collection('students')
                  .doc(studentId)
                  .set({
                'studentId': studentId,
                'name': studentName,
                'age': studentAge,
              });
              _logger.i("Student $studentName added successfully.");
            } else {
              _logger.i("Skipped row due to missing data.");
            }
          }
        } else {
          _logger.i("Sheet is null for table: $table");
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Excel data imported successfully')),
      );
    } catch (e) {
      _logger.i("Failed to read Excel file: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to read Excel file: $e')),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to pick Excel file')),
    );
  }
}
  Future<void> uploadFile() async {
  // Pick the file using FilePicker
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    // Getting the file name
    String fileName = result.files.first.name;
    // Checking if the file picker provides a file path or raw bytes
    if (result.files.first.bytes != null) {
      // If it's raw bytes (e.g., on web), use putData
      Uint8List fileBytes = result.files.first.bytes!;
      _logger.i("File picked with bytes: $fileName");
      try {
        await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);
        _logger.i("File uploaded successfully!");
        importExcelData(context);
      } catch (e) {
        _logger.i("Failed to upload file: $e");
      }
    } else if (result.files.single.path != null) {
      // If it's a file path (e.g., on mobile), use File
      File file = File(result.files.single.path!);
      _logger.i("File picked from path: ${file.path}");
      try {
        await FirebaseStorage.instance.ref('uploads/$fileName').putFile(file);
        _logger.i("File uploaded successfully!");
        importExcelData(context);
      } catch (e) {
        _logger.i("Failed to upload file: $e");
      }
    } else {
      _logger.i("No valid file data found.");
    }
  } else {
    _logger.i("File selection was canceled or failed.");
  }
}

Future<void> readExcelFile() async{

  FilePickerResult? folder = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx', 'xls','csv'],
    allowMultiple: false,
  );

  if(folder != null){
    var bytes = folder.files.single.bytes;
    var excel = Excel.decodeBytes(bytes!);
    for (var table in excel.tables.keys) {
    _logger.i(table); //sheet Name
    _logger.i(excel.tables[table]?.maxColumns);
    _logger.i(excel.tables[table]?.maxRows);
    for (var row in excel.tables[table]!.rows) {
      _logger.i('$row');
    }
  }
  } 
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Excel Data'),
      ),
      body: Center(
        child: ElevatedButton(
          // onPressed: () => importExcelData(context), // Passing context via an anonymous function
          onPressed: uploadFile,
          child: const Text('Import from Excel'),
        ),
      ),
    );
  }
}
