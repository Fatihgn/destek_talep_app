import 'package:destek_talep_app/helpers/app_colors.dart';
import 'package:destek_talep_app/providers/filter_provider.dart';
import 'package:destek_talep_app/screens/add_screen.dart';
import 'package:destek_talep_app/screens/main_drawer.dart';
import 'package:destek_talep_app/screens/user_info.dart';
import 'package:destek_talep_app/services/auth_service.dart';
import 'package:destek_talep_app/services/data_service.dart';
import 'package:destek_talep_app/services/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminScreen extends ConsumerStatefulWidget {
  const AdminScreen({super.key});

  @override
  ConsumerState<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends ConsumerState<AdminScreen> {
  final User currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final activeFilters = ref.watch(filterProvider);
    bool oneriMi = activeFilters[Filter.oneri]!;
    bool sikayetMi = activeFilters[Filter.sikayet]!;
    bool teknikDestekMi = activeFilters[Filter.teknikDestek]!;
    bool tumGonderilerMi = activeFilters[Filter.tumGonderiler]!;

    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors().dark_blue,
          appBar: AppBar(
            centerTitle: true,
            foregroundColor: Colors.white,
            title: const Text(
              'Tüm Gönderiler',
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
          drawer: const MainDrawer(),
          body: SingleChildScrollView(
            child: StreamBuilder<Posts>(
                stream:
                    DataService().getUserPostsAsStreamAdmin(currentUser.uid),
                builder: (context, snapshot) {
                  final Posts? posts = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (posts!.posts.isEmpty) {
                    return const Center(
                      child: Text(
                        'Hiç gönderi yok',
                      ),
                    );
                  }
                  return Column(
                      children: List.generate(posts.posts.length, (index) {
                    final PostModel post = posts.posts[index];
                    if (post.category == "Şikayet" && !sikayetMi) {
                      return Container();
                    }
                    if (post.category == "Öneri" && !oneriMi) {
                      return Container();
                    }
                    if (post.category == "Teknik Destek" && !teknikDestekMi) {
                      return Container();
                    }
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
                              gradient: LinearGradient(
                                  colors: post.isCheck
                                      ? [
                                          Colors.green.shade400,
                                          Colors.green.shade100
                                        ]
                                      : [
                                          Colors.red.shade400,
                                          Colors.red.shade100
                                        ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
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
                                            color: Colors.black,
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
                                        style: const TextStyle(
                                          color: Colors.white,
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
                                    DataService().updateCheck({
                                      "title": post.title,
                                      "description": post.description,
                                      "id": post.id,
                                      "date": post.date,
                                      "isCheck": post.isCheck,
                                      "imageUrl": post.imageUrl,
                                      "category": post.category,
                                      "adress": post.adress,
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
                                      "imageUrl": post.imageUrl,
                                      "category": post.category,
                                      "adress": post.adress,
                                    }, true);
                                  },
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.person),
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: AppColors().dark_blue),
                                  label: const Text('Kullanıcı Bilgileri'),
                                  onPressed: () async {
                                    final a =
                                        await DataService().getUser(post.id);
                                    print(await DataService().getUser(post.id));
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => UserInfoScreen(
                                          name: a["name"],
                                          email: a["email"],
                                          phone: a["phone"],
                                          tcNo: a["tcNo"],
                                        ),
                                      ),
                                    );
                                  },
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
