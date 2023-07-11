class FavouritesModel {
  List<Data>? data;
  String? message;
  bool? status;

  FavouritesModel({this.data, this.message, this.status});

  FavouritesModel.fromJson(Map<dynamic, dynamic> json) {
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
  String? pio;
  String? photo;
  String? category;
  bool? isFavorite;
  String? rates;

  Data(
      {this.id,
        this.name,
        this.pio,
        this.photo,
        this.category,
        this.isFavorite,
        this.rates});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pio = json['pio'];
    photo = json['photo'];
    category = json['category'];
    isFavorite = json['is_favorite'];
    rates = json['rates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pio'] = this.pio;
    data['photo'] = this.photo;
    data['category'] = this.category;
    data['is_favorite'] = this.isFavorite;
    data['rates'] = this.rates;
    return data;
  }
}
