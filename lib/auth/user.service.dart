import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zora/auth/model/image.model.dart';
import 'package:zora/auth/model/user_obj.model.dart';

class UserService {
  String uid;

  UserService({this.uid});

  //Collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  //get user doc stream
  Stream<UserObject> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future<UserCredential> addUser(UserObject userObject, String uid) async {
    await userCollection.doc(uid).set(userObject.toJson());
    return null;
  }

  UserObject _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserObject(
      userType: snapshot.data()['userType'] ?? '',
      phoneNumber: snapshot.data()['phoneNumber'] ?? '',
      address: snapshot.data()['address'] ?? '',
      country: snapshot.data()['country'] ?? '',
      idNumber: snapshot.data()['idNumber'] ?? '',
      profilePercentage: snapshot.data()['profilePercentage'] ?? '',
      profilePicture: snapshot.data()['profilePicture'] ?? '',
      email: snapshot.data()['email'] ?? '',
      firstName: snapshot.data()['firstName'] ?? '',
      lastName: snapshot.data()['lastName'] ?? '',
      displayName: snapshot.data()['displayName'] ?? '',
      userUid: snapshot.data()['userUid'] ?? '',
      gender: snapshot.data()['gender'] ?? '',
    );
  }

  Future<UserRegisteredService> registerService({
    String uid,
    String serviceType,
    int yearsOfExperience,
    String descriptionAboutSelf,
    String address
  }) async {
    userCollection.doc(uid).update({
        "service_type": serviceType,
        "years_of_experience": yearsOfExperience,
        "profile": descriptionAboutSelf,
        "work_address": address,
    });
    return UserRegisteredService(
      serviceType:serviceType,
      yearsOfExperience: yearsOfExperience,
      aboutProfile: descriptionAboutSelf,
      workAddress: address,
    );
  }

  addPastWorkImages(String userId, List<ImageModel> images) {
    userCollection.doc(userId).update(
      {
        "gallery": images.map((e) => e.toJson()).toList(),
      },
    );
  }
}
