class CariKartEkleGuncelleResponseDto{
  String? Error;

  CariKartEkleGuncelleResponseDto({this.Error});

  factory CariKartEkleGuncelleResponseDto.fromJson(Map<String, dynamic> json) {

    return CariKartEkleGuncelleResponseDto(
      Error: json['Error'] ?? "",
    );
  }
}