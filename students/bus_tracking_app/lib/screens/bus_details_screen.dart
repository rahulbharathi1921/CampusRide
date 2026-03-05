import 'package:flutter/material.dart';

class BusDetailsScreen extends StatelessWidget {
  final String busId; // You can pass bus info if needed

  const BusDetailsScreen({super.key, required this.busId});

  @override
  Widget build(BuildContext context) {
    final Color boxColor = const Color(0xFF5A6EE6);

    // MOCK DATA
    final String driverName = "R.Joel";
    final String driverContact = "+91 98765 43210"; // NEW
    final String busNumber = "TN-74-AB-1234";
    final String lastFCDate = "15-Jan-2026";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bus Details"),
        backgroundColor: boxColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _infoCard(title: "Driver Name", value: driverName, color: boxColor),
            const SizedBox(height: 20),
            _infoCard(title: "Driver Contact", value: driverContact, color: boxColor), // NEW
            const SizedBox(height: 20),
            _infoCard(title: "Bus Number", value: busNumber, color: boxColor),
            const SizedBox(height: 20),
            _infoCard(title: "Last FC Date", value: lastFCDate, color: boxColor),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({required String title, required String value, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: color.withOpacity(0.4), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
