import 'package:flutter/material.dart';
import 'package:milkton_executive/utils/launch_url.dart';

class DeveloperInfoScreen extends StatelessWidget {
  const DeveloperInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Developer Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(
                "assets/images/gepton.png",
              ),
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                "Gepton is a leading technology firm specializing in creating innovative and efficient digital solutions. Our team of expert techies, are passionate about building exceptional tech solutions for your unique requirements."),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => openUrl("tel:+919099199104"),
                  child: const Card(
                    semanticContainer: true,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.call,
                          ),
                          Text("9099199104"),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => openUrl("mailto:notify@gepton.com"),
                  child: const Card(
                    semanticContainer: true,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.mail,
                          ),
                          Text("notify@gepton.com"),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => openUrl("https://gepton.com"),
                  child: const Card(
                    semanticContainer: true,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.web,
                          ),
                          Text("gepton.com"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
