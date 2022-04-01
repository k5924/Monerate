import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';

class SearchInvestmentScreen extends StatefulWidget {
  static const String kID = 'search_investment_screen';
  const SearchInvestmentScreen({Key? key}) : super(key: key);

  @override
  _SearchInvestmentScreenState createState() => _SearchInvestmentScreenState();
}

class _SearchInvestmentScreenState extends State<SearchInvestmentScreen> {
  final TextEditingController searchController = TextEditingController();
  late List<TickerModel> investments = <TickerModel>[];
  final YahooFinanceProvider yahooFinanceProvider = YahooFinanceProvider();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _getInvestment() async {
    EasyLoading.show(status: 'loading...');
    final result = await yahooFinanceProvider.getTickerSymbol(
      searchParameter: searchController.text,
    );
    if (result.runtimeType == String) {
      EasyLoading.showError(
        "An error was encountered, investments have not been fetched",
      );
    } else {
      setState(() {
        investments = result as List<TickerModel>;
        EasyLoading.dismiss();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Search for Investment"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onSubmitted: (search) async {
                searchController.text = search;
                if (Validator().presenceDetection(searchController.text)) {
                  investments.clear();
                  await _getInvestment();
                }
              },
              decoration: const InputDecoration(
                hintText: 'Enter Investment Name',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: investments.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      investments[index].longName,
                    ),
                    subtitle: Text(
                      "Exchange ${investments[index].exchange}\nTicker Symbol: ${investments[index].symbol}",
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProvideInvestmentDetails(
                            investment: investments[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
