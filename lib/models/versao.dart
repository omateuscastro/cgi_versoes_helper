import 'package:cloud_firestore/cloud_firestore.dart';

class UltimaVersao {
  String lastVersion;

  UltimaVersao({this.lastVersion});

  UltimaVersao.fromJson(Map<String, dynamic> json) {
    lastVersion = json['lastVersion'];
  }

  factory UltimaVersao.fromDocument(DocumentSnapshot doc) {
    return UltimaVersao(
      lastVersion: doc['lastVersion'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastVersion'] = this.lastVersion;
    return data;
  }
}

class Versao {
  String id;
  int major;
  int minor;
  int patch;
  String launchDate;
  String description;
  List<String> notes;

  Versao(
      {this.id,
      this.major,
      this.minor,
      this.patch,
      this.launchDate,
      this.description,
      this.notes});

  Versao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    major = json['major'];
    minor = json['minor'];
    patch = json['patch'];
    launchDate = json['launch_date'];
    description = json['description'];
  }

  factory Versao.fromDocument(DocumentSnapshot doc) {
    return Versao(
      id: doc.documentID,
      major: doc['major'],
      minor: doc['minor'],
      patch: doc['patch'],
      launchDate: doc['launch_date'],
      description: doc['description'] ?? "",
      notes: new List<String>.from(doc['notes']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['major'] = this.major;
    data['minor'] = this.minor;
    data['patch'] = this.patch;
    data['launch_date'] = this.launchDate;
    data['description'] = this.description;
    return data;
  }
}
