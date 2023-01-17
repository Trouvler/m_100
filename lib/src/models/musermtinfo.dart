class MUserinfo {
  List<dynamic>? mtcomList;
  List<dynamic>? mtwishList;

  MUserinfo({
    this.mtcomList,
    this.mtwishList,
  });

  factory MUserinfo.fromJson(Map<String, dynamic>? json) {
    return MUserinfo(
      mtcomList: json!['DoneList'] == null ? [] : json['DoneList'] as List<dynamic>,
      mtwishList: json!['WishList'] == null ? [] : json['WishList'] as List<dynamic>,
    );
  }

}
