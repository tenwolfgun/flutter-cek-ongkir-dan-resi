import 'package:cek_ongkir_dan_resi/src/models/cekResiModel.dart';
import 'package:cek_ongkir_dan_resi/src/resources/cekResiRepository.dart';
import 'package:rxdart/rxdart.dart';

class CekResiBloc {
  final CekResiRepository _cekResiRepository = CekResiRepository();

  final _cekResi = PublishSubject<Resi>();
  final _nomorResi = BehaviorSubject<String>();
  final _kurir = BehaviorSubject<String>();

  Observable<Resi> get allResi => _cekResi.stream;
  Function(String) get getNomorResi => _nomorResi.sink.add;
  Function(String) get getKurir => _kurir.sink.add;

  fetchResi() async {
    Resi response = await _cekResiRepository.fetchResi(_nomorResi.value, _kurir.value);
    _cekResi.sink.add(response);
  }

  dispose() async {
    await _cekResi.drain();
    _cekResi.close();
    await _nomorResi.close();
    await _kurir.close();
  }
}

final bloc = CekResiBloc();