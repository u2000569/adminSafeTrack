import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/formatters/formatter.dart';
import 'address_model.dart';

class UserModel{
  final String? id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String profilePicture;
  AppRole role;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<AddressModel>? addresses;

  /// Constructor for UserModel.
  UserModel({
    this.id,
    required this.email,
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.profilePicture = '',
    this.role = AppRole.teacher,
    this.createdAt,
    this.updatedAt,
  });

  /// Helper methods
  String get fullName => '$firstName $lastName';

  String get formattedPhoneNo => SFormatter.formatPhoneNumber(phoneNumber);

  String get formattedDate => SFormatter.formatDate(createdAt);

  String get formattedUpdatedAtDate => SFormatter.formatDate(updatedAt);

  /// Static function to create an empty user model.
  static UserModel empty() => UserModel(email: ''); // Default createdAt to current time

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Role': role.name.toString(),
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return UserModel.empty();
    return UserModel(
      id: data['Id'] ?? '',
      firstName: data['FirstName'] ?? '',
      lastName: data['LastName'] ?? '',
      email: data['Email'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      profilePicture: data['ProfilePicture'] ?? '',
      role: data['Role'] == AppRole.parent.name.toString() ? AppRole.parent : AppRole.teacher,
      createdAt: data['CreatedAt']?.toDate() ?? DateTime.now(),
      updatedAt: data['UpdatedAt']?.toDate() ?? DateTime.now(),
    );
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data.containsKey('FirstName') ? data['FirstName'] ?? '' : '',
        lastName: data.containsKey('LastName') ? data['LastName'] ?? '' : '',
        email: data.containsKey('Email') ? data['Email'] ?? '' : '',
        phoneNumber: data.containsKey('PhoneNumber') ? data['PhoneNumber'] ?? '' : '',
        profilePicture: data.containsKey('ProfilePicture') ? data['ProfilePicture'] ?? '' : '',
        role: data.containsKey('Role')
            ? (data['Role'] ?? AppRole.teacher) == AppRole.admin.name.toString()
                ? AppRole.admin
                : AppRole.teacher
            : AppRole.teacher,
        createdAt: data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate() ?? DateTime.now() : DateTime.now(),
        updatedAt: data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate() ?? DateTime.now() : DateTime.now(),
      );
    } else {
      return empty();
    }
  }
}