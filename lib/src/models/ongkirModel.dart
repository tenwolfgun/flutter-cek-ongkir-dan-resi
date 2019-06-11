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
    Query query;
    Status status;
    NDetails originDetails;
    NDetails destinationDetails;
    List<Result> results;

    Rajaongkir({
        this.query,
        this.status,
        this.originDetails,
        this.destinationDetails,
        this.results,
    });

    factory Rajaongkir.fromJson(Map<String, dynamic> json) => new Rajaongkir(
        query: Query.fromJson(json["query"]),
        status: Status.fromJson(json["status"]),
        originDetails: NDetails.fromJson(json["origin_details"]),
        destinationDetails: NDetails.fromJson(json["destination_details"]),
        results: new List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "query": query.toJson(),
        "status": status.toJson(),
        "origin_details": originDetails.toJson(),
        "destination_details": destinationDetails.toJson(),
        "results": new List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class NDetails {
    String cityId;
    String provinceId;
    String province;
    String type;
    String cityName;
    String postalCode;

    NDetails({
        this.cityId,
        this.provinceId,
        this.province,
        this.type,
        this.cityName,
        this.postalCode,
    });

    factory NDetails.fromJson(Map<String, dynamic> json) => new NDetails(
        cityId: json["city_id"],
        provinceId: json["province_id"],
        province: json["province"],
        type: json["type"],
        cityName: json["city_name"],
        postalCode: json["postal_code"],
    );

    Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "province_id": provinceId,
        "province": province,
        "type": type,
        "city_name": cityName,
        "postal_code": postalCode,
    };
}

class Query {
    String origin;
    String destination;
    int weight;
    String courier;

    Query({
        this.origin,
        this.destination,
        this.weight,
        this.courier,
    });

    factory Query.fromJson(Map<String, dynamic> json) => new Query(
        origin: json["origin"],
        destination: json["destination"],
        weight: json["weight"],
        courier: json["courier"],
    );

    Map<String, dynamic> toJson() => {
        "origin": origin,
        "destination": destination,
        "weight": weight,
        "courier": courier,
    };
}

class Result {
    String code;
    String name;
    List<ResultCost> costs;

    Result({
        this.code,
        this.name,
        this.costs,
    });

    factory Result.fromJson(Map<String, dynamic> json) => new Result(
        code: json["code"],
        name: json["name"],
        costs: new List<ResultCost>.from(json["costs"].map((x) => ResultCost.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "costs": new List<dynamic>.from(costs.map((x) => x.toJson())),
    };
}

class ResultCost {
    String service;
    String description;
    List<CostCost> cost;

    ResultCost({
        this.service,
        this.description,
        this.cost,
    });

    factory ResultCost.fromJson(Map<String, dynamic> json) => new ResultCost(
        service: json["service"],
        description: json["description"],
        cost: new List<CostCost>.from(json["cost"].map((x) => CostCost.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "service": service,
        "description": description,
        "cost": new List<dynamic>.from(cost.map((x) => x.toJson())),
    };
}

class CostCost {
    int value;
    String etd;
    String note;

    CostCost({
        this.value,
        this.etd,
        this.note,
    });

    factory CostCost.fromJson(Map<String, dynamic> json) => new CostCost(
        value: json["value"],
        etd: json["etd"],
        note: json["note"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "etd": etd,
        "note": note,
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