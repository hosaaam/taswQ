class OrderDetailsModel {
  Data? data;
  String? message;
  bool? status;

  OrderDetailsModel({this.data, this.message, this.status});

  OrderDetailsModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

}

class Data {
  int? id;
  int? countItems;
  String? total;
  String? date;
  String? numOrd;
  List<Items>? items;

  Data({this.id, this.total, this.date, this.items,this.countItems});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    numOrd = json['num_order'];
    countItems = json['count_items'];
    date = json['date'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add( Items.fromJson(v));
      });
    }
  }

}

class Items {
  int? id;
  int? cartId;
  String? name;
  String? photo;
  int? price;
  int? qty;

  Items({this.id, this.cartId, this.name, this.photo, this.price, this.qty});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    name = json['name'];
    photo = json['photo'];
    price = json['price'];
    qty = json['qty'];
  }

}
