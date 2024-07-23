import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  AppTextfield(
      {super.key,
      required this.text,
      required this.icon,
      required this.controller,
      required this.keyboardType});
  String text;
  Icon icon;
  TextEditingController controller;
  TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 18,
            ),
            keyboardType: keyboardType,
            obscureText: text == 'Şifre' ? true : false,
            decoration: InputDecoration(
              suffixIcon: icon,
              border: InputBorder.none,
              hintText: text,
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
