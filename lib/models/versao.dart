class UltimaVersao {
  String lastversion;

  UltimaVersao({this.lastversion});

  UltimaVersao.fromJson(Map<String, dynamic> json) {
    lastversion = json['lastversion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastversion'] = this.lastversion;
    return data;
  }
}

class Versao {
  int id;
  String name;
  int major;
  int minor;
  int patch;
  String launchDate;
  String description;
  int appId;

  Versao(
      {this.id,
      this.name,
      this.major,
      this.minor,
      this.patch,
      this.launchDate,
      this.description,
      this.appId});

  Versao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    major = json['major'];
    minor = json['minor'];
    patch = json['patch'];
    launchDate = json['launch_date'];
    description = json['description'];
    appId = json['app_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['major'] = this.major;
    data['minor'] = this.minor;
    data['patch'] = this.patch;
    data['launch_date'] = this.launchDate;
    data['description'] = this.description;
    data['app_id'] = this.appId;
    return data;
  }
}
