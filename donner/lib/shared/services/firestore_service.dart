import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donner/models/announcement_model.dart';
import 'package:donner/models/client_model.dart';

class FirestoreService {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _postCollectionRef =
      FirebaseFirestore.instance.collection('posts');
  final CollectionReference _categoryCollectionRef =
      FirebaseFirestore.instance.collection('categories');

  Future addUser(ClientModel client, String uid) async {
    Map<String, dynamic> data = client.toMap();

    await _userCollectionRef.doc(uid).set(data).catchError((e) => print(e));
  }

  Future<DocumentSnapshot> getDocUser(String uid) async {
    final user = await _userCollectionRef.doc(uid).get();
    if (user.exists) {
      return user;
    }
    return user;
  }

  Future<DocumentSnapshot?> findUser(String uid) async {
    final user = await _userCollectionRef.doc(uid).get();
    return user;
  }

  Future<QuerySnapshot> getCategories() async {
    return _categoryCollectionRef.get();
  }

  Future addAnnouncement(AnnouncementModel announcement) async {
    Map<String, dynamic> data = announcement.toMap();

    await _postCollectionRef
        .doc(announcement.id)
        .set(data)
        .catchError((e) => print(e));
  }

  Future<QuerySnapshot> getAnnouncements(
      {String? category, bool? isDonation, bool? date}) async {
    if (category != null && isDonation != null && date != null) {
      return _postCollectionRef
          .where('categoryId', isEqualTo: category)
          .where('isDonation', isEqualTo: isDonation)
          .orderBy('id', descending: true)
          .get();
    }
    if (category != null && isDonation != null) {
      return _postCollectionRef
          .where('categoryId', isEqualTo: category)
          .where('isDonation', isEqualTo: isDonation)
          .get();
    }
    if (category != null && date != null) {
      return _postCollectionRef
          .where('categoryId', isEqualTo: category)
          .orderBy('id', descending: true)
          .get();
    }
    if (isDonation != null && date != null) {
      return _postCollectionRef
          .where('isDonation', isEqualTo: isDonation)
          .orderBy('id', descending: true)
          .get();
    }
    if (category != null) {
      return _postCollectionRef.where('categoryId', isEqualTo: category).get();
    }
    if (isDonation != null) {
      return _postCollectionRef
          .where('isDonation', isEqualTo: isDonation)
          .get();
    }
    return _postCollectionRef.orderBy('id', descending: true).get();
  }

  Future<List<AnnouncementModel>> getUserAnnouncements(String userId) async {
    QuerySnapshot querySnapshot = await _postCollectionRef
        .where("owner", isEqualTo: userId)
        .get()
        .catchError((e) => print(e));
    List<DocumentSnapshot> docSnaps = querySnapshot.docs;
    return docSnaps.map<AnnouncementModel>((DocumentSnapshot documentSnapshot) {
      return AnnouncementModel.fromMap(
          documentSnapshot.data()! as Map<String, dynamic>);
    }).toList();
  }

  Future<String> getCategoryById(String categoryId) async {
    final doc = await _categoryCollectionRef.doc(categoryId).get();
    String category = doc.get('category');
    return category;
  }

  Future<void> deleteAnnouncement(String announcementId) async {
    _postCollectionRef.doc(announcementId).delete();
  }

  Future updateUser({required ClientModel user}) async {
    Map<String, dynamic> data = user.toMap();
    await _userCollectionRef
        .doc(user.id)
        .update(data)
        .catchError((e) => print(e));
  }

  Future updateAnnouncement({required AnnouncementModel announcement}) async {
    Map<String, dynamic> data = announcement.toMap();
    await _postCollectionRef.doc(announcement.id).update(data);
  }
}
