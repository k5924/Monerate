import 'package:flutter/material.dart';
import 'package:monerate/src/utilities/export.dart';
import 'package:monerate/src/widgets/export.dart';

class CompleteSupportManagerProfile extends StatefulWidget {
  static const String kID = 'complete_support_manager_profile';
  const CompleteSupportManagerProfile({Key? key}) : super(key: key);

  @override
  _CompleteSupportManagerProfileState createState() =>
      _CompleteSupportManagerProfileState();
}

class _CompleteSupportManagerProfileState
    extends State<CompleteSupportManagerProfile> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                    if (_formKey.currentState!.validate()) {}
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
}
