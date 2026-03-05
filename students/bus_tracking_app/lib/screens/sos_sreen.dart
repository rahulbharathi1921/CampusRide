import 'package:flutter/material.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = const Color(0xFF7797FF);

    return Scaffold(
      appBar: AppBar(
        title: const Text("SOS Alert"),
        backgroundColor: Color(0xFF5A6EE6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              size: 80,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 25),
            const Text(
              "SOS Activated!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Select the type of emergency:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 40),

            // Buttons
            Column(
              children: [
                _sosButton(context, buttonColor, "Accident"),
                const SizedBox(height: 15),
                _sosButton(context, buttonColor, "Breakdown"),
                const SizedBox(height: 15),
                _sosButton(context, buttonColor, "Other", isOther: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // SOS Button Widget
  Widget _sosButton(BuildContext context, Color color, String title,
      {bool isOther = false}) {
    return GestureDetector(
      onTap: () {
        if (isOther) {
          // Show a popup dialog to specify
          showDialog(
            context: context,
            builder: (context) {
              String customMessage = "";
              return AlertDialog(
                title: const Text("Specify Emergency"),
                content: TextField(
                  onChanged: (value) {
                    customMessage = value;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter your emergency details",
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if (customMessage.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "SOS Sent: $customMessage"),
                          ),
                        );
                      }
                    },
                    child: const Text("Send"),
                  ),
                ],
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("SOS Sent: $title")),
          );
        }
      },
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
