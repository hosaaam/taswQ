class GetContactUsModel {
  Data? data;
  String? message;
  bool? status;

  GetContactUsModel({this.data, this.message, this.status});

  GetContactUsModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

}

class Data {
  String? phone;
  String? email;
  String? address;
  String? lat;
  String? lng;

  Data({this.phone, this.email, this.address, this.lat, this.lng});

  Data.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
  }

}
