import 'package:destek_talep_app/helpers/app_colors.dart';
import 'package:destek_talep_app/helpers/sizes.dart';

import 'package:destek_talep_app/screens/login_screen.dart';
import 'package:destek_talep_app/services/auth_service.dart';
import 'package:destek_talep_app/widgets/AppButton.dart';
import 'package:destek_talep_app/widgets/TextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AppColors appColors = AppColors();
  Sizes sizes = Sizes();
  final _tName = TextEditingController();
  final _tPassword = TextEditingController();
  final _tEmail = TextEditingController();
  final _tTelephone = TextEditingController();
  final _tTcNo = TextEditingController();
  final _tVergiNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: appColors.green,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: appColors.dark_blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Hadi Başlayalım',
              style: TextStyle(
                fontSize: 32,
                color: appColors.dark_blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Yeni bir hesap oluşturun',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 75,
            ),
            Container(
              width: sizes.deviceWidth(context),
              height: 600,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Kaydol',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: appColors.dark_blue,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      AppTextfield(
                          text: "İsim",
                          icon: const Icon(Icons.person),
                          controller: _tName,
                          keyboardType: TextInputType.text),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextfield(
                          text: "Vergi No",
                          icon: const Icon(Icons.numbers),
                          controller: _tVergiNo,
                          keyboardType: TextInputType.number),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextfield(
                          text: "Tel No",
                          icon: const Icon(Icons.phone),
                          controller: _tTelephone,
                          keyboardType: TextInputType.phone),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextfield(
                          text: "Tc No",
                          icon: const Icon(Icons.edit_note_outlined),
                          controller: _tTcNo,
                          keyboardType: TextInputType.number),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextfield(
                          text: "Email",
                          icon: const Icon(Icons.email),
                          controller: _tEmail,
                          keyboardType: TextInputType.emailAddress),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextfield(
                          text: "Şifre",
                          icon: const Icon(Icons.lock),
                          controller: _tPassword,
                          keyboardType: TextInputType.text),
                      const SizedBox(
                        height: 40,
                      ),
                      AppButton(
                          color: appColors.green,
                          text: "Kaydol",
                          textColor: Colors.white,
                          onPressed: () => AuthService().signUp(
                              _tName.text,
                              _tEmail.text,
                              _tPassword.text,
                              context,
                              _tTelephone.text,
                              _tTcNo.text,
                              _tVergiNo.text)),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          const Text(
                            "Zaten bir hesabın var mı?   ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: Text(
                              "Giriş Yap",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17, color: appColors.green),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
