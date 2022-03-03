// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';
import 'package:monerate/src/widgets/export.dart';

class CompleteEndUserProfile extends StatefulWidget {
  static const String kID = 'complete_end_user_profile';
  const CompleteEndUserProfile({Key? key}) : super(key: key);

  @override
  _CompleteEndUserProfileState createState() => _CompleteEndUserProfileState();
}

class _CompleteEndUserProfileState extends State<CompleteEndUserProfile> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);

  @override
  void dispose() {
    // Clean up controllers when form is disposed
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CenteredScrollView(
      children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
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
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      EasyLoading.show(status: 'loading...');
                      final result = await _updateProfile();
                      if (result != null) {
                        EasyLoading.showError(result);
                      } else {
                        Navigator.pushReplacementNamed(
                          context,
                          EndUserDashboardScreen.kID,
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
          ),
        ),
      ],
    );
  }

  Future<String?> _updateProfile() {
    return authProvider.updateUserProfile(
      firstNameController.text,
      lastNameController.text,
      'End-User',
    );
  }
}
