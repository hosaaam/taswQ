class ConfirmRegisterModel {
  DataUser? data;
  String? message;
  bool? status;

  ConfirmRegisterModel({this.data, this.message, this.status});

  ConfirmRegisterModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ?  DataUser.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

}

class DataUser {
  int? id;
  String? name;
  String? photo;
  String? email;
  bool? isNotify;
  String? balance;
  String? cityName;
  int? cityId;

  DataUser(
      {this.id,
        this.name,
        this.photo,
        this.email,
        this.isNotify,
        this.balance,
        this.cityName,
        this.cityId});

  DataUser.fromJson(Map<String, dynamic> json) {
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
