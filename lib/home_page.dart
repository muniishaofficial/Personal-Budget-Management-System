// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/Profile.dart';
import 'add_expense_dialog.dart';
import 'add_income_dialog.dart';
import 'add_budget_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int touchedIndex = -1;
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
                      );
                    },
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBalanceCard(),
              const SizedBox(height: 16),
              _buildActionButtons(context),
              const SizedBox(height: 16),
              _buildSpendingOverview(),
              const SizedBox(height: 16),
              _buildRecentTransactions(),
              const SizedBox(height: 16),
              _buildBudgetStatus(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Balance',
                        style: TextStyle(color: Colors.grey, fontSize: 16)),
                    Text('\$24,562.80',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
                SizedBox(
                  width: 64,
                  height: 64,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          color: Colors.white,
                          value: 75,
                          title: '',
                          radius: 12,
                        ),
                        PieChartSectionData(
                          color: Colors.grey[700]!,
                          value: 25,
                          title: '',
                          radius: 12,
                        ),
                      ],
                      sectionsSpace: 0,
                      centerSpaceRadius: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Income',
                        style: TextStyle(color: Colors.grey, fontSize: 16)),
                    Text('+\$8,245.00',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Expenses',
                        style: TextStyle(color: Colors.grey, fontSize: 16)),
                    Text('-\$3,482.20',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the Add Expense dialog
  void _showAddExpenseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddExpenseDialog();
      },
    );
  }

  // Function to show the Add Income dialog
  void _showAddIncomeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddIncomeDialog();
      },
    );
  }

  // Function to show the Add Budget dialog
  void _showAddBudgetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddBudgetDialog();
      },
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              _showAddExpenseDialog(context);
            },
            icon: const Icon(Icons.add, size: 20),
            label: const Text('Add Expense',
                style: TextStyle(fontSize: 16, color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () {
              _showAddIncomeDialog(context);
            },
            icon: const Icon(Icons.add, size: 20),
            label: const Text('Add Income',
                style: TextStyle(
                  fontSize: 16,
                )),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () {
              _showAddBudgetDialog(context);
            },
            icon: const Icon(Icons.account_balance_wallet, size: 20),
            label: const Text('Set Budget', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpendingOverview() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Spending Overview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 280,
              child: MouseRegion(
                onHover: (PointerHoverEvent event) {
                  final pieChart = context.findRenderObject() as RenderBox;
                  final localPosition = pieChart.globalToLocal(event.position);
                  final pieChartSize = pieChart.size;

                  for (int i = 0; i < showingSections().length; i++) {
                    final section = showingSections()[i];
                    final sectionCenter = Offset(
                      pieChartSize.width / 2 +
                          section.radius *
                              cos(2 * pi * i / showingSections().length),
                      pieChartSize.height / 2 +
                          section.radius *
                              sin(2 * pi * i / showingSections().length),
                    );

                    final distance = (localPosition - sectionCenter).distance;

                    if (distance < section.radius + 10) {
                      setState(() {
                        touchedIndex = i;
                      });
                      return;
                    }
                  }

                  setState(() {
                    touchedIndex = -1;
                  });
                },
                onExit: (event) {
                  setState(() {
                    touchedIndex = -1;
                  });
                },
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 5,
                    centerSpaceRadius: 60,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.indigo, size: 14),
                      SizedBox(width: 4),
                      Text('Food & Dining', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.amber, size: 14),
                      SizedBox(width: 4),
                      Text('Transportation', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.green, size: 14),
                      SizedBox(width: 4),
                      Text('Shopping', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.purple, size: 14),
                      SizedBox(width: 4),
                      Text('Entertainment', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.blueGrey, size: 14),
                      SizedBox(width: 4),
                      Text('Others', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 12.0;
      final radius = isTouched ? 60.0 : 50.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.indigo,
            value: 450,
            title: isTouched ? 'Food & Dining' : '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.amber,
            value: 180,
            title: isTouched ? 'Transportation' : '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green,
            value: 320,
            title: isTouched ? 'Shopping' : '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.purple,
            value: 250,
            title: isTouched ? 'Entertainment' : '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: Colors.blueGrey,
            value: 150,
            title: isTouched ? 'Others' : '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  Widget _buildRecentTransactions() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Recent Transactions',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: const Text('See All',
                      style: TextStyle(color: Colors.indigo)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: const Icon(Icons.shopping_bag, color: Colors.blue),
              ),
              title: const Text('Whole Foods Market'),
              subtitle: const Text('Groceries'),
              trailing:
                  const Text('-\$89.50', style: TextStyle(color: Colors.red)),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green[100],
                child: const Icon(Icons.business, color: Colors.green),
              ),
              title: const Text('Salary Deposit'),
              subtitle: const Text('Income'),
              trailing: const Text('+\$3,240.50',
                  style: TextStyle(color: Colors.green)),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.purple[100],
                child: const Icon(Icons.movie, color: Colors.purple),
              ),
              title: const Text('Netflix Subscription'),
              subtitle: const Text('Entertainment'),
              trailing:
                  const Text('-\$14.99', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetStatus() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Budget Status',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildBudgetProgress('Food & Dining', 450, 600, Colors.indigo),
            const SizedBox(height: 8),
            _buildBudgetProgress('Transportation', 180, 200, Colors.amber),
            const SizedBox(height: 8),
            _buildBudgetProgress('Shopping', 320, 400, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetProgress(
      String label, int current, int total, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text('\$$current/\$$total'),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: current / total,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/login');
        break;
      case 1:
        Navigator.pushNamed(context, '/home');
        break;
      case 2:
        Navigator.pushNamed(context, '/transactions');
        break;
      case 3:
        Navigator.pushNamed(context, '/reports');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }
}
