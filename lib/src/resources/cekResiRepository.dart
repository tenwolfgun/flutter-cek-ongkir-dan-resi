import 'package:cek_ongkir_dan_resi/src/models/cekResiModel.dart';
import 'package:cek_ongkir_dan_resi/src/resources/cekResiApiProvider.dart';

class CekResiRepository {
  final _cekResiApiProvider = CekResiApiProvider();

  Future<Resi> fetchResi(String nomorResi, String kurir) =>
      _cekResiApiProvider.fetchResi(nomorResi, kurir);
}
