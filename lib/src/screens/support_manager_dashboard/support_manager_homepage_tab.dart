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

class SupportManagerHomepageTab extends StatefulWidget {
  const SupportManagerHomepageTab({Key? key}) : super(key: key);

  @override
  State<SupportManagerHomepageTab> createState() =>
      _SupportManagerHomepageTabState();
}

class _SupportManagerHomepageTabState extends State<SupportManagerHomepageTab> {
  final DatabaseProvider databaseProvider =
      DatabaseProvider(db: FirebaseFirestore.instance);
  late String userID;
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);

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

  Future<void> getChat(ChatModel chatModel) async {
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
    return CenteredScrollView(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: databaseProvider.getChatsByType(chatType: 'support'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child:
                      Text('An error was encountered, chats were not fetched'),
                );
              }
            } else {
              final chatsDB = snapshot.data!.docs;
              final List<ChatModel> chats = <ChatModel>[];
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
                        '${chats[index].firstName} ${chats[index].lastName}',
                      ),
                      subtitle: Text(
                        chats[index].latestMessage.toLocal().toString(),
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
    );
  }
}
