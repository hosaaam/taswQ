class ShopsModel {
  List<Data>? data;
  String? message;
  bool? status;

  ShopsModel({this.data, this.message, this.status});

  ShopsModel.fromJson(Map<dynamic, dynamic> json) {
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
  String? name;
  String? rate;
  String? photo;
  String? pio;
  String? timeFrom;
  String? timeTo;
  bool? isFavorite;

  Data(
      {this.id,
        this.name,
        this.rate,
        this.photo,
        this.pio,
        this.timeFrom,
        this.timeTo,
        this.isFavorite});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rate = json['rate'];
    photo = json['photo'];
    pio = json['pio'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    isFavorite = json['is_favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['photo'] = this.photo;
    data['pio'] = this.pio;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['is_favorite'] = this.isFavorite;
    return data;
  }
}
