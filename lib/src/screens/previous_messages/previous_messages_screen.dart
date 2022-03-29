// ignore_for_file: use_build_context_synchronously, avoid_void_async

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';

class PreviousMessagesScreen extends StatefulWidget {
  final String chatType;
  const PreviousMessagesScreen({Key? key, required this.chatType})
      : super(key: key);

  @override
  State<PreviousMessagesScreen> createState() => _PreviousMessagesScreenState();
}

class _PreviousMessagesScreenState extends State<PreviousMessagesScreen> {
  final DatabaseProvider databaseProvider =
      DatabaseProvider(db: FirebaseFirestore.instance);
  late String userID;
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);
  late Stream<QuerySnapshot<Object?>> chatStream = databaseProvider
      .chatCollection
      .where('chatType', isEqualTo: widget.chatType)
      .where('userID', isEqualTo: userID)
      .orderBy('latestMessage', descending: true)
      .snapshots();

  @override
  void initState() {
    super.initState();
    getUserID().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> getUserID() async {
    try {
      userID = await authProvider.getUID();
    } on FirebaseAuthException catch (e) {
      final exceptionsFactory = ExceptionsFactory(e.code);
      EasyLoading.showError(exceptionsFactory.exceptionCaught()!);
    }
  }

  Future<void> makeNewChat() async {
    try {
      EasyLoading.show(status: 'loading...');
      final String result = await authProvider.makeNewChat(widget.chatType);
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

  Future<void> getChat(ChatModel chatModel) async {
    try {
      EasyLoading.show(status: 'loading...');
      final result = await authProvider.getChat(chatModel);
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Previous Messages"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: chatStream,
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
                      final List<ChatModel> chats = <ChatModel>[];
                      for (final item in chatsDB) {
                        final chat = ChatModel(
                          userID: item['userID'].toString(),
                          chatType: item['chatType'].toString(),
                          latestMessage:
                              (item['latestMessage'] as Timestamp).toDate(),
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
                                await getChat(chats[index]);
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await makeNewChat();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
