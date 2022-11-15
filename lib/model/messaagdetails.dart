class messaagdetails{
  String senderId,messagebody;
  int sendtime;

//<editor-fold desc="Data Methods">

  messaagdetails({
    required this.senderId,
    required this.messagebody,
    required this.sendtime,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is messaagdetails &&
          runtimeType == other.runtimeType &&
          senderId == other.senderId &&
          messagebody == other.messagebody &&
          sendtime == other.sendtime);

  @override
  int get hashCode =>
      senderId.hashCode ^ messagebody.hashCode ^ sendtime.hashCode;

  @override
  String toString() {
    return 'messaagdetails{' +
        ' senderId: $senderId,' +
        ' messagebody: $messagebody,' +
        ' sendtime: $sendtime,' +
        '}';
  }

  messaagdetails copyWith({
    String? senderId,
    String? messagebody,
    int? sendtime,
  }) {
    return messaagdetails(
      senderId: senderId ?? this.senderId,
      messagebody: messagebody ?? this.messagebody,
      sendtime: sendtime ?? this.sendtime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': this.senderId,
      'messagebody': this.messagebody,
      'sendtime': this.sendtime,
    };
  }

  factory messaagdetails.fromMap(Map<String, dynamic> map) {
    return messaagdetails(
      senderId: map['senderId'] as String,
      messagebody: map['messagebody'] as String,
      sendtime: map['sendtime'] as int,
    );
  }

//</editor-fold>
}