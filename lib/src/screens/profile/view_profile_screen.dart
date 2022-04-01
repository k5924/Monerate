// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';
import 'package:monerate/src/widgets/export.dart';

class ViewProfileScreen extends StatefulWidget {
  static const String kID = 'view_profile_screen';

  const ViewProfileScreen({Key? key}) : super(key: key);

  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);

  void _closeDialogBox() {
    return Navigator.pop(context);
  }

  Future<String?> _displayConfirmationDialog() {
    return customAlertDialog(
      context: context,
      title: "Confirm Delete Account",
      content:
          "By continuing, you agree to delete your account and your account information. Although your account will be deleted, some metadata related to your account will remain. Do you wish to continue?",
      actions: [
        OutlinedButton(
          onPressed: () => _closeDialogBox(),
          child: const Text(
            "Cancel",
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            EasyLoading.show(status: 'loading...');
            final result = await authProvider.deleteUserAccount();
            if (result == null) {
              Navigator.popAndPushNamed(
                context,
                LoginScreen.kID,
              );
              EasyLoading.showSuccess('Account Deleted');
            } else {
              _closeDialogBox();
              EasyLoading.showError(result);
            }
          },
          child: const Text("Delete My Account"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? profileDetails =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return CenteredScrollViewWithAppBar(
      appBarTitle: "View Personal Details",
      floatingActionButton: null,
      children: [
        Text(
          'Firstname',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          profileDetails!['firstName'].toString().capitalize(),
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Lastname',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          profileDetails['lastName'].toString().capitalize(),
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: 20,
        ),
        OutlinedButton.icon(
          onPressed: () async {
            await _displayConfirmationDialog();
          },
          icon: const Icon(Icons.delete_forever),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: Colors.red,
            ),
          ),
          label: const Text(
            "Delete Account",
          ),
        ),
      ],
    );
  }
}
