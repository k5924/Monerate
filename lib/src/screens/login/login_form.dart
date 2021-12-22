import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    // Clean up controllers when form is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushNamed(
                    context,
                    MyHomePage.kID,
                  );
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
