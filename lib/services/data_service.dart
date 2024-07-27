import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:destek_talep_app/services/models/post_model.dart';
import 'package:destek_talep_app/services/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataService {
  final userCol = FirebaseFirestore.instance.collection('users');
  final storage = FirebaseStorage.instance;

  Future<Posts> getUserPosts(String userId) async {
    final userDoc = await userCol.doc(userId).get().then(
          (value) => value.data(),
        );
    final postModel = Posts.fromJson(userDoc!);
    return postModel;
  }

  Future<Map<String, dynamic>> getUser(String userId) async {
    final userDoc = await userCol.doc(userId).get().then(
          (value) => value.data(),
        );

    return userDoc!;
  }

  Stream<Posts> getUserPostsAsStream(String userId) {
    final userSnapshot = userCol
        .doc(userId)
        .snapshots()
        .map((event) => Posts.fromJson(event.data()!));

    return userSnapshot;
  }

  Future<void> insertPost(String id, String title, String description,
      Uint8List? file, String category, String adress) async {
    DateTime now = DateTime.now();
    String date = "${now.day}.${now.month}.${now.year} ";
    String imageUrl = "";
    if (file != null) {
      imageUrl = await uploadImageStorage("postImage-$title", file);
    } else {
      imageUrl =
          "https://demokrathaberorg.teimg.com/crop/1280x720/demokrathaber-org/images/haberler/2015/09/nereden_cikti_bu_noktalama_isaretleri_h54469_0c376.jpg";
    }

    await userCol.doc(id).update({
      "posts": FieldValue.arrayUnion([
        {
          "title": title,
          "description": description,
          "date": date,
          "id": id,
          "isCheck": false,
          "imageUrl": imageUrl,
          "category": category,
          "adress": adress
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
          "isCheck": false,
          "imageUrl": imageUrl,
          "category": category,
          "adress": adress
        }
      ])
    });
  }

  Future<void> updatePost(
      String userID,
      String title,
      String description,
      Map<String, dynamic> post,
      Uint8List? file,
      String category,
      String adress) async {
    DateTime now = DateTime.now();
    String datenow = "${now.day}.${now.month}.${now.year} ";

    String imageUrl = "";
    if (file != null) {
      imageUrl = await uploadImageStorage("postImage-$title", file);
    } else {
      imageUrl =
          "https://demokrathaberorg.teimg.com/crop/1280x720/demokrathaber-org/images/haberler/2015/09/nereden_cikti_bu_noktalama_isaretleri_h54469_0c376.jpg";
    }

    await removePost(userID, post);

    await userCol.doc(userID).update({
      "posts": FieldValue.arrayUnion([
        {
          "title": title,
          "description": description,
          "id": post["id"],
          "date": datenow,
          "isCheck": post["isCheck"],
          "imageUrl": imageUrl,
          "category": category,
          "adress": adress
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
          "isCheck": trueFalse,
          "imageUrl": post["imageUrl"],
          "category": post["category"],
          "adress": post["adress"]
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
          "isCheck": trueFalse,
          "imageUrl": post["imageUrl"],
          "category": post["category"],
          "adress": post["adress"]
        }
      ])
    });
  }

  Future<void> removePost(String userId, Map post) async {
    await userCol.doc(userId).update({
      "posts": FieldValue.arrayRemove([post])
    });
  }

  Future<String> uploadImageStorage(String childName, Uint8List file) async {
    Reference ref = storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
