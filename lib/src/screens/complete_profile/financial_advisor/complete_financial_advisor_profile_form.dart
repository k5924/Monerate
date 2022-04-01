import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';

/// This is the form which would be displayed when a user signs up as a financial advisor
class CompleteFinancialAdvisorProfileForm extends StatefulWidget {
  /// This is the constructor for this form
  const CompleteFinancialAdvisorProfileForm({Key? key}) : super(key: key);

  @override
  State<CompleteFinancialAdvisorProfileForm> createState() =>
      _CompleteFinancialAdvisorProfileFormState();
}

class _CompleteFinancialAdvisorProfileFormState
    extends State<CompleteFinancialAdvisorProfileForm> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController licenseIDController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);

  @override
  void dispose() {
    // Clean up controllers when form is disposed
    firstNameController.dispose();
    lastNameController.dispose();
    licenseIDController.dispose();
    super.dispose();
  }

  Future<String?> _updateProfile() {
    return authProvider.updateFinancialAdvisorProfile(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      userType: 'Financial Advisor',
      licenseID: licenseIDController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: firstNameController,
            validator: NameValidator().validateName,
            onSaved: (firstName) {
              firstNameController.text = firstName!;
            },
            decoration: const InputDecoration(
              hintText: 'Firstname',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: lastNameController,
            validator: NameValidator().validateName,
            onSaved: (lastName) {
              lastNameController.text = lastName!;
            },
            decoration: const InputDecoration(
              hintText: 'Lastname',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: licenseIDController,
            validator: LicenseValidator().validateLicense,
            onSaved: (licenseID) {
              licenseIDController.text = licenseID!;
            },
            decoration: const InputDecoration(
              hintText: 'License ID',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                EasyLoading.show(status: 'loading...');
                final result = await _updateProfile();
                if (result != null) {
                  EasyLoading.showError(result);
                } else {
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(
                    context,
                    FinancialAdvisorDashboardScreen.kID,
                  );
                  EasyLoading.dismiss();
                }
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
            ),
            child: const Text(
              "Submit",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
            ),
            child: const Text(
              "Back",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
