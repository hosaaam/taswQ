class FilterModel {
  List<Data>? data;
  String? message;
  bool? status;

  FilterModel({this.data, this.message, this.status});

  FilterModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

}

class Data {
  int? id;
  String? name;
  String? photo;
  String? pio;
  String? rate;
  String? timeFrom;
  String? timeTo;
  bool? isFavorite;

  Data(
      {this.id,
        this.name,
        this.photo,
        this.pio,
        this.rate,
        this.timeFrom,
        this.timeTo,
        this.isFavorite});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    pio = json['pio'];
    rate = json['rate'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    isFavorite = json['is_favorite'];
  }

}
