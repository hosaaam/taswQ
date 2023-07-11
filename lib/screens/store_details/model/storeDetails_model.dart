class ShopDetailsModel {
  Data? data;
  String? message;
  bool? status;

  ShopDetailsModel({this.data, this.message, this.status});

  ShopDetailsModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? photo;
  String? pio;
  String? timeFrom;
  String? timeTo;
  bool? isFavorite;
  String? rate;
  String? lat;
  String? lng;
  List<Rates>? rates;
  List<Offers>? offers;
  String? shareLink;

  Data(
      {this.id,
        this.name,
        this.photo,
        this.lat,
        this.lng,
        this.pio,
        this.timeFrom,
        this.timeTo,
        this.isFavorite,
        this.rate,
        this.rates,
        this.offers,
        this.shareLink});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    pio = json['pio'];
    lat = json['lat'];
    lng = json['lng'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    isFavorite = json['is_favorite'];
    rate = json['rate'];
    if (json['rates'] != null) {
      rates = <Rates>[];
      json['rates'].forEach((v) {
        rates!.add(new Rates.fromJson(v));
      });
    }
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(new Offers.fromJson(v));
      });
    }
    shareLink = json['share_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['pio'] = this.pio;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['is_favorite'] = this.isFavorite;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['rate'] = this.rate;
    if (this.rates != null) {
      data['rates'] = this.rates!.map((v) => v.toJson()).toList();
    }
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    data['share_link'] = this.shareLink;
    return data;
  }
}

class Rates {
  int? id;
  String? rate;
  String? name;
  String? photo;
  String? comment;
  String? commentTime;

  Rates({this.id, this.rate, this.name, this.photo, this.comment});

  Rates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    name = json['name'];
    photo = json['photo'];
    comment = json['comment'];
    commentTime = json['commentTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rate'] = this.rate;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['comment'] = this.comment;
    data['commentTime'] = this.commentTime;
    return data;
  }
}

class Offers {
  int? id;
  String? photo;
  String? link;

  Offers({this.id, this.photo});

  Offers.fromJson(Map<String, dynamic> json) {
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
