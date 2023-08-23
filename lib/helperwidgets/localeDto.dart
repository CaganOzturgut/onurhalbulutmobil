class LocaleDto{
  late String LocaleKey;

  LocaleDto({required this.LocaleKey});

  LocaleDto.fromDatabaseJson(Map<String,dynamic>data){
    this.LocaleKey = data['LocaleKey'];
  }

  Map<String,dynamic> toDatabaseJson()=>{
    "LocaleKey":this.LocaleKey,
  };
}