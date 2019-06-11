// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);


import 'dart:convert';

Province provinceFromJson(String str) => Province.fromJson(json.decode(str));

String provinceToJson(Province data) => json.encode(data.toJson());

class Province {
    Rajaongkir rajaongkir;

    Province({
        this.rajaongkir,
    });

    factory Province.fromJson(Map<String, dynamic> json) => new Province(
        rajaongkir: Rajaongkir.fromJson(json["rajaongkir"]),
    );

    Map<String, dynamic> toJson() => {
        "rajaongkir": rajaongkir.toJson(),
    };
}

class Rajaongkir {
    List<dynamic> query;
    Status status;
    List<Result> results;

    Rajaongkir({
        this.query,
        this.status,
        this.results,
    });

    factory Rajaongkir.fromJson(Map<String, dynamic> json) => new Rajaongkir(
        query: new List<dynamic>.from(json["query"].map((x) => x)),
        status: Status.fromJson(json["status"]),
        results: new List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "query": new List<dynamic>.from(query.map((x) => x)),
        "status": status.toJson(),
        "results": new List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    String provinceId;
    String province;

    Result({
        this.provinceId,
        this.province,
    });

    factory Result.fromJson(Map<String, dynamic> json) => new Result(
        provinceId: json["province_id"],
        province: json["province"],
    );

    Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province": province,
    };
}

class Status {
    int code;
    String description;

    Status({
        this.code,
        this.description,
    });

    factory Status.fromJson(Map<String, dynamic> json) => new Status(
        code: json["code"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
    };
}