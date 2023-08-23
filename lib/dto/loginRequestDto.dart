class LoginRequestDto{
  String UserName;
  String UserPass;

  LoginRequestDto({required this.UserName,required this.UserPass});

  factory LoginRequestDto.fromDatabaseJson(Map<String,dynamic>data)=>
      LoginRequestDto(
        UserName: data['UserName'],
        UserPass: data['UserPass'],
  );

  Map<String,dynamic>toDatabaseJson()=>{
    "UserName":this.UserName,
    "Pass":this.UserPass
  };
}


class LoginRequestDto2 {
  final String UserName;
  final String UserPass;

  LoginRequestDto2({required this.UserName, required this.UserPass});

  LoginRequestDto2.fromJson(Map<String, dynamic> json)
      : UserName = json['UserName'],
        UserPass = json['UserPass'];

  Map<String, dynamic> toJson() {
    return {
      'UserName': UserName,
      'UserPass': UserPass,
    };
  }
}