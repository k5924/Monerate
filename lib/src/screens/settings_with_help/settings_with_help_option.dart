// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';

/// This is the settings tab for financial advisors and end-users
class SettingsWithHelpOption extends StatefulWidget {
  /// This variable will store the userType of the user using the application
  final String userType;

  /// This is the constructor for this tab which will assign the userType variable
  const SettingsWithHelpOption({Key? key, required this.userType})
      : super(key: key);

  @override
  _SettingsWithHelpOptionState createState() => _SettingsWithHelpOptionState();
}

class _SettingsWithHelpOptionState extends State<SettingsWithHelpOption> {
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);

  Future<String?>? _signOut() async {
    return authProvider.logout();
  }

  Future<Object> _viewPersonalDetails() async {
    return authProvider.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return CenteredScrollView(
      children: [
        Text(
          "Settings",
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: 20,
        ),
        Card(
          elevation: 8,
          child: ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Personal Details"),
            onTap: () async {
              EasyLoading.show(status: 'loading...');
              final result = await _viewPersonalDetails();
              if (result.runtimeType == String) {
                EasyLoading.showError(result.toString());
              } else {
                Navigator.pushNamed(
                  context,
                  ViewProfileScreen.kID,
                  arguments: result,
                );
                EasyLoading.dismiss();
              }
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Card(
          elevation: 8,
          child: ListTile(
            leading: const Icon(Icons.email),
            title: const Text("Change Email"),
            onTap: () => Navigator.pushNamed(
              context,
              ChangeEmailScreen.kID,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Card(
          elevation: 8,
          child: ListTile(
            leading: const Icon(Icons.password),
            title: const Text("Change Password"),
            onTap: () => Navigator.pushNamed(
              context,
              ChangePasswordScreen.kID,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Card(
          elevation: 8,
          child: ListTile(
            leading: const Icon(Icons.support),
            title: const Text("Contact Support"),
            onTap: () {
              if (widget.userType == 'End-User') {
                Navigator.pushNamed(
                  context,
                  ChooseSupportScreen.kID,
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const PreviousMessagesScreen(chatType: 'support'),
                  ),
                );
              }
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Card(
          elevation: 8,
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () async {
              EasyLoading.show();
              final result = await _signOut();
              if (result != null) {
                EasyLoading.showError(result);
              } else {
                Navigator.pushReplacementNamed(
                  context,
                  LoginScreen.kID,
                );
                EasyLoading.dismiss();
              }
            },
          ),
        ),
      ],
    );
  }
}
