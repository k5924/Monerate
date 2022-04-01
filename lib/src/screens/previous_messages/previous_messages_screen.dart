// ignore_for_file: use_build_context_synchronously, avoid_void_async

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';
import 'package:monerate/src/widgets/export.dart';

/// This is the screen which would be displayed when an end-user or financial advisor chooses to view their old support messages
class PreviousMessagesScreen extends StatefulWidget {
  /// This variable stores the type of chat to retrieve from Firebase
  final String chatType;

  /// This is the constructor for this screen which assigns the chat type to the ChatType variable
  const PreviousMessagesScreen({Key? key, required this.chatType})
      : super(key: key);

  @override
  State<PreviousMessagesScreen> createState() => _PreviousMessagesScreenState();
}

class _PreviousMessagesScreenState extends State<PreviousMessagesScreen> {
  final DatabaseProvider databaseProvider =
      DatabaseProvider(db: FirebaseFirestore.instance);
  late String userID = '';
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);
  late List<ChatModel> chats;

  @override
  void initState() {
    super.initState();
    _getUserID().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> _getUserID() async {
    try {
      userID = await authProvider.getUID();
    } on FirebaseAuthException catch (e) {
      final exceptionsFactory = ExceptionsFactory(e.code);
      EasyLoading.showError(exceptionsFactory.exceptionCaught()!);
    }
  }

  Future<void> _makeNewChat() async {
    try {
      EasyLoading.show(status: 'loading...');
      final String result = await authProvider.makeNewChat(
        chatType: widget.chatType,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ChatScreen(documentReferenceID: result, userID: userID),
        ),
      );
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      final exceptionsFactory = ExceptionsFactory(e.code);
      EasyLoading.showError(exceptionsFactory.exceptionCaught()!);
    }
  }

  Future<void> _getChat(ChatModel chatModel) async {
    try {
      EasyLoading.show(status: 'loading...');
      final result = await authProvider.getChat(chatModel: chatModel);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ChatScreen(documentReferenceID: result, userID: userID),
        ),
      );
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      final exceptionsFactory = ExceptionsFactory(e.code);
      EasyLoading.showError(exceptionsFactory.exceptionCaught()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CenteredScrollViewWithAppBar(
      appBarTitle: "Previous Messages",
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _makeNewChat();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: databaseProvider.getPreviousChats(
            chatType: widget.chatType,
            userID: userID,
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: Text(
                    'An error was encountered, chats were not fetched',
                  ),
                );
              }
            } else {
              final chatsDB = snapshot.data!.docs;
              chats = <ChatModel>[];
              for (final item in chatsDB) {
                final chat = ChatModel(
                  userID: item['userID'].toString(),
                  chatType: item['chatType'].toString(),
                  latestMessage: (item['latestMessage'] as Timestamp).toDate(),
                  firstName: item['firstName'] as String,
                  lastName: item['lastName'] as String,
                );
                chats.add(chat);
              }
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        'Last Message: ${chats[index].latestMessage.toLocal().toString()}',
                      ),
                      onTap: () async {
                        await _getChat(chats[index]);
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
