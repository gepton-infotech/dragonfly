import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:milkton_executive/app/milkton_app.dart';

class MainApp extends StatelessWidget {
  const MainApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Scaffold(
              body: Center(
                child: Text(
                    'Unable to connect, please check your network connection'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MilktonApp();
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
