import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController busIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey busIdKey = GlobalKey();

  double girlTop = 0;

  final Map<String, String> busCredentials = {
    "0101": "2001",
    "0202": "2002",
    "0303": "2003",
    "0404": "2004",
    "0505": "2005",
    "0606": "2006",
    "0707": "2007",
    "0808": "2008",
    "0909": "2009",
    "1010": "2010",
    "1111": "2011",
    "1212": "2012",
    "1313": "2013",
  };

  void login() {
    String busId = busIdController.text.trim();
    String password = passwordController.text.trim();

    if (busCredentials.containsKey(busId) &&
        busCredentials[busId] == password) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen(busId: busId)),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Login Failed"),
          content: const Text("Invalid Bus ID or Password"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  // 🎯 Calculate girl's hand position
  void calculateGirlPosition() {
    final RenderBox box =
        busIdKey.currentContext!.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);
    final size = box.size;

    setState(() {
      // Align hand to center of Bus ID field
      // Adjust by image height so hand touches field
      girlTop = position.dy + size.height / 2 - (MediaQuery.of(context).size.height * 0.19);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateGirlPosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;

    final cardWidth = isMobile ? screenWidth * 0.85 : 420.0;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF7797FF),
        child: Stack(
          children: [
            
            Center(
              child: SingleChildScrollView(
                child: Container(
                  width: cardWidth,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white.withAlpha((0.15 * 255).toInt()),
                    border: Border.all(
                      color: Colors.white.withAlpha((0.3 * 255).toInt()),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.25 * 255).toInt()),
                        blurRadius: 25,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "CampusRide Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 80),

                      // 🚌 BUS ID FIELD
                      TextField(
                        key: busIdKey,
                        controller: busIdController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Bus ID",
                          hintStyle: const TextStyle(color: Colors.white70),
                          prefixIcon: const Icon(
                            Icons.directions_bus,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Colors.white.withAlpha(
                            (0.2 * 255).toInt(),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 🔒 PASSWORD FIELD
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.white70),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Colors.white.withAlpha(
                            (0.2 * 255).toInt(),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // 🔵 LOGIN BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F46E5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 246, 246, 246),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // GIRL BESIDE LOGIN CARD
            Positioned(
              right: isMobile ? -40 : screenWidth / 2 - cardWidth / 2 - 110,
              top: (girlTop > 0 ? girlTop : screenHeight * 0.4) - 12,
              child: Image.asset(
                "assets/girl.png",
                height: isMobile ? screenHeight * 0.55 : screenHeight * 0.63,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
