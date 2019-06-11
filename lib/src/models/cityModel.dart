// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
    Rajaongkir rajaongkir;

    City({
        this.rajaongkir,
    });

    factory City.fromJson(Map<String, dynamic> json) => new City(
        rajaongkir: Rajaongkir.fromJson(json["rajaongkir"]),
    );

    Map<String, dynamic> toJson() => {
        "rajaongkir": rajaongkir.toJson(),
    };
}

class Rajaongkir {
    // List<dynamic> query;
    Status status;
    List<Result> results;

    Rajaongkir({
        // this.query,
        this.status,
        this.results,
    });

    factory Rajaongkir.fromJson(Map<String, dynamic> json) => new Rajaongkir(
        // query: new List<dynamic>.from(json["query"].map((x) => x)),
        status: Status.fromJson(json["status"]),
        results: new List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        // "query": new List<dynamic>.from(query.map((x) => x)),
        "status": status.toJson(),
        "results": new List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    String cityId;
    String provinceId;
    String province;
    Type type;
    String cityName;
    String postalCode;

    Result({
        this.cityId,
        this.provinceId,
        this.province,
        this.type,
        this.cityName,
        this.postalCode,
    });

    factory Result.fromJson(Map<String, dynamic> json) => new Result(
        cityId: json["city_id"],
        provinceId: json["province_id"],
        province: json["province"],
        type: typeValues.map[json["type"]],
        cityName: json["city_name"],
        postalCode: json["postal_code"],
    );

    Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "province_id": provinceId,
        "province": province,
        "type": typeValues.reverse[type],
        "city_name": cityName,
        "postal_code": postalCode,
    };
}

enum Type { KABUPATEN, KOTA }

final typeValues = new EnumValues({
    "Kabupaten": Type.KABUPATEN,
    "Kota": Type.KOTA
});

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

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
