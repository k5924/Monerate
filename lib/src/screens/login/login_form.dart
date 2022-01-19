// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _showPassword = false;

  final AuthProvider authProvider = AuthProvider();

  late String verified;
  late Object completeProfile;

  @override
  void dispose() {
    // Clean up controllers when form is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<String?> _checkCredentials() async {
    return authProvider.signIn(
      emailController.text,
      passwordController.text,
    );
  }

  Future<String?> _getUserType() async {
    return authProvider.getUserType();
  }

  Future<Object> _isProfileComplete() async {
    return authProvider.checkProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: EmailValidator().validateEmail,
              onSaved: (value) {
                emailController.text = value!;
              },
              decoration: const InputDecoration(
                hintText: 'Email Address',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              validator: PasswordValidator().validatePassword,
              obscureText: !_showPassword,
              textInputAction: TextInputAction.done,
              onSaved: (password) {
                passwordController.text = password!;
              },
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: GestureDetector(
                  onTap: () => setState(() {
                    _showPassword = !_showPassword;
                  }),
                  child: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
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
                  verified = (await _checkCredentials())!;
                  if (verified == "Email Verified") {
                    completeProfile = await _isProfileComplete();
                    if (completeProfile == true) {
                      final userType = await _getUserType();
                      if(userType == "End-User"){
                        Navigator.pushReplacementNamed(
                          context,
                          EndUserDashboardScreen.kID,
                        );
                        EasyLoading.dismiss();
                      }
                      else if(userType == "Financial Advisor"){
                        Navigator.pushReplacementNamed(
                          context,
                          FinancialAdvisorDashboardScreen.kID,
                        );
                        EasyLoading.dismiss();
                      }
                      else if(userType == "Support Manager"){
                        Navigator.pushReplacementNamed(
                          context,
                          SupportManagerDashboardScreen.kID,
                        );
                        EasyLoading.dismiss();
                      }
                      else{
                        EasyLoading.showError(userType.toString());
                      }
                      EasyLoading.dismiss();
                    } else if (completeProfile == false) {
                      Navigator.pushNamed(
                        context,
                        CompleteProfileScreen.kID,
                      );
                      EasyLoading.dismiss();
                    } else {
                      EasyLoading.showError(completeProfile.toString());
                    }
                  } else {
                    EasyLoading.showError(verified);
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
                "Login",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
