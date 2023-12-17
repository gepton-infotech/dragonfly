import 'package:flutter/material.dart';
import 'package:milkton_executive/presentation/widgets/top_nav_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title}) : super();
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepOrangeAccent,
          title: Text(title),
          actions: const [
            Icon(Icons.search),
            SizedBox(width: 12),
          ],
        ),
        drawer: const TopNavDrawer(),
        body: const Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                    child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Welcome to Milkton Executive',
                    style: TextStyle(fontSize: 24),
                  ),
                )),
              ],
            ),
          ),
        ));
  }
}
