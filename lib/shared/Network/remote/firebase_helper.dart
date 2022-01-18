import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseHelper {
  Future<QuerySnapshot<Map<String, dynamic>>> getCollectionData(
      String coll) async {
    return await FirebaseFirestore.instance.collection(coll).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocData(
      String coll, String doc) async {
    return await FirebaseFirestore.instance.collection(coll).doc(doc).get();
  }

  Future<void> updateDocData(String col, String doc, model) async {
    await FirebaseFirestore.instance
        .collection(col)
        .doc(doc)
        .update(model.toMap());
  }

  Future<String> uploadFile(String folderPath, String filePath, file) async {
    String path;
    var value = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('$folderPath/$filePath')
        .putFile(file!);
    path = await value.ref.getDownloadURL();

    return path;
  }

  Future<void> postData(String col, String doc, model) async {
    await FirebaseFirestore.instance
        .collection(col)
        .doc(doc)
        .set(model.toMap());
  }
}
