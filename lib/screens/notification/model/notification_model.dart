class NotificationsModel {
  Data? data;
  String? message;
  bool? status;

  NotificationsModel({this.data, this.message, this.status});

  NotificationsModel.fromJson(Map<dynamic, dynamic> json) {
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
  List<Day>? day;
  List<Yesterday>? yesterday;

  Data({this.day, this.yesterday});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['day'] != null) {
      day = <Day>[];
      json['day'].forEach((v) {
        day!.add(new Day.fromJson(v));
      });
    }
    if (json['yesterday'] != null) {
      yesterday = <Yesterday>[];
      json['yesterday'].forEach((v) {
        yesterday!.add(new Yesterday.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.day != null) {
      data['day'] = this.day!.map((v) => v.toJson()).toList();
    }
    if (this.yesterday != null) {
      data['yesterday'] = this.yesterday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Day {
  String? id;
  String? title;
  String? body;
  String? photo;
  String? date;

  Day({this.id, this.title, this.body, this.photo, this.date});

  Day.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    photo = json['photo'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['photo'] = this.photo;
    data['date'] = this.date;
    return data;
  }
}

class Yesterday {
  String? id;
  String? title;
  String? body;
  Null? photo;
  String? date;

  Yesterday({this.id, this.title, this.body, this.photo, this.date});

  Yesterday.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    photo = json['photo'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['photo'] = this.photo;
    data['date'] = this.date;
    return data;
  }
}
