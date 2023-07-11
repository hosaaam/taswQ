class OrdersModel {
  Data? data;
  String? message;
  bool? status;

  OrdersModel({this.data, this.message, this.status});

  OrdersModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

}

class Data {
  List<CurrentOrders>? currentOrders;
  List<PreviousOrders>? previousOrders;

  Data({this.currentOrders, this.previousOrders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['current_orders'] != null) {
      currentOrders = <CurrentOrders>[];
      json['current_orders'].forEach((v) {
        currentOrders!.add( CurrentOrders.fromJson(v));
      });
    }
    if (json['previous_orders'] != null) {
      previousOrders = <PreviousOrders>[];
      json['previous_orders'].forEach((v) {
        previousOrders!.add( PreviousOrders.fromJson(v));
      });
    }
  }

}

class CurrentOrders {
  int? id;
  String? total;
  String? numOrd;
  int? countItems;
  String? date;
  List<Items>? items;

  CurrentOrders({this.id, this.total, this.date, this.items,this.countItems});

  CurrentOrders.fromJson(Map<String, dynamic> json) {
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

class PreviousOrders {
  int? id;
  String? total;
  String? numOrd;
  String? date;
  int? countItems;
  List<Items>? items;

  PreviousOrders({this.id, this.total, this.date, this.items,this.countItems});

  PreviousOrders.fromJson(Map<String, dynamic> json) {
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
