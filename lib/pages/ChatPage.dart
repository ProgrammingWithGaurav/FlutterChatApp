import 'package:chat_app/components/chatBubble.dart';
import 'package:chat_app/components/textfield.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receieverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receieverEmail, required this.receiverID});

  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // send message
  void _sendMessage() async {
    // get message
    String message = _messageController.text;
    // send message
    await _chatService.sendMessage(receiverID, message);
    // clear text field
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(receieverEmail),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.grey,
        ),
        body: Column(
          children: [
            // display all messages
            Expanded(
              child: _buildMessageList(),
            ),
            // message input
            _buildMessageInput()
          ],
        ));
  }

  // build message list
  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(senderId, receiverID),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text('Error');
        }
        // loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        // return list view
        return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildMessageItem(doc))
                .toList());
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>; // cast
    // is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    // Align message  to left or right
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child:
            ChatBubble(message: data['message'], isCurrentUser: isCurrentUser));
  }

  // build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(children: [
        // textfield
        Expanded(
          child: MyTextField(
            controller: _messageController,
            hintText: 'Type a message...',
          ),
        ),
        // send button
        Container(
          decoration:
              BoxDecoration(color: Colors.green, shape: BoxShape.circle),
          margin: const EdgeInsets.only(right: 25),
          child: IconButton(
              onPressed: _sendMessage,
              icon: Icon(Icons.arrow_upward, color: Colors.white)),
        )
      ]),
    );
  }
}
