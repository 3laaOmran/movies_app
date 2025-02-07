/// message : "User created successfully"
/// data : {"email":"mayar25@gmail.com","password":"$2b$10$jjIU1lyPlR8bo0YykFauE./gIFqqKnNuzoFDAGJ2MIClt73K2aMs2","name":"mayar abdo","phone":"+201141209331","avaterId":1,"_id":"67a3f33aa16be0554456efa8","createdAt":"2025-02-05T23:24:42.084Z","updatedAt":"2025-02-05T23:24:42.084Z","__v":0}

class RegisterModel {
  RegisterModel({
      this.message, 
      this.data,
      this.statusCode
  });

  RegisterModel.fromJson(dynamic json) {
    message = (json['message'] is List) ? json['message'].toString() : json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode=json['statusCode'];
  }
  String? message;
  Data? data;
  int?statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['statusCode']=statusCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// email : "mayar25@gmail.com"
/// password : "$2b$10$jjIU1lyPlR8bo0YykFauE./gIFqqKnNuzoFDAGJ2MIClt73K2aMs2"
/// name : "mayar abdo"
/// phone : "+201141209331"
/// avaterId : 1
/// _id : "67a3f33aa16be0554456efa8"
/// createdAt : "2025-02-05T23:24:42.084Z"
/// updatedAt : "2025-02-05T23:24:42.084Z"
/// __v : 0

class Data {
  Data({
      this.email,
      this.password,
      this.name,
      this.phone,
      this.avaterId,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.v,});

  Data.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
    avaterId = json['avaterId'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? email;
  String? password;
  String? name;
  String? phone;
  int? avaterId;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    map['name'] = name;
    map['phone'] = phone;
    map['avaterId'] = avaterId;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}