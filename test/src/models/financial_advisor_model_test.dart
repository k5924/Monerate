import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/models/export.dart';

void main() {
  group('Financial Advisor Model:', () {
    late FinancialAdvisorModel userModel;
    test('Empty FinancialAdvisorModel.toMap() returns null for each field', () {
      userModel = FinancialAdvisorModel();
      expect(
        userModel.toMap(),
        {
          'firstName': 'null',
          'lastName': 'null',
          'userType': 'null',
          'licenseID': null,
        },
      );
    });

    test('Populated FinancialAdvisorModel.toMap() returns supplied value for each field',
        () {
      userModel = FinancialAdvisorModel(
        firstName: 'firstName',
        lastName: 'lastName',
        userType: 'userType',
        licenseID: 'licenseID',
      );
      expect(
        userModel.toMap(),
        {
          'firstName': 'firstName',
          'lastName': 'lastName',
          'userType': 'userType',
          'licenseID': 'licenseID',
        },
      );
    });

    test('FinancialAdvisorModel.fromMap(map) returns map values in FinancialAdvisorModel format', () {
      userModel = FinancialAdvisorModel.fromMap(
        {
          'firstName': 'firstName',
          'lastName': 'lastName',
          'userType': 'userType',
          'licenseID': 'licenseID',
        },
      );
      expect(
        userModel.toMap(),
        {
          'firstName': 'firstName',
          'lastName': 'lastName',
          'userType': 'userType',
          'licenseID': 'licenseID',
        },
      );
    });

    test('getUserType() returns userType of FinancialAdvisorModel instance', () {
      userModel = FinancialAdvisorModel(
        firstName: 'firstName',
        lastName: 'lastName',
        userType: 'userType',
        licenseID: 'licenseID',
      );
      expect(
        userModel.getUserType(),
        'userType',
      );
    });
  });
}
