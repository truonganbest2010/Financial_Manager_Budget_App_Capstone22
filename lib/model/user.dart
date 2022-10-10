enum DocKeyUserprof { email, debts, uid, number, purchases }

class UserProfile {
  String? uid; //firestore auto generated id
  String? docId;
  late String email;
  late String number;
  late List<dynamic> debts;
  late List<dynamic> purchases;

  UserProfile({
    this.uid,
    this.docId,
    this.email = '',
    List<dynamic>? debts,
    List<dynamic>? purchases,
  }) {
    this.debts = debts == null ? [] : [...debts];
    this.purchases = purchases == null ? [] : [...purchases];
  }

  UserProfile.set(String email, String number) {
    this.email = email;
    this.number = number;
  }

  UserProfile.clone(UserProfile p) {
    uid = p.uid;
    docId = p.docId;
    email = p.email;
    number = p.number;
    debts = [...debts];
    purchases = [...purchases];
  }

  //a.copyFrom(b) ==> a = b
  void copyFrom(UserProfile p) {
    uid = p.uid;
    docId = p.docId;
    email = p.email;
    number = p.number;
    debts.clear();
    debts.addAll(p.debts);
    purchases.addAll(p.purchases);
  }

  //serialization
  Map<String, dynamic> toFirestoreDoc() {
    return {
      DocKeyUserprof.email.name: email,
      DocKeyUserprof.number.name: number,
      DocKeyUserprof.uid.name: uid,
    };
  }

  //deserialization
  static UserProfile? fromFirestoreDoc(
      {required Map<String, dynamic> doc, required String docId}) {
    return UserProfile(
      uid: docId,
      docId: docId,
      email: doc[DocKeyUserprof.email.name] ??= 'N/A',
      debts: doc[DocKeyUserprof.debts.name] ??= [],
      purchases: doc[DocKeyUserprof.purchases.name] ??= [],
    );
  }
}

class UserInfo {
  static const UID = 'uid';
  static const EMAIL = 'email';
  static const NAME = 'name';
  static const BIO = 'bio';

  String? docId; //firestore auto generated id
  late String email;
  late String name;
  late String bio;
  late String uid;

  UserInfo({
    this.docId,
    this.uid = '',
    this.name = '',
    this.bio = '',
    this.email = '',
  });

  static UserInfo? fromFirestoreDoc({
    required Map<String, dynamic> doc,
    required String docId,
  }) {
    for (var key in doc.keys) {
      if (doc[key] == null) return null;
    }
    return UserInfo(
      docId: docId,
      uid: doc[UID],
      name: doc[NAME] ??= 'N/A', // if null give a value as 'N/A'
      bio: doc[BIO] ??= 'N/A',
      email: doc[EMAIL],
    );
  }
}

class UserFriends {
  static const UID_SEND = 'uid_send';
  static const UID_RECEIVE = 'uid_receive';
  static const ACCEPT = 'accept';

  String? docId; //firestore auto generated id
  late String uid_send;
  late String uid_receive;
  late int accept;

  UserFriends({
    this.docId,
    this.uid_send = '',
    this.uid_receive = '',
    this.accept = 0,
  });

  Map<String, dynamic> toFirestoreDoc() {
    return {
      UID_SEND: this.uid_send,
      UID_RECEIVE: this.uid_receive,
      ACCEPT: this.accept,
    };
  }

  static UserFriends? fromFirestoreDoc({
    required Map<String, dynamic> doc,
    required String docId,
  }) {
    for (var key in doc.keys) {
      if (doc[key] == null) return null;
    }
    return UserFriends(
      docId: docId,
      uid_send: doc[UID_SEND],
      uid_receive: doc[UID_RECEIVE],
      accept: doc[ACCEPT],
    );
  }
}
