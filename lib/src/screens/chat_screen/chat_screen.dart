import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';

class ChatScreen extends StatefulWidget {
  final String userID;
  final String documentReferenceID;
  const ChatScreen({
    Key? key,
    required this.documentReferenceID,
    required this.userID,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);
  String messageText = '';
  final DatabaseProvider databaseProvider =
      DatabaseProvider(db: FirebaseFirestore.instance);
  late Stream<QuerySnapshot<Object?>> messageStream = databaseProvider
      .chatCollection
      .doc(widget.documentReferenceID)
      .collection('messages')
      .orderBy('createdAt', descending: true)
      .snapshots();

  Future<void> sendMessage() async {
    textController.clear();
    FocusScope.of(context).unfocus();
    final result = await authProvider.sendNewMessage(
      widget.documentReferenceID,
      messageText,
    );

    if (result != null) {
      EasyLoading.showError(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: messageStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Center(
                      child: Text(
                          'An error was encountered, messages were not fetched'),
                    );
                  }
                } else {
                  final messagesDB = snapshot.data!.docs;
                  final List<MessageModel> messages = <MessageModel>[];
                  for (final item in messagesDB) {
                    final individualMessage = MessageModel(
                      senderID: item['senderID'] as String,
                      firstName: item['firstName'] as String,
                      lastName: item['lastName'] as String,
                      message: item['message'] as String,
                      createdAt: (item['createdAt'] as Timestamp).toDate(),
                    );
                    messages.add(individualMessage);
                  }
                  return Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment:
                              messages[index].senderID == widget.userID
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.all(16),
                              constraints: const BoxConstraints(maxWidth: 140),
                              decoration: BoxDecoration(
                                color: messages[index].senderID == widget.userID
                                    ? Colors.grey
                                    : Theme.of(context).colorScheme.secondary,
                                borderRadius:
                                    messages[index].senderID == widget.userID
                                        ? const BorderRadius.all(
                                            Radius.circular(12),
                                          ).subtract(
                                            const BorderRadius.only(
                                              bottomRight: Radius.circular(12),
                                            ),
                                          )
                                        : const BorderRadius.all(
                                            Radius.circular(12),
                                          ).subtract(
                                            const BorderRadius.only(
                                              bottomLeft: Radius.circular(12),
                                            ),
                                          ),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    messages[index].senderID == widget.userID
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${messages[index].message}\n${messages[index].createdAt.toLocal().toString()}',
                                    style: TextStyle(
                                      color: messages[index].senderID ==
                                              widget.userID
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    textAlign: messages[index].senderID ==
                                            widget.userID
                                        ? TextAlign.end
                                        : TextAlign.start,
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey,
                      hintText: 'Type your message here',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        gapPadding: 10,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onChanged: (value) => setState(() {
                      messageText = value;
                    }),
                  ),
                ),
                GestureDetector(
                  onTap: messageText.trim().isEmpty ? null : sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
