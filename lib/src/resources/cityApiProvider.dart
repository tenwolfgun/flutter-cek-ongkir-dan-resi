import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'dart:async';
import 'package:cek_ongkir_dan_resi/src/models/cityModel.dart';
import 'package:cek_ongkir_dan_resi/src/models/ongkirModel.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:cek_ongkir_dan_resi/src/models/provinceModel.dart';

class CityApiProvider {
  final _client = Client();
  final _cityUrl     = "https://api.rajaongkir.com/starter/city";
  // final _provinceUrl = "https://api.rajaongkir.com/starter/province";
  final _ongkirUrl   = "https://api.rajaongkir.com/starter/cost";

  Future<City> fetchCity() async {
    final response = await _client.get(_cityUrl, headers: {
      "Key": "42b1bb7017db46a4413549e3b042ffc5"
    });
    if (response.statusCode == 200) {
      return compute(cityFromJson, response.body);
    // }else if (response.statusCode == 400) {
    //   return compute(cityFromJson, response.body);
    }else {
      throw Exception("Failed to get data");
    }
  }

  Future<Ongkir> cekOngkir(kotaAsal, kotaTujuan, kurir, berat) async {
    Map body = {'origin': kotaAsal, 'destination': kotaTujuan, 'weight' : berat, 'courier': kurir};

    final response = await _client.post(_ongkirUrl, 
      body: body,
      headers: {
      "Key": "42b1bb7017db46a4413549e3b042ffc5"
    });
    if (response.statusCode == 200) {
      return compute(ongkirFromJson, response.body);
    } else {
      throw Exception("Failed to get data");
    }
  }

  // Future<Province> fetchProvince() async {
  //   final response = await _client.get(_provinceUrl, headers: {
  //     "Key": "42b1bb7017db46a4413549e3b042ffc5"
  //   });
  //   if (response.statusCode == 200) {
  //     return compute(provinceFromJson, response.body);
  //   }else {
  //     throw Exception("Failed to Load");
  //   }
  // }
}