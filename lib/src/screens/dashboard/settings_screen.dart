// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthProvider authProvider = AuthProvider();

  Future<String?>? _signOut() async {
    return authProvider.logout();
  }

  Future<Object> _viewPersonalDetails() async {
    return authProvider.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Settings",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
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
                tileColor: Colors.blue,
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
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
                tileColor: Colors.purple,
              )
            ],
          ),
        ),
      ),
    );
  }
}
