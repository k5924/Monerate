import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

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

  final OpenBankingProvider openBankingProvider = OpenBankingProvider();
  late LinkTokenConfiguration linkTokenConfiguration;
  final BinanceExchangeProvider binanceExchangeProvider =
      BinanceExchangeProvider();

  @override
  void initState() {
    super.initState();
  }

  Future<void> updateBalances() async {
    final keys = await binanceExchangeProvider.getKeys();
    print(keys);
  }

  Future<void> getBalances(String accessToken) async {
    final result = await openBankingProvider.getAccessToken(accessToken);
    if (result.runtimeType == String) {
      if (result != "error") {
        print(result.toString());
      } else {
        EasyLoading.showError(
          'Unable to retrieve account balances, please try again later',
        );
      }
    } else {
      EasyLoading.showError(
        'Unable to access Plaid Endpoint, please try again later',
      );
    }
  }

  void _onSuccessCallback(
      String publicToken, LinkSuccessMetadata metadata) async {
    // iterate through accounts and store name and subtype
    final result = await openBankingProvider.getAccessToken(publicToken);
    if (result.runtimeType == String) {
      if (result != "error") {
        await getBalances(result.toString());
      } else {
        EasyLoading.showError(
          'Unable to retrieve access token, please try again later',
        );
      }
    } else {
      EasyLoading.showError(
        'Unable to access Plaid Endpoint, please try again later',
      );
    }
  }

  void _onExitCallback(LinkError? error, LinkExitMetadata metadata) {
    print("onExit metadata: ${metadata.description()}");

    if (error != null) {
      EasyLoading.showError(
        error.message,
      );
    }
  }

  Future<void> _connectToPlaid() async {
    final result = await openBankingProvider.getLinkToken();
    print(result);
    if (result.runtimeType == String) {
      if (result != "error") {
        PlaidLink.open(
          configuration: LinkTokenConfiguration(
            token: result.toString(),
          ),
        );
        PlaidLink.onSuccess(_onSuccessCallback);
        PlaidLink.onExit(_onExitCallback);
      } else {
        EasyLoading.showError(
          'Unable to retrieve API keys, please try again later',
        );
      }
    } else {
      EasyLoading.showError(
          'Unable to access Plaid Endpoint, please try again later');
    }
  }

  Widget displayingSubtitle(BalanceModel balance) {
    if (balance.type == 'Stock') {
      return Text(
        'Ticker: ${balance.symbol} Type: ${balance.type} Holdings: ${balance.amount}',
      );
    } else if( (balance.type == 'Cryptocurrency') | (balance.type == 'Openbanking')) {
      return Text(
        'Provider: ${balance.symbol} Type: ${balance.type}',
      );
    } else{
      return Text(
        'Type: ${balance.type}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await updateBalances();
        },
        child: Center(
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
                        (a, b) => a['type']
                            .toString()
                            .compareTo(b['type'].toString()),
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
                              subtitle: displayingSubtitle(balances[index]),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewAccountScreen(
                                      balance: balances[index],
                                    ),
                                  ),
                                );
                              },
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
            onTap: () async {
              await _connectToPlaid();
            },
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
