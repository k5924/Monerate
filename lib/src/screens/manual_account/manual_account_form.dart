import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';

class ManualAccountForm extends StatefulWidget {
  const ManualAccountForm({Key? key}) : super(key: key);

  @override
  State<ManualAccountForm> createState() => _ManualAccountFormState();
}

class _ManualAccountFormState extends State<ManualAccountForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);

  Future<bool> _addAccount() async {
    EasyLoading.show(status: 'loading...');

    final result2 = await authProvider.addFinanceAccount(
      name: nameController.text,
      symbol: '',
      type: "Manual",
      amount: '1',
      price: valueController.text,
    );
    if (result2 != null) {
      EasyLoading.showError(result2);
      return false;
    } else {
      EasyLoading.showSuccess("Account to portfolio");
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              validator: (value) {
                if (Validator().presenceDetection(value) == false) {
                  return 'You must provide a name for this account';
                }
                return null;
              },
              onSaved: (value) {
                valueController.text = value!;
              },
              decoration: const InputDecoration(
                hintText: 'Enter Account name',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: valueController,
              validator: AmountValidator().validateAmount,
              onSaved: (value) {
                valueController.text = value!;
              },
              decoration: const InputDecoration(
                hintText: 'Enter Current Value',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final opResult = await _addAccount();
                  if (opResult == true) {
                    // ignore: use_build_context_synchronously
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName(EndUserDashboardScreen.kID),
                    );
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
                "Add Account",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
