class AuthUserModel {
  Data? data;
  String? message;
  bool? status;

  AuthUserModel({this.data, this.message, this.status});

  AuthUserModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

}

class Data {
  int? id;
  String? name;
  String? photo;
  String? email;
  bool? isNotify;
  String? balance;
  String? cityName;
  int? cityId;

  Data(
      {this.id,
        this.name,
        this.photo,
        this.email,
        this.isNotify,
        this.balance,
        this.cityName,
        this.cityId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    email = json['email'];
    isNotify = json['is_notify'];
    balance = json['balance'];
    cityName = json['city_name'];
    cityId = json['city_id'];
  }

}
