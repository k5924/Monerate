// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';

class DashboardScreen extends StatefulWidget {
  static const String kID = 'dashboard_screen';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  final AuthProvider authProvider = AuthProvider();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  Future<String?>? _signOut() async {
    return authProvider.logout();
  }

  @override
  void dispose() {
    // Clean up controllers when screen is disposed
    _pageController.dispose();
    super.dispose();
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
                      children: const [
                        Text(
                          "HomePage",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppBar(
                          title: const Text(
                            "Settings",
                          ),
                        ),
                        // const Text(
                        //   "Settings",
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: const Text("View Profile"),
                          onTap: () {},
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
              ),
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
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
