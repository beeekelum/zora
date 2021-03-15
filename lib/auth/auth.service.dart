import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zora/auth/model/user_obj.model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference schoolsCollection =
  FirebaseFirestore.instance.collection('schools');

  //Changes some methods deprecated
  Stream<User> onAuthChanged() {
    return _firebaseAuth.authStateChanges();
  }

  Stream<UserObject> get user {
    _firebaseAuth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  //sign in with email and password
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return credential.user.uid;
  }

  //sign in with google
  Future<String> signInWithGoogle() async {
    await _googleSignIn.signOut();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await _firebaseAuth.signInWithCredential(credential).
        then((value){
      DocumentReference dbRef =
      FirebaseFirestore.instance.collection('users').doc(value.user.uid);
      dbRef.get().then((data) {
       if(data.exists){
         print("user already registered");
       } else {
           userCollection.doc(value.user.uid).set({
             'firstName': '',
             'lastName': '',
             'displayName':'',
             'userUid': value.user.uid,
             'email': value.user.email,
             'idNumber': '',
             'phoneNumber': value.user.phoneNumber,
             'profilePicture': value.user.photoURL,
             'profilePercentage': 50
           });
           return value;
       }
      });
    }).
    catchError((e) {
      print(e.details); // code, message, details
        if(e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          print("email already been registered.");
        }
    });
    User user = await Future.value(_firebaseAuth.currentUser);
    return user.uid;
  }

  //check if user is signed in the app
  Future<bool> isSignedIn() async {
    final currentUser = await Future.value(_firebaseAuth.currentUser);
    return currentUser != null;
  }

  //sign up method with email and password
  Future<String> signUp(
    String email,
    String password,
      String userType,
  ) async {
    UserCredential credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          if(userType == "School"){
            userCollection.doc(value.user.uid).set({
              'name': '',
              'type': '',
              'logo': '',
              'schoolUid': value.user.uid,
              'email': value.user.email,
              'headmaster': '',
              'deputy_headmaster': '',
              'province': '',
              'profile': '',
              'remarks': '',
              'pass_rate': '',
              'co_person': '',
              'co_phone_number': '',
              'co_email': '',
              'profilePercentage': 50,
              'user_type': userType
            });
          } else {
            userCollection.doc(value.user.uid).set({
              'firstName': '',
              'lastName': '',
              'displayName': '',
              'userUid': value.user.uid,
              'email': value.user.email,
              'idNumber': '',
              'phoneNumber': '',
              'profilePicture': '',
              'gender': '',
              'address': '',
              'profilePercentage': 50,
              'user_type': userType
            });
          }
      return value;
    });
    return credential.user.uid;
  }

Future<void> updateUserProfile(
    String uid,
    String fName,
    String lName,
    String pNumber,
    String idPassportNumber,
    String gender,
    String rAddress,
    String profilePicture,
    String country,
    String town,
    String location,
    ) async {
    userCollection.doc(uid).update({
      "firstName": fName,
      "lastName": lName,
      "displayName": fName + ' ' + lName,
      "phoneNumber": pNumber,
      "idNumber": idPassportNumber,
      "gender": gender,
      "address": rAddress,
      "profilePicture": profilePicture,
      "profilePercentage": 100,
      "country": country,
      "town": town,
      "location": location
    });
}

  //get firebase user
  Future<User> getCurrentUser() async {
    User user = await Future.value(_firebaseAuth.currentUser);
    return user;
  }

  Future<String> getCurrentUserUid() async {
    User user = await Future.value(_firebaseAuth.currentUser);
    return user.uid;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<void> sendEmailVerification() async {
    User user = await getCurrentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User user = await getCurrentUser();
    return user.emailVerified;
  }
}
