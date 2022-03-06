import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/auth_provider.dart';
import 'package:monerate/src/providers/database_provider.dart';
import 'package:monerate/src/screens/export.dart';

class AccountBalancesTab extends StatefulWidget {
  final String uid;
  const AccountBalancesTab({Key? key, required this.uid}) : super(key: key);

  @override
  _AccountBalancesTabState createState() => _AccountBalancesTabState();
}

class _AccountBalancesTabState extends State<AccountBalancesTab> {
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);
  final DatabaseProvider databaseProvider =
      DatabaseProvider(db: FirebaseFirestore.instance);
  late Stream<QuerySnapshot<Object?>> balanceStream = databaseProvider
      .balanceCollection
      .where('userID', isEqualTo: widget.uid)
      .snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: balanceStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final balancesDB = snapshot.data!.docs;
                    balancesDB.sort(
                      (a, b) =>
                          a['type'].toString().compareTo(b['type'].toString()),
                    );
                    final List<BalanceModel> balances = <BalanceModel>[];
                    for (final item in balancesDB) {
                      final balance = BalanceModel(
                        amount: item['amount'].toString(),
                        name: item['name'].toString(),
                        price: item['price'].toString(),
                        symbol: item['symbol'].toString(),
                        type: item['type'].toString(),
                        userID: item['userID'].toString(),
                      );
                      balances.add(balance);
                    }
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: balances.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          child: ListTile(
                            title: Text(
                              balances[index].name,
                            ),
                            trailing: balances[index].type == 'Cryptocurrency'
                                ? Text(
                                    'Holdings: ${balances[index].amount}',
                                  )
                                : Text(
                                    "Price £${(double.parse(balances[index].amount) * double.parse(balances[index].price)).toStringAsFixed(2)}",
                                  ),
                            subtitle: balances[index].type == 'Stock'
                                ? Text(
                                    'Ticker: ${balances[index].symbol} Type: ${balances[index].type} Holdings: ${balances[index].amount}',
                                  )
                                : Text(
                                    'Type: ${balances[index].type}',
                                  ),
                            onTap: () {},
                          ),
                        );
                      },
                    );
                  }
                },
              )
            ],
          ),
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
            onTap: () {
              Navigator.pushNamed(
                context,
                SearchInvestmentScreen.kID,
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.money),
            label: 'Cryptocurrency Investments',
            onTap: () {
              Navigator.pushNamed(
                context,
                SelectCryptoExchangeScreen.kID,
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.account_balance),
            label: 'Bank Accounts',
            onTap: () {},
          ),
          SpeedDialChild(
            child: const Icon(Icons.account_balance),
            label: 'Manual Accounts',
            onTap: () {
              Navigator.pushNamed(
                context,
                ManualAccountScreen.kID,
              );
            },
          ),
        ],
      ),
    );
  }
}
