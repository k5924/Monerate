import 'package:monerate/src/models/export.dart';

/// This class lets us structure a financial advisors profile details
class FinancialAdvisorModel extends UserModel {
  /// This variable will store the license id for a financial advisor
  String? licenseID;

  /// This constructor will assign the first name, last name and user type by calling the user models constructor while assigning the license id in place
  FinancialAdvisorModel({
    firstName,
    lastName,
    userType,
    this.licenseID,
  }) : super(
          firstName: firstName.toString(),
          lastName: lastName.toString(),
          userType: userType.toString(),
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userType': userType,
      'licenseID': licenseID,
    };
  }

  /// This method converts a map to a financial advisor model instance
  @override
  factory FinancialAdvisorModel.fromMap(Map<String, dynamic> map) {
    return FinancialAdvisorModel(
      firstName: map['firstName'] as String?,
      lastName: map['lastName'] as String?,
      userType: map['userType'] as String?,
      licenseID: map['licenseID'] as String?,
    );
  }
}
