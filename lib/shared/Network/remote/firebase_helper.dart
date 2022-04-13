import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseHelper {
  Future<QuerySnapshot<Map<String, dynamic>>> getCollectionData(
      {String? orderdby,
      required String coll,
      String? secCol,
      String? doc}) async {
    return orderdby != null
        ? secCol != null
            ? await FirebaseFirestore.instance
                .collection(coll)
                .doc(doc)
                .collection(secCol)
                .orderBy(orderdby, descending: true)
                .get()
            : await FirebaseFirestore.instance
                .collection(coll)
                .orderBy(orderdby, descending: true)
                .get()
        : secCol != null
            ? await FirebaseFirestore.instance
                .collection(coll)
                .doc(doc)
                .collection(secCol)
                .get()
            : await FirebaseFirestore.instance.collection(coll).get();
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

  Future<void> postData(
      {required String col,
      required String doc,
      required model,
      String? secCol,
      String? secdoc}) async {
    secdoc != null
        ? await FirebaseFirestore.instance
            .collection(col)
            .doc(doc)
            .collection(secCol!)
            .doc(secdoc)
            .set(model.toMap())
        : await FirebaseFirestore.instance
            .collection(col)
            .doc(doc)
            .set(model.toMap());
  }

  Future<void> deletData(
      {required String col,
      required String doc,
      required model,
      String? secCol,
      String? secdoc}) async {
    secdoc != null
        ? await FirebaseFirestore.instance
            .collection(col)
            .doc(doc)
            .collection(secCol!)
            .doc(secdoc)
            .delete()
        : await FirebaseFirestore.instance.collection(col).doc(doc).delete();
  }
}
