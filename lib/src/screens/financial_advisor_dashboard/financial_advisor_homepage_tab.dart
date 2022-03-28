// ignore_for_file: use_build_context_synchronously, avoid_void_async

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';

class FinancialAdvisorHomepageTab extends StatefulWidget {
  const FinancialAdvisorHomepageTab({Key? key}) : super(key: key);

  @override
  State<FinancialAdvisorHomepageTab> createState() =>
      _FinancialAdvisorHomepageTabState();
}

class _FinancialAdvisorHomepageTabState
    extends State<FinancialAdvisorHomepageTab> {
  final DatabaseProvider databaseProvider =
      DatabaseProvider(db: FirebaseFirestore.instance);
  late String userID;
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);
  late Stream<QuerySnapshot<Object?>> chatStream = databaseProvider
      .chatCollection
      .where('chatType', isEqualTo: 'finance')
      .orderBy('latestMessage', descending: true)
      .snapshots();

  @override
  void initState() async {
    super.initState();
    await getUserID();
  }

  Future<void> getUserID() async {
    userID = await authProvider.getUID();
  }

  Future<void> getChat(ChatModel chatModel) async {
    try {
      final result = await authProvider.getChat(chatModel);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ChatScreen(documentReferenceID: result, userID: userID),
        ),
      );
    } on FirebaseAuthException catch (e) {
      final exceptionsFactory = ExceptionsFactory(e.code);
      EasyLoading.showError(exceptionsFactory.exceptionCaught()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: chatStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final chatsDB = snapshot.data!.docs;
                    final List<ChatModel> chats = <ChatModel>[];
                    for (final item in chatsDB) {
                      final chat = ChatModel(
                        userID: item['userID'].toString(),
                        chatType: item['chatType'].toString(),
                        latestMessage: item['latestMessage'] as DateTime,
                        messages: item['messages'] as List<MessageModel>,
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
                              chats[index].latestMessage.toUtc().toString(),
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
    );
  }
}
