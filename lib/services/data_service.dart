import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:destek_talep_app/services/models/post_model.dart';
import 'package:destek_talep_app/services/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataService {
  final userCol = FirebaseFirestore.instance.collection('users');
  final adminCol = FirebaseFirestore.instance.collection('admins');
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

  Stream<Posts> getUserPostsAsStreamAdmin(String userId) {
    final userSnapshot = adminCol
        .doc(userId)
        .snapshots()
        .map((event) => Posts.fromJson(event.data()!));

    return userSnapshot;
  }

  Future<void> insertPost(User currentUser, String title, String description,
      Uint8List? file, String category, String adress) async {
    final userInfos = await userCol.doc(currentUser.uid).get();
    print(userInfos.data());
    final vergiNo = userInfos.data()!["vergiNo"];
    print(vergiNo);

    final adminInfos =
        await adminCol.where("vergiNo", isEqualTo: vergiNo).get();
    print(adminInfos.docs[0].id);

    DateTime now = DateTime.now();
    String date = "${now.day}.${now.month}.${now.year} ";
    String imageUrl = "";
    if (file != null) {
      imageUrl = await uploadImageStorage("postImage-$title", file);
    } else {
      imageUrl =
          "https://demokrathaberorg.teimg.com/crop/1280x720/demokrathaber-org/images/haberler/2015/09/nereden_cikti_bu_noktalama_isaretleri_h54469_0c376.jpg";
    }

    await userCol.doc(currentUser.uid).update({
      "posts": FieldValue.arrayUnion([
        {
          "title": title,
          "description": description,
          "date": date,
          "id": currentUser.uid,
          "isCheck": false,
          "imageUrl": imageUrl,
          "category": category,
          "adress": adress
        }
      ])
    });
    await adminCol.doc(adminInfos.docs[0].id).update({
      "posts": FieldValue.arrayUnion([
        {
          "title": title,
          "description": description,
          "date": date,
          "id": currentUser.uid,
          "isCheck": false,
          "imageUrl": imageUrl,
          "category": category,
          "adress": adress
        }
      ])
    });
  }

  Future<void> updatePost(
      User currentUser,
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

    final userInfos = await userCol.doc(currentUser.uid).get();
    final vergiNo = userInfos.data()!["vergiNo"];
    final adminInfos =
        await adminCol.where("vergiNo", isEqualTo: vergiNo).get();

    await removePost(currentUser.uid, post);

    await userCol.doc(currentUser.uid).update({
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
    await adminCol.doc(adminInfos.docs[0].id).update({
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
    final id = post["id"];
    final userInfos = await userCol.doc(id).get();
    final vergiNo = userInfos.data()!["vergiNo"];
    final adminInfos =
        await adminCol.where("vergiNo", isEqualTo: vergiNo).get();

    await removePost(post["id"], post);

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
    await adminCol.doc(adminInfos.docs[0].id).update({
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
    final userInfos = await userCol.doc(userId).get();
    final vergiNo = userInfos.data()!["vergiNo"];
    final adminInfos =
        await adminCol.where("vergiNo", isEqualTo: vergiNo).get();

    await userCol.doc(userId).update({
      "posts": FieldValue.arrayRemove([post])
    });
    await adminCol.doc(adminInfos.docs[0].id).update({
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
