// To parse this JSON data, do
//
//     final ongkir = ongkirFromJson(jsonString);

import 'dart:convert';

Ongkir ongkirFromJson(String str) => Ongkir.fromJson(json.decode(str));

String ongkirToJson(Ongkir data) => json.encode(data.toJson());

class Ongkir {
    Rajaongkir rajaongkir;

    Ongkir({
        this.rajaongkir,
    });

    factory Ongkir.fromJson(Map<String, dynamic> json) => new Ongkir(
        rajaongkir: Rajaongkir.fromJson(json["rajaongkir"]),
    );

    Map<String, dynamic> toJson() => {
        "rajaongkir": rajaongkir.toJson(),
    };
}

class Rajaongkir {
    Status status;

    Rajaongkir({
        this.status,
    });

    factory Rajaongkir.fromJson(Map<String, dynamic> json) => new Rajaongkir(
        status: Status.fromJson(json["status"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status.toJson(),
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