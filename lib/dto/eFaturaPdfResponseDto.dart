import 'dart:convert';

class EFaturaPdfResponseDto{
  List<int> PDF;
  String? Error;

  EFaturaPdfResponseDto({required this.PDF,this.Error});

  factory EFaturaPdfResponseDto.fromJson(Map<String, dynamic> json) {

    var pdfData = json['PDF'];

    List<int>? pdfBytes;
    if (pdfData != null) {
      pdfBytes = base64.decode(pdfData);
    }

    String? error = json['Error'];
    if (error == null) {
      error = "";
    }

    return EFaturaPdfResponseDto(
      Error: json['Error'] ?? "",
      PDF: pdfBytes ?? []
    );
  }
}