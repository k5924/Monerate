import 'package:flutter/material.dart';
import 'package:monerate/src/screens/complete_profile/export.dart';

class CompleteProfileScreen extends StatefulWidget {
  static const String kID = 'complete_profile_screen';
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
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
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: const [
            EndUserTab(),
            FinancialAdvisorTab(),
            SupportManagerTab()
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
            icon: Icon(Icons.account_balance_wallet),
            label: "End-user",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: "Financial Advisor",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_help),
            label: "Support Manager",
          ),
        ],
      ),
    );
  }
}
