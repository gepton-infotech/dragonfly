import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
        foregroundColor: MaterialStateColor.resolveWith(
          (states) => Colors.white,
        ),
      ),
      child: Text(title),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.isActive,
    required this.title,
    required this.count,
  });
  final bool isActive;
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: isActive
          ? ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all(Colors.deepPurpleAccent),
              side: MaterialStateProperty.all(
                const BorderSide(color: Colors.deepPurpleAccent),
              ),
            )
          : ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.blueGrey),
              side: MaterialStateProperty.all(
                const BorderSide(color: Colors.blueGrey),
              ),
            ),
      child: Text("$title ($count)"),
    );
  }
}
