import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthManage{
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? thisuser;

  Future signUp(String email, String pw) async {
    try{
      UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: pw);
      User? user = result.user;
      thisuser = user;
      return user;
    } on FirebaseAuthException catch (e){
      print('ERROR!!');
      print(FirebaseAuthException);
      print(e.code);
      return null;
    }
  }

  Future<void> uploadUserInfo(String username, String userEmail, String birthyear, String gender) async {
  try {
    // Get a reference to the "Users" collection
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
    
    // Create a new document with an auto-generated ID
    DocumentReference newUserRef = usersCollection.doc();
    
    Map<String, dynamic> data = {
      'username': username,
      'userEmail': userEmail,
      'birthYear': birthyear,
      'gender': gender
    };
    // Set the data for the new user document
    await newUserRef.set(data);
    
    print('User added to Firestore successfully!');
  } catch (e) {
    print('Error adding user to Firestore: $e');
  }
}

  Future signIn(String email, String pw) async {
    try{
      UserCredential? result = await auth.signInWithEmailAndPassword(email: email, password: pw);
      //User? user = result.user;
      //thisuser = user;
      return result.user;
    } on FirebaseAuthException catch (e) {
      print('ERROR!!!!@');
      return null;
    }
  }
  Future<QuerySnapshot> getUserByEmail(String email) async {
    return await FirebaseFirestore.instance.collection("Users")
    .where("userEmail", isEqualTo: email)
    .get().catchError((e){print(e);});
  }

  Future signOut() async {
    try{
      return auth.signOut();
    } catch (e){
      print('ERROR!!');
      return null;
    }
  }
}