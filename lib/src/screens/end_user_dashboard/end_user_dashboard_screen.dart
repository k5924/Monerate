// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';

class EndUserDashboardScreen extends StatefulWidget {
  static const String kID = 'end_user_dashboard_screen';
  const EndUserDashboardScreen({Key? key}) : super(key: key);

  @override
  _EndUserDashboardScreenState createState() => _EndUserDashboardScreenState();
}

class _EndUserDashboardScreenState extends State<EndUserDashboardScreen> {
  int _currentIndex = 0;
  String uid = '';
  late PageController _pageController;
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);
  final DatabaseProvider databaseProvider =
      DatabaseProvider(db: FirebaseFirestore.instance);

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // Clean up controllers when screen is disposed
    _pageController.dispose();
    super.dispose();
  }

  Future<void> getCurrentUser() async {
    try {
      uid = await authProvider.getUID();
    } on FirebaseAuthException catch (e) {
      final exceptionsFactory = ExceptionsFactory(e.code);
      EasyLoading.showError(exceptionsFactory.exceptionCaught()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "End User HomePage",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const NewsTab(),
              AccountBalancesTab(
                uid: uid,
              ),
              const SettingsWithHelpOption(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            _currentIndex = value;
            _pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear,
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chrome_reader_mode),
              label: "News",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: "Balances",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
