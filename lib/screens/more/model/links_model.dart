class LinksModel {
  Data? data;
  String? message;
  bool? status;

  LinksModel({this.data, this.message, this.status});

  LinksModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

}

class Data {
  String? snapChat;
  String? facebookLink;
  String? twitterLink;
  String? instagramLink;

  Data(
      {this.snapChat, this.facebookLink, this.twitterLink, this.instagramLink});

  Data.fromJson(Map<String, dynamic> json) {
    snapChat = json['snap_chat'];
    facebookLink = json['facebook_link'];
    twitterLink = json['twitter_link'];
    instagramLink = json['instagram_link'];
  }

}
