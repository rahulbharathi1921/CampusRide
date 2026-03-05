import 'package:bus_tracking_app/screens/bus_details_screen.dart';
import 'package:bus_tracking_app/screens/sos_sreen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart'; // <-- adjust the path if needed

class DashboardScreen extends StatefulWidget {
  final String busId;
  const DashboardScreen({super.key, required this.busId});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Color buttonColor = const Color(0xFF7797FF);
  final Color boxColor = const Color(0xFF5A6EE6);

  final List<String> dailyMessages = [
    "Believe you can and you're halfway there.",
    "Push yourself, because no one else will.",
    "Great things never come from comfort zones.",
    "Dream it. Wish it. Do it.",
    "Success doesn't just find you. Go get it.",
    "Don't stop when you're tired. Stop when you're done.",
    "Little things make big days.",
    "Work hard in silence. Let success make the noise.",
    "Stay positive, work hard, make it happen.",
  ];

  String getDailyMessage() {
    final int day = DateTime.now().day;
    return dailyMessages[(day - 1) % dailyMessages.length];
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Morning";
    if (hour < 17) return "Afternoon";
    return "Evening";
  }

  String _getBusName(String busId) {
    String lastTwo = busId.substring(busId.length - 2);
    if (lastTwo.startsWith("0")) lastTwo = lastTwo.substring(1);
    return "DMI - $lastTwo";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                color: boxColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good ${_getGreeting()},",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getBusName(widget.busId),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // ✅ Space above quote
            const SizedBox(height: 70),

            // ✅ Quote
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '"',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: buttonColor,
                      ),
                    ),
                    TextSpan(
                      text: getDailyMessage(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: '"',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: buttonColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),

            // ✅ Middle content (buttons stay centered)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ETA & Speed
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: _infoBox(title: "ETA", value: "15 min"),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _infoBox(title: "Speed", value: "40 km/h"),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Track + Seats
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: _squareButton(
                            title: "Track Bus",
                            icon: Icons.directions_bus,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _squareButton(
                            title: "Seats",
                            icon: Icons.event_seat,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // SOS
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: _ovalButton(
                      title: "SOS",
                      icon: Icons.warning,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SosScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Footer (Logout + Bus Details)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _ovalButton(
                      title: "Logout",
                      icon: Icons.logout,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _ovalButton(
                      title: "Bus Details",
                      icon: Icons.info,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    BusDetailsScreen(busId: widget.busId),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Square Button Widget
  Widget _squareButton({required String title, required IconData icon}) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 45, color: Colors.white),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Oval Button Widget
  Widget _ovalButton({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Info Box Widget
  Widget _infoBox({required String title, required String value}) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: boxColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: boxColor.withOpacity(0.4), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: boxColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: boxColor,
            ),
          ),
        ],
      ),
    );
  }
}
