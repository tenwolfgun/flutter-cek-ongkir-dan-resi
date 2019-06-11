import 'package:cek_ongkir_dan_resi/src/models/cityModel.dart';
// import 'package:cek_ongkir_dan_resi/src/models/provinceModel.dart';
import 'package:cek_ongkir_dan_resi/src/resources/cityApiProvider.dart';

class CityRepository {
  final _cityApiProvider = CityApiProvider();

  Future<City> fetchCity() {
    return _cityApiProvider.fetchCity();
  }

  Future cekOngkir(
          String kotaAsal, String kotaTujuan, String kurir, String berat) =>
      _cityApiProvider.cekOngkir(kotaAsal, kotaTujuan, kurir, berat);

  // Future<Province> fetchProvince() {
  //   return _cityApiProvider.fetchProvince();
  // }
}
