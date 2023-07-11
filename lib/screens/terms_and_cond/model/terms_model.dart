class TermsAndConditionModel {
  Data? data;
  String? message;
  bool? status;

  TermsAndConditionModel({this.data, this.message, this.status});

  TermsAndConditionModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

}

class Data {
  String? title;
  String? content;

  Data({this.title, this.content});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }

}
