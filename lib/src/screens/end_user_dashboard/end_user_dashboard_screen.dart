// ignore_for_file: use_build_context_synchronously

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/providers/remote_config_provider.dart';
import 'package:monerate/src/screens/export.dart';

class EndUserDashboardScreen extends StatefulWidget {
  static const String kID = 'end_user_dashboard_screen';
  const EndUserDashboardScreen({Key? key}) : super(key: key);

  @override
  _EndUserDashboardScreenState createState() => _EndUserDashboardScreenState();
}

class _EndUserDashboardScreenState extends State<EndUserDashboardScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  final RemoteConfigProvider remoteConfigProvider = RemoteConfigProvider(remoteConfig: RemoteConfig.instance);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // Clean up controllers when screen is disposed
    _pageController.dispose();
    super.dispose();
  }

  Future<String> _getRemoteConfig() async {
    final key = await remoteConfigProvider.getYahooFinanceAPIKey();
    return key;
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
                        const Text(
                          "End User HomePage",
                        ),
                        TextButton(
                          onPressed: () async {
                            final result = await _getRemoteConfig();
                            print(result);
                          },
                          child: const Text(
                            "Test",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
