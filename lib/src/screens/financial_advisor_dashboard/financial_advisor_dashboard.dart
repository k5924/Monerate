// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';

/// This is where all of the tabs a financial advisor would see after they login are populated
class FinancialAdvisorDashboardScreen extends StatefulWidget {
  /// This is the variable which stores the named route for this dashboard screen
  static const String kID = 'financial_advisor_dashboard_screen';

  /// This is the constructor for this screen
  const FinancialAdvisorDashboardScreen({Key? key}) : super(key: key);

  @override
  _FinancialAdvisorDashboardScreenState createState() =>
      _FinancialAdvisorDashboardScreenState();
}

class _FinancialAdvisorDashboardScreenState
    extends State<FinancialAdvisorDashboardScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

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
            children: const [
              FinancialAdvisorHomepageTab(),
              SettingsWithHelpOption(
                userType: 'Financial Advisor',
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Theme.of(context).unselectedWidgetColor,
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
