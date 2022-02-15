import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AccountBalancesTab extends StatefulWidget {
  const AccountBalancesTab({Key? key}) : super(key: key);

  @override
  _AccountBalancesTabState createState() => _AccountBalancesTabState();
}

class _AccountBalancesTabState extends State<AccountBalancesTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Account Balances",
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        overlayColor: Colors.black,
        overlayOpacity: .4,
        spacing: 12,
        spaceBetweenChildren: 12,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.trending_up),
            label: 'Stock Market Investments',
            onTap: () {},
          ),
          SpeedDialChild(
            child: const Icon(Icons.money),
            label: 'Cryptocurrency Investments',
            onTap: () {},
          ),
          SpeedDialChild(
            child: const Icon(Icons.account_balance),
            label: 'Bank Accounts',
            onTap: () {},
          ),
          SpeedDialChild(
            child: const Icon(Icons.account_balance),
            label: 'Manual Accounts',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
