import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  const Options({super.key, required this.option});

  final String option;

  @override
  Widget build(context) {
    return SizedBox(
      height: 30,
      width: 80,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Color.fromARGB(255, 28, 153, 255),
          ),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          backgroundColor: const Color.fromARGB(255, 28, 153, 255),
        ),
        onPressed: () {},
        child: Text(
          option,
          style: const TextStyle(
            fontSize: 12.5,
          ),
        ),
      ),
    );
  }
}
