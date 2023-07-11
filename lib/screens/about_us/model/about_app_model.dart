class AboutAppModel {
  Data? data;
  String? message;
  bool? status;

  AboutAppModel({this.data, this.message, this.status});

  AboutAppModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

}

class Data {
  String? content;

  Data({this.content});

  Data.fromJson(Map<String, dynamic> json) {
    content = json['content'];
  }

}
