class MessageModel {
  String dateTime,
      receiverId,
      senderId,
      content,
      idMessage,
      profileImageSender,
      profileImageReceiver,
      nameSender,
      nameReceiver;
  int index;

  MessageModel({
    required this.dateTime,
    required this.receiverId,
    required this.senderId,
    required this.content,
    required this.index,
    required this.idMessage,
    required this.nameReceiver,
    required this.nameSender,
    required this.profileImageReceiver,
    required this.profileImageSender,
  });

  Map<String, dynamic> toMap() {
    return {
      'dateTime': this.dateTime,
      'receiverId': this.receiverId,
      'senderId': this.senderId,
      'content': this.content,
      'idMessage': this.idMessage,
      'profileImageSender': this.profileImageSender,
      'profileImageReceiver': this.profileImageReceiver,
      'nameSender': this.nameSender,
      'nameReceiver': this.nameReceiver,
      'index': this.index,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      dateTime: map['dateTime'] as String,
      receiverId: map['receiverId'] as String,
      senderId: map['senderId'] as String,
      content: map['content'] as String,
      idMessage: map['idMessage'] as String,
      profileImageSender: map['profileImageSender'] as String,
      profileImageReceiver: map['profileImageReceiver'] as String,
      nameSender: map['nameSender'] as String,
      nameReceiver: map['nameReceiver'] as String,
      index: map['index'] as int,
    );
  }
}
