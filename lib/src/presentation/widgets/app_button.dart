import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;

  const AppButton({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(title));
  }
}
