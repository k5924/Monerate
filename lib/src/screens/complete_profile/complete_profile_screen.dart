import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';

/// This is the screen which would be displayed when a user first logs into the application to choose their user type
class CompleteProfileScreen extends StatefulWidget {
  /// This variable stores the named route for this screen
  static const String kID = 'complete_profile_screen';

  /// This is the constructor for this screen
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
