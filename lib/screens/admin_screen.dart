import 'package:destek_talep_app/helpers/app_colors.dart';
import 'package:destek_talep_app/screens/add_screen.dart';
import 'package:destek_talep_app/services/auth_service.dart';
import 'package:destek_talep_app/services/data_service.dart';
import 'package:destek_talep_app/services/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
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
              'Tüm Şikayetler',
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
          body: SingleChildScrollView(
            child: StreamBuilder<Posts>(
                stream: DataService()
                    .getUserPostsAsStream("gSqn2bstJ3S8iPlDP2iy5ANnDWE3"),
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
                            height: 270,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: post.isCheck
                                  ? Colors.green[100]
                                  : Colors.red[100],
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
                                          post.title,
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
                                          post.date,
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
                                  SizedBox(
                                      height: 105,
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
                                    DataService().updateCheck({
                                      "title": post.title,
                                      "description": post.description,
                                      "id": post.id,
                                      "date": post.date,
                                      "isCheck": post.isCheck,
                                    }, false);
                                  },
                                  icon: const Icon(
                                    Icons.do_not_disturb_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    DataService().updateCheck({
                                      "title": post.title,
                                      "description": post.description,
                                      "id": post.id,
                                      "date": post.date,
                                      "isCheck": post.isCheck,
                                    }, true);
                                  },
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
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
