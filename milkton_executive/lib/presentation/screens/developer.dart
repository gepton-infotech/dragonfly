import 'package:flutter/material.dart';

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
      body: const Center(
        child: Text("Developer Info Coming Soon..."),
      ),
    );
  }
}
