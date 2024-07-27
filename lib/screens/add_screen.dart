import 'dart:io';

import 'package:destek_talep_app/helpers/app_colors.dart';
import 'package:destek_talep_app/helpers/utils.dart';
import 'package:destek_talep_app/services/data_service.dart';
import 'package:destek_talep_app/widgets/AppButton.dart';
import 'package:destek_talep_app/widgets/FormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

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
  var tfAdres = TextEditingController();
  var tfAciklama = TextEditingController();
  var tfKategori = TextEditingController();

  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveScreen() async {
    bool kontrolSonucu =
        formKey.currentState!.validate() && tfKategori.text.isNotEmpty;
    if (kontrolSonucu) {
      if (widget.guncellemeMi) {
        DataService().updatePost(
            "gSqn2bstJ3S8iPlDP2iy5ANnDWE3",
            tfIsim.text,
            tfAciklama.text,
            widget.post!,
            _image,
            tfKategori.text,
            tfAdres.text);
        DataService().updatePost(currentUser.uid, tfIsim.text, tfAciklama.text,
            widget.post!, _image, tfKategori.text, tfAdres.text);

        Navigator.of(context).pop();
      } else {
        DataService().insertPost(currentUser.uid, tfIsim.text, tfAciklama.text,
            _image, tfKategori.text, tfAdres.text);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void initState() {
    if (widget.guncellemeMi) {
      tfIsim.text = widget.post!["title"];
      tfAciklama.text = widget.post!["description"];
      tfKategori.text = widget.post!["category"];
      tfAdres.text = widget.post!["adress"];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                height: 30,
              ),
              _image != null
                  ? Center(
                      child: InkWell(
                        onTap: selectImage,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: MemoryImage(_image!),
                        ),
                      ),
                    )
                  : Center(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            color: AppColors().dark_blue,
                            size: 30,
                          ),
                          onPressed: selectImage,
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Kategori Seçiniz",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownMenu(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 21),
                  inputDecorationTheme: InputDecorationTheme(
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 21),
                    labelStyle:
                        const TextStyle(color: Colors.white, fontSize: 21),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors().green,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onSelected: (String? value) {
                    tfKategori.text = value!;
                  },
                  width: MediaQuery.of(context).size.width - 30,
                  controller: tfKategori,
                  dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                    DropdownMenuEntry(
                      value: "Şikayet",
                      label: "Şikayet",
                    ),
                    DropdownMenuEntry(
                      value: "Öneri",
                      label: "Öneri",
                    ),
                    DropdownMenuEntry(
                      value: "Teknik Destek",
                      label: "Teknik Destek",
                    ),
                  ]),
              const SizedBox(
                height: 20,
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
                height: 20,
              ),
              const Text(
                "Adres",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              MyFormField(controller: tfAdres, height: 1),
              const SizedBox(
                height: 20,
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
                onTap: saveScreen,
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
                      widget.guncellemeMi ? "Güncelle" : "Yeni Gönderi Oluştur",
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
