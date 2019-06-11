// To parse this JSON data, do
//
//     final resi = resiFromJson(jsonString);

import 'dart:convert';

Resi resiFromJson(String str) => Resi.fromJson(json.decode(str));

String resiToJson(Resi data) => json.encode(data.toJson());

class Resi {
    Data data;
    String url;
    String originalUrl;

    Resi({
        this.data,
        this.url,
        this.originalUrl,
    });

    factory Resi.fromJson(Map<String, dynamic> json) => new Resi(
        data: Data.fromJson(json["data"]),
        url: json["url"],
        originalUrl: json["originalUrl"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "url": url,
        "originalUrl": originalUrl,
    };
}

class Data {
    List<Result> results;

    Data({
        this.results,
    });

    factory Data.fromJson(Map<String, dynamic> json) => new Data(
        results: new List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": new List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    String jam;
    String status;
    String lokasi;

    Result({
        this.jam,
        this.status,
        this.lokasi,
    });

    factory Result.fromJson(Map<String, dynamic> json) => new Result(
        jam: json["jam"],
        status: json["status"],
        lokasi: json["lokasi"],
    );

    Map<String, dynamic> toJson() => {
        "jam": jam,
        "status": status,
        "lokasi": lokasi,
    };
}