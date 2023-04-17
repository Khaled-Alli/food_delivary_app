class MyUser{
  var name;
  var phone;
  var password;
  var email;
  MyUser({this.name,this.phone,this.password,this.email});

  MyUser.fromJson(Map<String,dynamic> json){
    name=json["name"];
    phone=json["phone"];
    password=json["password"];
    email=json["email"];
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic>data={};
    data["name"]=name;
    data["phone"]=phone;
    data["password"]=password;
    data["email"]=email;
    return data;
  }
}