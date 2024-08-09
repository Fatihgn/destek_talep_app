import 'package:destek_talep_app/helpers/app_colors.dart';
import 'package:destek_talep_app/helpers/sizes.dart';
import 'package:destek_talep_app/screens/register_screen.dart';
import 'package:destek_talep_app/services/auth_service.dart';
import 'package:destek_talep_app/widgets/AppButton.dart';
import 'package:destek_talep_app/widgets/TextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();
  AppColors appColors = AppColors();
  Sizes sizes = Sizes();

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
              'Tekrar Hoşgeldiniz',
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
              'Hesabınıza giriş yapın',
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
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Giriş Yap',
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
                      text: "Giriş Yap",
                      textColor: Colors.white,
                      onPressed: () => AuthService()
                          .signIn(_tEmail.text, _tPassword.text, context),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        const Text(
                          "Ben yeni bir kullanıcıyım.   ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: Text(
                            "Kaydol",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 17, color: appColors.green),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
