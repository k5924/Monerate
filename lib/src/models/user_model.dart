// ignore_for_file: avoid_dynamic_calls
/// This class is a model for all user accounts
class UserModel {
  /// This variable stores the users first name
  String? firstName;

  /// This variable stores the users last name
  String? lastName;

  /// This variable stores the user type of the user
  String? userType;

  /// This is the constructor of the user model class requiring all of these to be defined for a user
  UserModel({
    this.firstName,
    this.lastName,
    this.userType,
  });

  /// This method converts all elements inside the user model class to a map
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userType': userType,
    };
  }

  /// this method converts a map to a user model instance
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] as String?,
      lastName: map['lastName'] as String?,
      userType: map['userType'] as String?,
    );
  }

  /// this method returns the user type for a user model instance
  String? getUserType() {
    return userType;
  }
}
