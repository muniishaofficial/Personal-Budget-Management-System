import 'package:flutter/material.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.all(8),
          child: const Icon(
            Icons.account_balance_wallet,
            size: 32,
            color: Colors.indigo,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: 'USD',
                  underline: Container(),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: <String>['USD', 'EUR', 'GBP']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(color: Colors.black)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Handle dropdown value change
                  },
                ),
                const SizedBox(width: 16),
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('All Transactions',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: const Text('All Categories',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildTransactionItem(
                    Icons.shopping_bag,
                    Colors.blue[100]!,
                    'Whole Foods Market',
                    'Apr 15, 2024',
                    'Groceries',
                    '-\$156.24',
                    Colors.red,
                  ),
                  _buildTransactionItem(
                    Icons.business,
                    Colors.green[100]!,
                    'Salary Deposit',
                    'Apr 14, 2024',
                    'Income',
                    '+\$4,850.00',
                    Colors.green,
                  ),
                  _buildTransactionItem(
                    Icons.movie,
                    Colors.purple[100]!,
                    'Netflix Subscription',
                    'Apr 13, 2024',
                    'Entertainment',
                    '-\$14.99',
                    Colors.red,
                  ),
                  _buildTransactionItem(
                    Icons.electric_bolt,
                    Colors.yellow[100]!,
                    'Electric Bill',
                    'Apr 12, 2024',
                    'Utilities',
                    '-\$85.00',
                    Colors.red,
                  ),
                  _buildTransactionItem(
                    Icons.restaurant,
                    Colors.red[100]!,
                    'Restaurant',
                    'Apr 11, 2024',
                    'Dining',
                    '-\$45.80',
                    Colors.red,
                  ),
                  _buildTransactionItem(
                    Icons.local_gas_station,
                    Colors.blue[100]!,
                    'Gas Station',
                    'Apr 10, 2024',
                    'Transportation',
                    '-\$42.50',
                    Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(
    IconData icon,
    Color iconBgColor,
    String title,
    String date,
    String category,
    String amount,
    Color amountColor,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: iconBgColor,
        child: Icon(icon,
            color: iconBgColor == Colors.yellow[100]
                ? Colors.yellow
                : iconBgColor.withRed(100).withGreen(100).withBlue(100)),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('$date • $category'),
      trailing:
          Text(amount, style: TextStyle(color: amountColor, fontSize: 16)),
    );
  }
}
