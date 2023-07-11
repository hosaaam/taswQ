class FaqModel {
  List<Data>? data;
  String? message;
  bool? status;

  FaqModel({this.data, this.message, this.status});

  FaqModel.fromJson(Map<dynamic, dynamic> json) {
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
  String? ask;
  String? answer;

  Data({this.id, this.ask, this.answer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ask = json['ask'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ask'] = this.ask;
    data['answer'] = this.answer;
    return data;
  }
}
