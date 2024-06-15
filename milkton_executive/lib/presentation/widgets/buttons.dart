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
        backgroundColor: WidgetStateProperty.all(Colors.deepPurpleAccent),
        foregroundColor: WidgetStateColor.resolveWith(
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
    this.onPressed,
  });
  final void Function()? onPressed;
  final bool isActive;
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: isActive
          ? ButtonStyle(
              foregroundColor: WidgetStateProperty.all(Colors.deepPurpleAccent),
              side: WidgetStateProperty.all(
                const BorderSide(color: Colors.deepPurpleAccent),
              ),
            )
          : ButtonStyle(
              foregroundColor: WidgetStateProperty.all(Colors.blueGrey),
              side: WidgetStateProperty.all(
                const BorderSide(color: Colors.blueGrey),
              ),
            ),
      child: Text(
          "${title[0].toUpperCase()}${title.substring(1).toLowerCase()} ($count)"),
    );
  }
}
