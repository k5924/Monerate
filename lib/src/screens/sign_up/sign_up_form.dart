import 'package:flutter/material.dart';
import 'package:monerate/src/utilities/export.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 50),
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
              controller: confirmEmailController,
              keyboardType: TextInputType.emailAddress,
              validator: EmailValidator().validateEmail,
              onSaved: (value) {
                confirmEmailController.text = value!;
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
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSaved: (password) {
                passwordController.text = password!;
              },
              decoration: const InputDecoration(
                hintText: 'Password',
                // suffixIcon: GestureDetector(
                //   onTap: () => setState(() {
                //     _showPassword = !_showPassword;
                //   }),
                //   child: Icon(
                //     _showPassword ? Icons.visibility : Icons.visibility_off,
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
