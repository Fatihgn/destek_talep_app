import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:destek_talep_app/services/models/post_model.dart';

class DataService {
  final userCol = FirebaseFirestore.instance.collection('users');

  Future<Posts> getUserPosts(String userId) async {
    final userDoc = await userCol.doc(userId).get().then(
          (value) => value.data(),
        );
    final postModel = Posts.fromJson(userDoc!);
    return postModel;
  }

  Stream<Posts> getUserPostsAsStream(String userId) {
    final userSnapshot = userCol
        .doc(userId)
        .snapshots()
        .map((event) => Posts.fromJson(event.data()!));

    return userSnapshot;
  }

  Future<void> insertPost(String id, String title, String description) async {
    DateTime now = DateTime.now();
    String idd = Random().nextInt(100000).toString();

    String date = "${now.day}.${now.month}.${now.year} ";
    await userCol.doc(id).update({
      "posts": FieldValue.arrayUnion([
        {
          "title": title,
          "description": description,
          "date": date,
          "id": id,
          "isCheck": false
        }
      ])
    });
    await userCol.doc("gSqn2bstJ3S8iPlDP2iy5ANnDWE3").update({
      "posts": FieldValue.arrayUnion([
        {
          "title": title,
          "description": description,
          "date": date,
          "id": id,
          "isCheck": false
        }
      ])
    });
  }

  Future<void> updatePost(String userID, String title, String description,
      Map<String, dynamic> post) async {
    DateTime now = DateTime.now();

    String datenow = "${now.day}.${now.month}.${now.year} ";

    await removePost(userID, post);

    await userCol.doc(userID).update({
      "posts": FieldValue.arrayUnion([
        {
          "title": title,
          "description": description,
          "id": post["id"],
          "date": datenow,
          "isCheck": post["isCheck"]
        }
      ])
    });
  }

  Future<void> updateCheck(Map<String, dynamic> post, bool trueFalse) async {
    print(post);
    print(post["isCheck"]);
    final id = post["id"];
    await removePost(post["id"], post);
    await removePost("gSqn2bstJ3S8iPlDP2iy5ANnDWE3", post);

    await userCol.doc(id).update({
      "posts": FieldValue.arrayUnion([
        {
          "title": post["title"],
          "description": post["description"],
          "id": post["id"],
          "date": post["date"],
          "isCheck": trueFalse
        }
      ])
    });
    await userCol.doc("gSqn2bstJ3S8iPlDP2iy5ANnDWE3").update({
      "posts": FieldValue.arrayUnion([
        {
          "title": post["title"],
          "description": post["description"],
          "id": post["id"],
          "date": post["date"],
          "isCheck": trueFalse
        }
      ])
    });
  }

  Future<void> removePost(String userId, Map post) async {
    await userCol.doc(userId).update({
      "posts": FieldValue.arrayRemove([post])
    });
  }
}
