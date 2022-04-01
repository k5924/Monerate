import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/utilities/export.dart';

/// This class allows us to interact with cloud firestore
class DatabaseProvider {
  /// This variable will store an instance of cloud firestore
  final FirebaseFirestore db;

  /// This variable will store an instance of the exception factory
  late ExceptionsFactory exceptionsFactory;

  /// This variable will store an instance of user model
  late UserModel userModel;

  /// This variable will store an instance of balance model
  late BalanceModel balanceModel;

  /// This constructor requires us to inject an instance of cloud firestore before using this class
  DatabaseProvider({required this.db});

  /// This variable stores a reference to the users collection in cloud firestore
  late CollectionReference usersCollection = db.collection('users');

  /// This variable stores a reference to the balances collection in cloud firestore
  late CollectionReference balanceCollection = db.collection('balances');

  /// This variable stores a reference to the chats collection in cloud firestore
  late CollectionReference chatCollection = db.collection('chats');

  /// This method creates a new user instance in the users collection from a users UID
  Future<void> createNewUser({required String uid}) async {
    userModel = UserModel();
    await usersCollection.doc(uid).set(
          userModel.toMap(),
        );
  }

  /// This method retrieves a users profile from the users collection as a usermodel from their User ID
  Future<UserModel> getProfile({required String uid}) async {
    await usersCollection.doc(uid).get().then((value) {
      // ignore: cast_nullable_to_non_nullable
      userModel = UserModel.fromMap(value.data() as Map<String, dynamic>);
    });
    return userModel;
  }

  /// This method updates a user profile in the users collection using the users uid and user model data
  Future<void> updateProfile({
    required UserModel profileData,
    required String uid,
  }) async {
    userModel = profileData;
    await usersCollection.doc(uid).update(userModel.toMap());
  }

  /// This method adds a balance for a user to the balances collection based on its name, symbol, type, amount, price and the users uid
  Future<void> addBalance({
    required String name,
    required String symbol,
    required String type,
    required String amount,
    required String price,
    required String uid,
  }) async {
    balanceModel = BalanceModel(
      amount: amount,
      name: name,
      price: price,
      symbol: symbol,
      type: type,
      userID: uid,
    );
    await balanceCollection.add(balanceModel.toMap());
  }

  /// This method retrieves a users balance id from the balances collection based on a balance model instance
  Future<String> getBalanceID({
    required BalanceModel balanceModel,
  }) async {
    final QuerySnapshot query = await balanceCollection
        .where('userID', isEqualTo: balanceModel.userID)
        .where('type', isEqualTo: balanceModel.type)
        .where('symbol', isEqualTo: balanceModel.symbol)
        .where('price', isEqualTo: balanceModel.price)
        .where('name', isEqualTo: balanceModel.name)
        .where('amount', isEqualTo: balanceModel.amount)
        .get();
    final QueryDocumentSnapshot documentSnapshot = query.docs[0];
    final DocumentReference documentReference = documentSnapshot.reference;
    return documentReference.id;
  }

  /// This method retrieves multiple balance ids from the balances collection based on a balance model instance
  Future<List<String>> getMultipleBalanceIDs({
    required BalanceModel balanceModel,
  }) async {
    final QuerySnapshot query = await balanceCollection
        .where('userID', isEqualTo: balanceModel.userID)
        .where('type', isEqualTo: balanceModel.type)
        .where('symbol', isEqualTo: balanceModel.symbol)
        .get();
    final documentSnapshots = query.docs;
    final List<String> documentIDs = [];
    for (final QueryDocumentSnapshot document in documentSnapshots) {
      documentIDs.add(document.reference.id);
    }
    return documentIDs;
  }

  /// This method updates a balance in the balances collection based on its document reference ID, old balance model data, new new amount and new price
  Future<void> updateBalance({
    required String documentID,
    required BalanceModel oldBalance,
    required String amount,
    required String price,
  }) async {
    balanceModel = BalanceModel(
      amount: amount,
      name: oldBalance.name,
      price: price,
      symbol: oldBalance.symbol,
      type: oldBalance.type,
      userID: oldBalance.userID,
    );
    await balanceCollection.doc(documentID).update(balanceModel.toMap());
  }

  /// This method removes a users balance from the balances collection based on a document reference id
  Future<void> removeBalance({
    required String documentID,
  }) async {
    await balanceCollection.doc(documentID).delete();
  }

  /// This method gets multiple balance ids from the balances collection based on a users uid
  Future<List<String>> getBalanceIDsForOneUser({
    required String userID,
  }) async {
    final QuerySnapshot querySnapshot =
        await balanceCollection.where('userID', isEqualTo: userID).get();
    final documentSnapshots = querySnapshot.docs;
    final List<String> documentIDs = [];
    for (final QueryDocumentSnapshot document in documentSnapshots) {
      documentIDs.add(document.reference.id);
    }
    return documentIDs;
  }

  /// This method deletes a user from the users collection based on their uid
  Future<void> deleteUser({
    required String userID,
  }) async {
    await usersCollection.doc(userID).delete();
  }

  /// This method makes a new chat instance in the chats collection based on a chat model
  Future<String> makeNewChat({
    required ChatModel chatModel,
  }) async {
    final DocumentReference documentReference =
        await chatCollection.add(chatModel.toMap());
    return documentReference.id;
  }

  /// This method creates a new message instance in a chat based the chats document reference id and a message model instance
  Future<void> sendMessage({
    required String documentReferenceID,
    required MessageModel messageModel,
  }) async {
    await chatCollection
        .doc(documentReferenceID)
        .collection('messages')
        .add(messageModel.toMap());
    await chatCollection.doc(documentReferenceID).update(
      {
        'latestMessage': messageModel.createdAt,
      },
    );
  }

  /// This message retrieves an individual chat id based on a chat model instance
  Future<String> getChat({
    required ChatModel chatModel,
  }) async {
    final QuerySnapshot querySnapshot = await chatCollection
        .where('userID', isEqualTo: chatModel.userID)
        .where('chatType', isEqualTo: chatModel.chatType)
        .where('latestMessage', isEqualTo: chatModel.latestMessage)
        .where('firstName', isEqualTo: chatModel.firstName)
        .where('lastName', isEqualTo: chatModel.lastName)
        .get();
    final QueryDocumentSnapshot documentSnapshot = querySnapshot.docs[0];
    final DocumentReference documentReference = documentSnapshot.reference;
    return documentReference.id;
  }

  /// This method returns a stream of messages based on a chat document reference id
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({
    required String documentReferenceID,
  }) {
    return chatCollection
        .doc(documentReferenceID)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// This method returns a stream of balances based on a users uid
  Stream<QuerySnapshot<Object?>> getBalances({
    required String userID,
  }) {
    return balanceCollection.where('userID', isEqualTo: userID).snapshots();
  }

  /// This method returns a stream of chats based on a particular chat type
  Stream<QuerySnapshot<Object?>> getChatsByType({
    required String chatType,
  }) {
    return chatCollection
        .where('chatType', isEqualTo: chatType)
        .orderBy('latestMessage', descending: true)
        .snapshots();
  }

  /// This method retrieves a stream of previous chats based on a chat type and a users uid
  Stream<QuerySnapshot<Object?>> getPreviousChats({
    required String chatType,
    required String userID,
  }) {
    return chatCollection
        .where('chatType', isEqualTo: chatType)
        .where('userID', isEqualTo: userID)
        .orderBy('latestMessage', descending: true)
        .snapshots();
  }
}
