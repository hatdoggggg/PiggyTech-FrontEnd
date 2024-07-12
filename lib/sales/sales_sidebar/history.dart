import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReceiptWidget(),
      ),
    );
  }
}

class ReceiptWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SRAPS\nCalaca City",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Bill To", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Rinalyn Oriendo"),
                Text("Balimbbing"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cashier", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Vhenus Tumbaga"),
                Text("Cahil"),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        Text("Receipt #: INT-001"),
        Text("Receipt Date: 11/02/2019"),
        Text("P.O. #: 2412/2019"),
        Text("Due Date: 26/02/2019"),
        SizedBox(height: 16),
        Table(
          border: TableBorder.all(),
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text("QTY", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text("DESCRIPTION", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text("UNIT PRICE", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text("AMOUNT", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ]),
            _buildTableRow("1", "Mega Booster", "1500.00", "1500.00"),
            _buildTableRow("2", "Muscle Max Starter", "1500", "1500.00"),
            _buildTableRow("3", "CJ Supreme Pre Growe", "1500.00", "1500.00"),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Subtotal: \4500.00"),
                Text(
                  "TOTAL: \4500.00",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        Text("Terms & Conditions", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Payment is due within 15 days"),
        SizedBox(height: 16),
        Text("GCASH"),
        Text("Account number: 1234567890"),
      ],
    );
  }

  TableRow _buildTableRow(String qty, String description, String unitPrice, String amount) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(qty),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(description),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(unitPrice),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(amount),
      ),
    ]);
  }
}
