import 'package:avefin_lms_mobile_app/auth/models/person_model.dart';

class User {
  final String id;
  final String email;
  final String dateJoined;
  final List<String> companies;
  final bool isActive;
  final bool isStaff;
  final bool? isSuperuser;
  final String? role;
  final Person personData;

  const User({
    required this.id,
    required this.email,
    required this.dateJoined,
    required this.companies,
    required this.isActive,
    required this.isStaff,
    required this.personData,
    this.isSuperuser,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      dateJoined: json['dateJoined'] as String,
      companies: List<String>.from(json['companies'] ?? []),
      isActive: json['isActive'] as bool,
      isStaff: json['isStaff'] as bool,
      isSuperuser: json['isSuperuser'] as bool?,
      role: json['role'] as String?,
      personData: Person.fromJson(json['personData']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'dateJoined': dateJoined,
      'companies': companies,
      'isActive': isActive,
      'isStaff': isStaff,
      'isSuperuser': isSuperuser,
      'role': role,
      'personData': personData.toJson(),
    };
  }
}
