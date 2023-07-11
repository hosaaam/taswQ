class DeleteItemModel {
  Data? data;
  String? message;
  bool? status;

  DeleteItemModel({this.data, this.message, this.status});

  DeleteItemModel.fromJson(Map<dynamic, dynamic> json) {
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
  String? total;
  List<Items>? items;

  Data({this.id, this.total, this.items});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? cartId;
  String? name;
  String? photo;
  int? price;
  String? total;
  int? qty;

  Items(
      {this.id,
        this.cartId,
        this.name,
        this.photo,
        this.price,
        this.total,
        this.qty});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    name = json['name'];
    photo = json['photo'];
    price = json['price'];
    total = json['total'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cart_id'] = this.cartId;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['price'] = this.price;
    data['total'] = this.total;
    data['qty'] = this.qty;
    return data;
  }
}
