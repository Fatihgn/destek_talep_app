import 'package:destek_talep_app/helpers/app_colors.dart';
import 'package:destek_talep_app/helpers/sizes.dart';
import 'package:destek_talep_app/screens/login_screen.dart';
import 'package:destek_talep_app/screens/register_screen.dart';
import 'package:destek_talep_app/widgets/AppButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppColors appColors = AppColors();
  Sizes sizes = Sizes();
  @override
  Widget build(BuildContext context) {
    final screenheight = sizes.deviceHeight(context) -
        sizes.topPadding(context) -
        sizes.bottomPadding(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: appColors.green,
          body: Column(
            children: <Widget>[
              Container(
                height: screenheight / 2,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Image.asset(
                    'assets/images/logo2.png',
                  ),
                ),
              ),
              Container(
                  height: screenheight / 2,
                  color: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      color: appColors.green,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(90),
                      ),
                    ),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Text(
                                'Şikayet Destek Uygulaması',
                                style: TextStyle(
                                  fontSize: 29,
                                  color: appColors.dark_blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              textAlign: TextAlign.center,
                              'Uygulamamızın daha iyi hizmet verebilmesi için geri dönüşlerinizi bekliyoruz',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            AppButton(
                              color: Colors.white,
                              text: "Giriş Yap",
                              textColor: appColors.dark_blue,
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen())),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AppButton(
                                color: appColors.green,
                                text: "Kaydol",
                                textColor: Colors.white,
                                onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()))),
                            const Expanded(
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          )),
    );
  }
}
