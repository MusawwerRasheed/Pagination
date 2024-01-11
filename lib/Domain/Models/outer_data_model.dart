import 'dart:convert';

class OuterData {

  final int? total;
  final int? skip;
  final int? limit;

  OuterData({

    this.total,
    this.skip,
    this.limit,
  });

  factory OuterData.fromRawJson(String str) => OuterData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OuterData.fromJson(Map<String, dynamic> json) => OuterData(

    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {

    "total": total,
    "skip": skip,
    "limit": limit,
  };
}





