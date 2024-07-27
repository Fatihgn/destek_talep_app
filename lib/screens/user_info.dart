import 'package:destek_talep_app/helpers/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserInfoScreen extends StatefulWidget {
  UserInfoScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.phone,
      required this.tcNo});
  String name, email, phone, tcNo;

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors().dark_blue,
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Kullanıcı Bilgileri",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Card(
                        color: AppColors().green,
                        child: ListTile(
                          trailing: Icon(
                            Icons.person,
                            color: AppColors().dark_blue,
                          ),
                          title: Text("İsim Soyisim",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors().dark_blue,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(widget.name,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        color: AppColors().green,
                        child: ListTile(
                          trailing: Icon(
                            Icons.mail,
                            color: AppColors().dark_blue,
                          ),
                          title: Text("E Mail",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors().dark_blue,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(widget.email,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        color: AppColors().green,
                        child: ListTile(
                          trailing: Icon(
                            Icons.phone,
                            color: AppColors().dark_blue,
                          ),
                          title: Text("Telefon",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors().dark_blue,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(widget.phone,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        color: AppColors().green,
                        child: ListTile(
                          trailing: Icon(
                            Icons.wallet,
                            color: AppColors().dark_blue,
                          ),
                          title: Text("TC No",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors().dark_blue,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(widget.tcNo,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
