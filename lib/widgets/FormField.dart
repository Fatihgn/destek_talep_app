import 'package:destek_talep_app/helpers/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyFormField extends StatelessWidget {
  MyFormField({super.key, required this.controller, required this.height});
  TextEditingController controller;
  int height;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (tfgirdisi) {
        if (tfgirdisi!.isEmpty) {
          return 'Burası Boş Bırakılamaz';
        }
        return null;
      },
      style: const TextStyle(fontSize: 21, color: Colors.white),
      cursorColor: AppColors().green,
      maxLines: height,
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 15,
        ),
        contentPadding: const EdgeInsets.all(16),
        fillColor: const Color.fromARGB(250, 13, 100, 127),
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors().green,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
