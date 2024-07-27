import 'package:destek_talep_app/helpers/app_colors.dart';
import 'package:destek_talep_app/main.dart';
import 'package:destek_talep_app/screens/add_screen.dart';
import 'package:destek_talep_app/screens/home_screen.dart';
import 'package:destek_talep_app/services/auth_service.dart';
import 'package:destek_talep_app/services/data_service.dart';
import 'package:destek_talep_app/services/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final User currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors().dark_blue,
          appBar: AppBar(
            centerTitle: true,
            foregroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: const Text(
              'Şikayetlerim',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors().dark_blue,
            actions: [
              IconButton(
                onPressed: () {
                  AuthService().signOut(context);
                },
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors().green,
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddScreen(
                        guncellemeMi: false,
                      )));
            },
            child: const Icon(Icons.add),
          ),
          body: SingleChildScrollView(
            child: StreamBuilder<Posts>(
                stream: DataService().getUserPostsAsStream(currentUser.uid),
                builder: (context, snapshot) {
                  final Posts? posts = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (posts!.posts.isEmpty) {
                    return const Center(
                      child: Text(
                        'Hiç şikayetin yok',
                      ),
                    );
                  }
                  return Column(
                      children: List.generate(posts.posts.length, (index) {
                    final PostModel post = posts.posts[index];
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Container(
                            width: double.infinity,
                            height: 450,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.64,
                                        child: Text(
                                          post.category,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Text(
                                          textAlign: TextAlign.right,
                                          "${post.date}  ${post.adress}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Image.network(
                                    post.imageUrl,
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                      height: 32,
                                      child: Text(
                                        post.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors().green,
                                          fontSize: 25,
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                      height: 110,
                                      child: Text(
                                        post.description,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    DataService().removePost(
                                      currentUser.uid,
                                      {
                                        "title": post.title,
                                        "description": post.description,
                                        "id": post.id,
                                        "date": post.date,
                                        "isCheck": post.isCheck,
                                        "imageUrl": post.imageUrl,
                                        "category": post.category,
                                        "adress": post.adress,
                                      },
                                    );
                                    DataService().removePost(
                                      "gSqn2bstJ3S8iPlDP2iy5ANnDWE3",
                                      {
                                        "title": post.title,
                                        "description": post.description,
                                        "id": post.id,
                                        "date": post.date,
                                        "isCheck": post.isCheck,
                                        "imageUrl": post.imageUrl,
                                        "category": post.category,
                                        "adress": post.adress,
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red[400],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => AddScreen(
                                                  guncellemeMi: true,
                                                  post: {
                                                    "title": post.title,
                                                    "description":
                                                        post.description,
                                                    "id": post.id,
                                                    "date": post.date,
                                                    "isCheck": post.isCheck,
                                                    "imageUrl": post.imageUrl,
                                                    "category": post.category,
                                                    "adress": post.adress,
                                                  },
                                                )));
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                Icon(Icons.auto_awesome_sharp,
                                    color: post.isCheck
                                        ? Colors.green
                                        : Colors.grey[500]),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  post.isCheck
                                      ? "İncelendi"
                                      : "Henüz İncelenmedi",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: post.isCheck
                                          ? Colors.green
                                          : Colors.grey[500]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }));
                }),
          )),
    );
  }
}
