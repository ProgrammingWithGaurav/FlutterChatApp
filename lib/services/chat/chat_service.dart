import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  // get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // send message
  Future<void> sendMessage(String receiverID, message) async {
    // get current user
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    // create a new message
    Message newMessage = Message(
        senderID: currentUserId,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);
    // construm chat room ID for the two users
    List<String> ids = [currentUserId, receiverID];
    ids.sort(); // sort the list
    String chatRoomID = ids.join('_'); // join the list with underscore
    // send message to firestore
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get message stream
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    // construm chat room ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort(); // sort the list
    String chatRoomID = ids.join('_'); // join the list with underscore
    // get message stream
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
