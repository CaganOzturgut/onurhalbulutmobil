class CariKartSaveResponseDto{
  String? Error;

  CariKartSaveResponseDto({required this.Error});

  factory CariKartSaveResponseDto.fromJson(Map<String, dynamic> json) {


    return CariKartSaveResponseDto(
      Error: json['Error'] ?? "",
    );
  }
}