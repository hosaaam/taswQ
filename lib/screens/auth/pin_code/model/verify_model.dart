class VerifyModel {
  Data? data;
  String? message;
  bool? status;

  VerifyModel({this.data, this.message, this.status});

  VerifyModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

}

class Data {
  String? token;
  User? user;
  bool? firstLogin;

  Data({this.token, this.user, this.firstLogin});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
    firstLogin = json['first_login'];
  }

}

class User {
  int? id;
  String? name;
  String? photo;
  String? email;
  bool? isNotify;
  String? balance;
  String? cityName;
  int? cityId;

  User(
      {this.id,
        this.name,
        this.photo,
        this.email,
        this.isNotify,
        this.balance,
        this.cityName,
        this.cityId});

  User.fromJson(Map<String, dynamic> json) {
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
