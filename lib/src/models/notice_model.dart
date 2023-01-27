import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeModel {
  String? title;
  String? description;
  Timestamp? date;

  NoticeModel({
    this.title,
    this.description,
    this.date,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      title: json['title'] == null ? "" : json['title'] as String,
      description: json['description'] == null ? '' : json['description'] as String,
      date: json['date']  as Timestamp,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'description': description,
    };
  }

}
