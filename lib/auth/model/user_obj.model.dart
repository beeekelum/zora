import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zora/auth/model/image.model.dart';

class UserObject {
  String userUid;
  String firstName;
  String lastName;
  String displayName;
  String email;
  String phoneNumber;
  String idNumber;
  String province;
  String address;
  String town;
  String location;
  String country;
  String status;
  String userType;
  String profilePicture;
  int profilePercentage;
  DateTime dateCreated;
  String gender;

  //service
  List<ImageModel> gallery;

  DocumentReference reference;

  UserObject(
      {this.userUid,
      this.firstName,
      this.lastName,
      this.displayName,
      this.email,
      this.phoneNumber,
      this.idNumber,
      this.address,
      this.town,
      this.location,
      this.country,
      this.status,
      this.userType,
      this.profilePicture,
      this.profilePercentage,
      this.dateCreated,
      this.reference,
      //service
        this.gender,
      this.gallery,});

  factory UserObject.fromSnapshot(DocumentSnapshot snapshot) {
    UserObject newUserObj = UserObject.fromJson(snapshot.data());
    newUserObj.reference = snapshot.reference;
    return newUserObj;
  }

  factory UserObject.fromJson(Map<dynamic, dynamic> json) =>
      userObjFromJson(json);

  Map<String, dynamic> toJson() => userObjToJson(this);

  UserObject.fromQueryDocumentSnapshot(
      {QueryDocumentSnapshot queryDocSnapshot}) {
    var data = queryDocSnapshot.data();
    userUid = data['userUid'] ?? '';
    firstName = data["firstName"] ?? '';
    lastName = data["lastName"] ?? '';
    displayName = data["displayName"] ?? '';
    email = data["email"] ?? '';
    email = data["email"] ?? '';
    phoneNumber = data["phoneNumber"] ?? '';
    idNumber = data["idNumber"] ?? '';
    address = data["address"] ?? '';
    status = data["status"] ?? '';
    profilePicture = data["profilePicture"] ?? '';
    gender = data["gender"] ?? '';
    gallery:
    List<ImageModel>.from(data['gallery'].map((e) => ImageModel.fromJson(e)));
  }
}

UserObject userObjFromJson(Map<dynamic, dynamic> json) {
  return UserObject(
    userUid: json['userUid'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    displayName: json['displayName'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
    idNumber: json['idNumber'] as String,
    address: json['address'] as String,
    town: json['town'] as String,
    location: json['location'] as String,
    country: json['country'] as String,
    status: json['status'] as String,
    userType: json['userType'] as String,
    gender: json['gender'] as String,
    profilePicture: json['profilePicture'] as String,
    profilePercentage: json['profilePercentage'] as int,
    gallery: List<ImageModel>.from(
        json['gallery'].map((e) => ImageModel.fromJson(e))),
    dateCreated: json['dateCreated'] == null
        ? null
        : (json['dateCreated'] as Timestamp).toDate(),
  );
}

Map<String, dynamic> userObjToJson(UserObject instance) => <String, dynamic>{
      'userUid': instance.userUid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'displayName': instance.displayName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'idNumber': instance.idNumber,
      'address': instance.address,
      'town': instance.town,
      'location': instance.location,
      'country': instance.country,
      'status': instance.status,
      'userType': instance.userType,
      'gender': instance.gender,
      'profilePicture': instance.profilePicture,
      'profilePercentage': instance.profilePercentage,
      'dateCreated': instance.dateCreated,
      'gallery': instance.gallery
    };

class UserRegisteredService {
  String serviceType;
  int yearsOfExperience;
  String aboutProfile;
  List<ImageModel> gallery;
  String status;
  String workAddress;
  int likes;

  UserRegisteredService(
      {this.serviceType,
      this.yearsOfExperience,
      this.aboutProfile,
      this.gallery,
      this.status,
      this.workAddress,
      this.likes});

  factory UserRegisteredService.fromSnapshot(DocumentSnapshot snapshot) {
    return UserRegisteredService(
      serviceType: snapshot.data()['service_type'],
      yearsOfExperience: snapshot.data()['years_of_experience'],
      aboutProfile: snapshot.data()['profile'],
      gallery: List<ImageModel>.from(
          snapshot.data()['gallery'].map((e) => ImageModel.fromJson(e))),
      status: snapshot.data()['service_status'],
      workAddress: snapshot.data()['work_address'],
    );
  }

  toJson() {
    return {
      "service_type": serviceType,
      "profile": aboutProfile,
      "work_address": workAddress
    };
  }
}
