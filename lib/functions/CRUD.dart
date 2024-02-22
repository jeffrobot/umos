import 'package:cloud_firestore/cloud_firestore.dart';

class CRUD{
  Future<void> addMyStarsToUser(String email, String starname) async {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
    try {
      // Use await to wait for the asynchronous operation to complete
      QuerySnapshot querySnapshot = await usersCollection.where('userEmail', isEqualTo: email).get();

      // Check if a user with the specified email exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the user document
        DocumentReference userDocument = querySnapshot.docs.first.reference;

        // Define the 'my_stars' data to be added
        List<Map<String, String>> myStarsData = [
          {'starname': starname},
          // Add more map entries as needed
        ];

        // Update the document with the new 'my_stars' field
        await userDocument.update({'my_stars': myStarsData});

        print('my_stars field added to the user with email: $email');
      } else {
        print('User with email $email not found.');
      }
    } catch (e) {
      print('Error adding myStars to user: $e');
    }
  }


  //get star name
  Future<String> getStarName(String email) async {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
    try {
      // Use await to wait for the asynchronous operation to complete
      QuerySnapshot querySnapshot = await usersCollection.where('userEmail', isEqualTo: email).get();

      // Check if a user with the specified email exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the user document
        DocumentSnapshot userDocument = querySnapshot.docs.first;

        // Get the 'my_stars' field from the user document
        List<dynamic> myStarsData = userDocument.get('my_stars');

        // Get the starname from the first map entry in the 'my_stars' field
        String starname = myStarsData[0]['starname'];

        return starname;
      } else {
        print('User with email $email not found.');
        return '';
      }
    } catch (e) {
      print('Error getting starname: $e');
      return '';
    }
  }

  //create diary
  Future<void> createDiary(String email, String diary) async {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
    try {
      // Use await to wait for the asynchronous operation to complete
      QuerySnapshot querySnapshot = await usersCollection.where('userEmail', isEqualTo: email).get();

      // Check if a user with the specified email exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the user's document
        DocumentReference userDocRef = querySnapshot.docs.first.reference;

        // Update the 'mydiary' field in the user's document
        await userDocRef.update({
          'mydiary': FieldValue.arrayUnion([diary]) // Add the diary entry to the 'mydiary' array
        });

        print('Diary added to the user with email: $email');
      } else {
        print('User with email $email not found.');
      }
    } catch (e) {
      print('Error adding diary to user: $e');
    }
  }

  //get diaries of a specific useremail
  Future<List<String>> getDiary(String email) async {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
    try {
      // Use await to wait for the asynchronous operation to complete
      QuerySnapshot querySnapshot = await usersCollection.where('userEmail', isEqualTo: email).get();

      // Check if a user with the specified email exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the user's document
        DocumentSnapshot userDoc = querySnapshot.docs.first;

        // Get the 'mydiary' field from the user's document
        List<dynamic> myDiaryData = userDoc.get('mydiary');

        // Convert the 'mydiary' data to a list of strings
        List<String> myDiary = myDiaryData.map((entry) => entry.toString()).toList();

        return myDiary;
      } else {
        print('User with email $email not found.');
        return [];
      }
    } catch (e) {
      print('Error getting diary: $e');
      return [];
    }
  }

  //add or update 'emotion' field of a specific user
  Future<void> addOrUpdateEmotion(String email, String emotion) async {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
    try {
      // Use await to wait for the asynchronous operation to complete
      QuerySnapshot querySnapshot = await usersCollection.where('userEmail', isEqualTo: email).get();

      // Check if a user with the specified email exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the user's document
        DocumentReference userDocRef = querySnapshot.docs.first.reference;

        // Update the 'emotion' field in the user's document
        await userDocRef.update({'emotion': emotion});

        print('Emotion added to the user with email: $email');
      } else {
        print('User with email $email not found.');
      }
    } catch (e) {
      print('Error adding emotion to user: $e');
    }
  }

  //get "emotion" field
  Future<String> getEmotion(String email) async {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
    try {
      // Use await to wait for the asynchronous operation to complete
      QuerySnapshot querySnapshot = await usersCollection.where('userEmail', isEqualTo: email).get();

      // Check if a user with the specified email exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the user's document
        DocumentSnapshot userDoc = querySnapshot.docs.first;

        // Get the 'emotion' field from the user's document
        String emotion = userDoc.get('emotion');

        return emotion;
      } else {
        print('User with email $email not found.');
        return '';
      }
    } catch (e) {
      print('Error getting emotion: $e');
      return '';
    }
  }
}