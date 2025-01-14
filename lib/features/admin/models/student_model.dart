import 'package:adminpickready/features/admin/models/grade_model.dart';
import 'package:adminpickready/features/personalization/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/helpers/helper_functions.dart';

class StudentModel{
  final String docId;
  String id;
  final String userId;
  // final double age;
  final DateTime attendanceDate;
  StudentStatus status;
  String email;
  String thumbnail;
  String name; // same as title product
  GradeModel? grade;
  UserModel? parent;
  final double totalAmount;

  StudentModel({
    required this.id,
    this.docId = '', 
    this.userId = '', 
    required this.attendanceDate,
    required this.status,
    this.email = '',
    required this.thumbnail,
    required this.name,
    this.grade,
    this.parent,
    required this.totalAmount,
  });

  String get fullName => '$name ';

  String get formattedAttendanceDate => SHelperFunctions.getFormattedDate(attendanceDate);

  String get studentStatusText => status == StudentStatus.present
    ? 'Present'
    : status == StudentStatus.absent
      ? 'Student is absent'
      : 'Processing';
  
  /// Static function to create an empty user model
  static StudentModel empty() => StudentModel(
    id: '', 
    attendanceDate: DateTime.now(), 
    status: StudentStatus.pending,
    thumbnail: '',
    name: '',
    email: '',
    totalAmount: 1
    );

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'userId': userId,
      'status': status.toString(), // enum to string
      'attendanceDate': attendanceDate,
      'thumbnail': thumbnail,
      'name' : name,
      'Grade': grade != null ? grade!.toJson() : null,
      'Parent': parent != null ? parent!.toJson() : null,
      'totalAmount': totalAmount
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory StudentModel.fromSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>?;

    if (data == null) {
      return StudentModel.empty();
    }

    return StudentModel(
      docId: snapshot.id,
      id: data.containsKey('id') ? data['id'] as String : '',
      userId: data.containsKey('userId') ? data['userId'] as String : '',  
      attendanceDate: data.containsKey('attendanceDate') ? (data['attendanceDate'] as Timestamp).toDate() : DateTime.now(), 
      status: data.containsKey('status')
      ? StudentStatus.values.firstWhere(
        (e) => e.toString() == data['status'], 
        orElse: () => StudentStatus.pending)
        : StudentStatus.pending,
      thumbnail: data['thumbnail'] ?? '',
      name: data['name'] ?? '',
      grade: data.containsKey('Grade') && data['Grade'] != null ? GradeModel.fromJson(data['Grade']) : null,
      parent: data.containsKey('Parent') && data['Parent'] != null ? UserModel.fromJson(data['Parent']) : null,
      totalAmount: data.containsKey('totalAmount') ? data['totalAmount'] as double : 0.0

    );
  }

  // Map Json-oriented document snapshot from Firebase to Model
  // factory StudentModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document){
  //   final data = document.data() as Map<String, dynamic>;
  //   return StudentModel(
  //     id: document.id, 
  //     age: data['Age'] ?? '', 
  //     attendaceDate: attendaceDate, 
  //     status: status, 
  //     totalStudent: totalStudent, 
  //     thumbnail: thumbnail, 
  //     name: name
  //   );
  // }
}