import 'package:monerate/src/models/export.dart';

class FinancialAdvisorModel extends UserModel {
  String? licenseID;

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
