class UserInfo {
  int ?id;
  String? name;
  String ?email;
  String? phone;
  String ? image;
  int ? points;
  int? credit;
  String? token;

UserInfo.fromJson(Map<String, dynamic>? json)
      : id = json?['id'],
        name = json?['name'],
        email = json?['email'],
        phone = json?['phone'],
        image = json?['image'],
        points = json?['points'],
        credit = json?['credit'],
        token = json?['token']??'';

}



class LoginInfo{
  bool  ?status;
  String?  message;
  UserInfo? data ;

  LoginInfo({
    required this.status,
    required this.message,
    required this.data,
  });

  LoginInfo.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        message = json['message'],
        data = UserInfo.fromJson(json['data']);


}