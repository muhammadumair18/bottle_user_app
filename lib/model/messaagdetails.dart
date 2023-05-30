class messaagdetails{
  String senderId,messagebody,selfDocId;
  int sendtime;

//<editor-fold desc="Data Methods">
  messaagdetails({
    required this.senderId,
    required this.messagebody,
    required this.selfDocId,
    required this.sendtime,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is messaagdetails &&
          runtimeType == other.runtimeType &&
          senderId == other.senderId &&
          messagebody == other.messagebody &&
          selfDocId == other.selfDocId &&
          sendtime == other.sendtime);

  @override
  int get hashCode =>
      senderId.hashCode ^
      messagebody.hashCode ^
      selfDocId.hashCode ^
      sendtime.hashCode;

  @override
  String toString() {
    return 'messaagdetails{' +
        ' senderId: $senderId,' +
        ' messagebody: $messagebody,' +
        ' selfDocId: $selfDocId,' +
        ' sendtime: $sendtime,' +
        '}';
  }

  messaagdetails copyWith({
    String? senderId,
    String? messagebody,
    String? selfDocId,
    int? sendtime,
  }) {
    return messaagdetails(
      senderId: senderId ?? this.senderId,
      messagebody: messagebody ?? this.messagebody,
      selfDocId: selfDocId ?? this.selfDocId,
      sendtime: sendtime ?? this.sendtime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': this.senderId,
      'messagebody': this.messagebody,
      'selfDocId': this.selfDocId,
      'sendtime': this.sendtime,
    };
  }

  factory messaagdetails.fromMap(Map<String, dynamic> map) {
    return messaagdetails(
      senderId: map['senderId'] as String,
      messagebody: map['messagebody'] as String,
      selfDocId: map['selfDocId'] as String,
      sendtime: map['sendtime'] as int,
    );
  }

//</editor-fold>
}