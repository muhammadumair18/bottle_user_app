class MessengerTab{
  String name,id;
  int phototid;

//<editor-fold desc="Data Methods">

  MessengerTab({
    required this.name,
    required this.id,
    required this.phototid,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessengerTab &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id &&
          phototid == other.phototid);

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ phototid.hashCode;

  @override
  String toString() {
    return 'MessengerTab{' +
        ' name: $name,' +
        ' id: $id,' +
        ' phototid: $phototid,' +
        '}';
  }

  MessengerTab copyWith({
    String? name,
    String? id,
    int? phototid,
  }) {
    return MessengerTab(
      name: name ?? this.name,
      id: id ?? this.id,
      phototid: phototid ?? this.phototid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'id': this.id,
      'phototid': this.phototid,
    };
  }

  factory MessengerTab.fromMap(Map<String, dynamic> map) {
    return MessengerTab(
      name: map['name'] as String,
      id: map['id'] as String,
      phototid: map['phototid'] as int,
    );
  }

//</editor-fold>
}