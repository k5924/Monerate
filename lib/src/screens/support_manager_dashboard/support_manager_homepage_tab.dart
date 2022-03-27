import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/database_provider.dart';

class SupportManagerHomepageTab extends StatefulWidget {
  const SupportManagerHomepageTab({Key? key}) : super(key: key);

  @override
  State<SupportManagerHomepageTab> createState() =>
      _SupportManagerHomepageTabState();
}

class _SupportManagerHomepageTabState extends State<SupportManagerHomepageTab> {
  final DatabaseProvider databaseProvider =
      DatabaseProvider(db: FirebaseFirestore.instance);
  late Stream<QuerySnapshot<Object?>> chatStream = databaseProvider
      .chatCollection
      .where('chatType', isEqualTo: 'support')
      .orderBy('latestMessage', descending: true)
      .snapshots();

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
                            subtitle:
                                Text(chats[index].latestMessage.toString()),
                            onTap: () {},
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
