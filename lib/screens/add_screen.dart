import 'dart:io';

import 'package:destek_talep_app/helpers/app_colors.dart';
import 'package:destek_talep_app/services/data_service.dart';
import 'package:destek_talep_app/widgets/AppButton.dart';
import 'package:destek_talep_app/widgets/FormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddScreen extends StatefulWidget {
  AddScreen({super.key, required this.guncellemeMi, this.post});
  bool guncellemeMi;
  Map<String, dynamic>? post;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final User currentUser = FirebaseAuth.instance.currentUser!;

  final formKey = GlobalKey<FormState>();
  var tfIsim = TextEditingController();
  var tfAciklama = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.guncellemeMi) {
      tfIsim.text = widget.post!["title"];
      tfAciklama.text = widget.post!["description"];
    }
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors().dark_blue,
      body: SingleChildScrollView(
          child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Başlık",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              MyFormField(controller: tfIsim, height: 1),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Açıklama",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              MyFormField(controller: tfAciklama, height: 5),
              const SizedBox(
                height: 70,
              ),
              InkWell(
                onTap: () {
                  bool kontrolSonucu = formKey.currentState!.validate();
                  if (kontrolSonucu) {
                    if (widget.guncellemeMi) {
                      DataService().updatePost(
                        "gSqn2bstJ3S8iPlDP2iy5ANnDWE3",
                        tfIsim.text,
                        tfAciklama.text,
                        widget.post!,
                      );
                      DataService().updatePost(
                        currentUser.uid,
                        tfIsim.text,
                        tfAciklama.text,
                        widget.post!,
                      );

                      Navigator.of(context).pop();
                    } else {
                      DataService().insertPost(
                          currentUser.uid, tfIsim.text, tfAciklama.text);

                      Navigator.of(context).pop();
                    }
                  }
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors().green,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.guncellemeMi ? "Güncelle" : "Yeni Şikayet Oluştur",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    ));
  }
}
