// ignore_for_file: avoid_dynamic_calls

class UserModel {
  String? firstName;
  String? lastName;
  String? userType;

  UserModel({
    this.firstName,
    this.lastName,
    this.userType,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userType': userType,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] as String?,
      lastName: map['lastName'] as String?,
      userType: map['userType'] as String?,
    );
  }

  String? getUserType() {
    return userType;
  }
}
