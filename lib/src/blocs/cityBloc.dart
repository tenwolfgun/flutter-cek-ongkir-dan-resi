import 'package:cek_ongkir_dan_resi/src/models/cityModel.dart';
import 'package:cek_ongkir_dan_resi/src/models/ongkirModel.dart';
// import 'package:cek_ongkir_dan_resi/src/models/provinceModel.dart';
import 'package:cek_ongkir_dan_resi/src/resources/cityRepository.dart';
import 'package:rxdart/rxdart.dart';

class CityBloc {
  final CityRepository _cityRepository = CityRepository();
  // final BehaviorSubject<City> _subject = BehaviorSubject<City>();

  final _fetchCity   = PublishSubject<City>();
  final _cekOngkir   = PublishSubject<Ongkir>();
  final _kotaAsal    = BehaviorSubject<String>();
  final _kotaTujuan  = BehaviorSubject<String>();
  final _kurir       = BehaviorSubject<String>();
  final _berat       = BehaviorSubject<String>();
  // final _fetchProvince = PublishSubject<Province>();

  Observable<City> get allCity => _fetchCity.stream;
  Observable<Ongkir> get allOngkir => _cekOngkir.stream;
  // Observable<Province> get allProvince => _fetchProvince.stream;
  Function(String) get getKotaAsal => _kotaAsal.sink.add;
  Function(String) get getKotaTujuan => _kotaTujuan.sink.add;
  Function(String) get getKurir => _kurir.sink.add;
  Function(String)    get getBerat =>_berat.sink.add;



  fetchCity() async {
    City response = await _cityRepository.fetchCity();
    _fetchCity.sink.add(response);
  }

  // fetchProvince() async {
  //   Province response = await _cityRepository.fetchProvince();
  //   _fetchProvince.sink.add(response);
  // }

  cekOngkir() async {
    Ongkir response = await _cityRepository.cekOngkir(_kotaAsal.value, _kotaTujuan.value, _kurir.value, _berat.value);
    _cekOngkir.sink.add(response);
  }

  // getOngkir() {
  //   print(_kotaAsal.value);
  //   print(_kotaTujuan.value);
  //   print(_kurir.value);
  //   print(_berat.value);    Map body = await {'origin': kotaAsal, 'destination': kotaTujuan, 'weight' : berat, 'courier': kurir};

  // }

  dispose() async {
    await _fetchCity.drain();
    await _fetchCity.close();
    await _cekOngkir.drain();
    await _cekOngkir.close();
    _kotaAsal.close();
    _kotaTujuan.close();
    _kurir.close();
    _berat.close();
    // _fetchProvince.close();
  }

  // BehaviorSubject<City> get subject => _subject;
}

final bloc = CityBloc();