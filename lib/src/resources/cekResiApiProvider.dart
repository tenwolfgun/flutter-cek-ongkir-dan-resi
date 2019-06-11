import 'package:cek_ongkir_dan_resi/src/models/cekResiModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'dart:async';

class CekResiApiProvider {
  final _client = Client();
  final _resiUrl = "https://parcels-app.herokuapp.com/";

  Future<Resi> fetchResi(nomorResi, kurir) async {
    Map body = {'resi': nomorResi, 'kurir': kurir};

    final response = await _client.post(_resiUrl,
      body: body,
    );
    if (response.statusCode == 200) {
      return compute(resiFromJson, response.body);
    } else {
      throw Exception("Failed to get data");
    }
  }
}