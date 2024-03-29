class MUser {
  String? uid;
  String? nickname;
  String? thumbnail;
  String? description;
  List<String>? mtcomList;

  MUser({
    this.uid,
    this.nickname,
    this.thumbnail,
    this.description,
    this.mtcomList,
  });

  factory MUser.fromJson(Map<String, dynamic> json) {
    return MUser(
      uid: json['uid'] == null ? '' : json['uid'] as String,
      nickname: json['nickname'] == null ? '' : json['nickname'] as String,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nickname': nickname,
      'thumbnail': thumbnail,
      'description': description,
    };
  }

  MUser copyWith({
    String? uid,
    String? nickname,
    String? thumbnail,
    String? description,
  }) {
    return MUser(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
    );
  }
}
