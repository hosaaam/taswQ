class BannersModel {
  List<Data>? data;
  String? message;
  bool? status;

  BannersModel({this.data, this.message, this.status});

  BannersModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? photo;
  String? link;

  Data({this.id, this.photo, this.link});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['link'] = this.link;
    return data;
  }
}
