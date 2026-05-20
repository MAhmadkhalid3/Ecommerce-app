import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/formatters/formaters.dart';

class UserModel {
  final String id;
    String firstName;
    String lastName;
  final String username;
  final String email;
  final String phoneNumber;
   String profileImage;
  final DateTime createdAt;

  UserModel ({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.createdAt,
  });

  /// 🔥 Firestore → Model
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();

    if (data == null) return UserModel.empty();

    return UserModel(
      id: document.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      profileImage: data['profileImage'] ?? '',
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  /// 🔥 Model → Firestore
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// 🔥 Full Name
  String get fullName => '$firstName $lastName';

  /// 🔥 Format Phone Number
  String get formattedPhoneNo =>
      TFormatter.formatPhoneNumber(phoneNumber);

  /// 🔥 Split Name
  static List<String> nameParts(String fullName) =>
      fullName.split(" ");

  /// 🔥 Generate Username
  static String generateUsername(String fullName) {
    List<String> parts = fullName.split(" ");
    String first = parts[0].toLowerCase();
    String last = parts.length > 1 ? parts[1].toLowerCase() : '';

    return "cwt_$first$last";
  }

  /// 🔥 Empty User
  static UserModel empty() => UserModel(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
    profileImage: '',
    createdAt: DateTime.now(),
  );
}