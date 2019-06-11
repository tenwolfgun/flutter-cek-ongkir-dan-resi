import 'package:cek_ongkir_dan_resi/src/layout/layout_config.dart';
import 'package:flutter/material.dart';
import 'package:cek_ongkir_dan_resi/src/blocs/cityBloc.dart';
import 'package:cek_ongkir_dan_resi/src/models/cityModel.dart';
// import 'package:cek_ongkir_dan_resi/src/view/getOngkir.dart' as hlOngkir;
import './getOngkir.dart' as hlOngkir;
// import 'package:cek_ongkir_dan_resi/src/models/provinceModel.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/services.dart';

class CekOngkir extends StatefulWidget {
  @override
  _CekOngkir createState() => _CekOngkir();
}

class _CekOngkir extends State<CekOngkir> {
  // final GlobalKey<_HomeState> _key = GlobalKey<_HomeState>();
  // final TextEditingController _typeAheadController = TextEditingController();

  GlobalKey<AutoCompleteTextFieldState> _asalKotaKey = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState> _tujuanKotaKey = new GlobalKey();

  AutoCompleteTextField asalKotaTextField;

  AutoCompleteTextField tujuanKotaTextField;

  TextEditingController _asalKotaController = TextEditingController();
  TextEditingController _tujuanKotaController = TextEditingController();

  // String _kotaTerpilih;
  String _kotaAsal;
  String _kotaTujuan;
  String _kurirTerpilih;
  String _berat;
  List<Map> _daftarKurir = [
    {"id": "jne", "name": "JNE"},
    {"id": "tiki", "name": "TIKI"},
    {"id": "pos", "name": "POS Indonesia"}
  ];

  void _alert(String str) {
    AlertDialog _alertDialog = AlertDialog(
      content: Text(
        str,
        style: TextStyle(fontSize: 20.0),
      ),
      actions: <Widget>[
        RaisedButton(
          color: Colors.black,
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );

    showDialog(
        context: context, builder: (BuildContext context) => _alertDialog);
  }

  @override
  void initState() {
    super.initState();
    bloc.fetchCity();
    // if (kotaAsal == "") {
    //   kotaAsal = "36";
    // }
    // bloc.fetchProvince();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  // final fusion = bloc.allCity.withLatestFrom(bloc.allProvince, (foo, bar) {

  // });

  // var myObservable = new Observable.merge([bloc.allCity, bloc.allProvince]);

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("Cek Ongkir dan Resi"),
  //       centerTitle: true,
  //     ),
  //     resizeToAvoidBottomPadding: false,
  //     body: StreamBuilder(
  //       stream: bloc.allCity,
  //       builder: (context, AsyncSnapshot<City> snapshot,) {
  //         return StreamBuilder(
  //           stream: bloc.allProvince,
  //           builder: (context, AsyncSnapshot<Province> snapshot2) {
  //             if (snapshot.hasData) {
  //               return homeView(snapshot.data, snapshot2.data);
  //             }else {
  //               return Text("Error");
  //             }
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SizeConfig().init(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Cek Ongkir dan Resi",
      //     style: TextStyle(fontFamily: "Serif", fontSize: 20.0),
      //   ),
      //   centerTitle: true,
      //   elevation: 8.0,
      //   backgroundColor: Colors.red,
      //   shape: RoundedRectangleBorder(
      //       side: BorderSide(width: 0.0, style: BorderStyle.solid),
      //       borderRadius: BorderRadius.only(
      //           bottomLeft: Radius.circular(20.0),
      //           bottomRight: Radius.circular(0.0))),
      // ),
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: bloc.allCity,
          builder: (context, AsyncSnapshot<City> snapshot) {
            if (snapshot.hasData) {
              return homeView(snapshot.data);
            } else {
              return _buildLoadingWidget();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Loading data...",
          style: TextStyle(color: Colors.white),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        CircularProgressIndicator()
      ],
    ));
  }

  Widget homeView(City snapshot) {
    // if (snapshot.rajaongkir.results.length == null) {
    //   // return Center(
    //   //   // child: Text("Maaf server sendang mengalami masalah, silahkan coba lagi")
    //   // );
    //   // bloc.fetchCity();
    //   // return;
    //   Future.delayed(const Duration(seconds: 5));
    //   print("gagal");
    //   return bloc.fetchCity();
    // } else {
    return Container(
        width: SizeConfig.blockHorizontal * 100,
        height: SizeConfig.blockVertical * 100,
        color: Color(0xff29332F),
        padding: EdgeInsets.all(2.0),
        child: Card(
          color: Color(0xff29332F),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(30.0))),
          elevation: 6.0,
          child: Column(
            children: <Widget>[
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //       //  flex: 10,
              //       child: Card(
              //         elevation: 10.0,
              //         child: Container(
              //           color: Colors.white,
              //           padding: EdgeInsets.all(10.0),
              //           height: 50.0,
              //           child: Center(
              //             child: Text(
              //               "Cek Ongkir Domestik",
              //               style:
              //                   TextStyle(fontSize: 25.0, color: Colors.black),
              //             ),
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              Column(
                children: <Widget>[
                  Theme(
                    data: Theme.of(context).copyWith(
                        primaryColor: Colors.white, accentColor: Colors.red),
                    // data: ThemeData(
                    //   primaryColor: Colors.red,
                    //   canvasColor: Colors.red,
                    //   primaryColorDark: Colors.white
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: asalKotaTextField = AutoCompleteTextField(
                        style:
                            new TextStyle(color: Colors.white, fontSize: 20.0),
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.redAccent)),
                            // icon: Icon(Icons.perm_identity, color: Colors.red,),
                            suffixIcon: Container(
                              width: 85.0,
                              height: 60.0,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                            filled: true,
                            fillColor: Colors.transparent,
                            labelText: 'Kota Asal',
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 20.0)),
                        itemSubmitted: (item) {
                          // setState(() => _asalKotaController.text = item.cityName);
                          setState(() {
                            _asalKotaController.text = item.cityName;
                            _kotaAsal = item.cityId;
                          });
                        },
                        suggestionsAmount: 3,
                        clearOnSubmit: false,
                        controller: _asalKotaController,
                        key: _asalKotaKey,
                        suggestions: snapshot.rajaongkir.results,
                        itemBuilder: (context, item) {
                          return SingleChildScrollView(
                            child: ListTile(
                              title: Text(
                                item.cityName,
                                style: TextStyle(
                                    fontSize: SizeConfig.blockHorizontal * 4),
                              ),
                            ),
                          );
                          // return Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: <Widget>[
                          //     Expanded(
                          //       child: SingleChildScrollView(
                          //         child: Text(
                          //           item.cityName,
                          //           style: TextStyle(
                          //               fontSize:
                          //                   SizeConfig.blockHorizontal * 5),
                          //         ),
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding:
                          //           EdgeInsets.only(bottom: 20.0, top: 20.0),
                          //     ),
                          //     // Text(
                          //     //   item.cityId,
                          //     // )
                          //   ],
                          // );
                        },
                        itemSorter: (a, b) {
                          return a.cityName.compareTo(b.cityName);
                        },
                        itemFilter: (item, query) {
                          return item.cityName
                              .toLowerCase()
                              .startsWith(query.toLowerCase());
                        },
                        onFocusChanged: (hasFocus) {},
                      ),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                        primaryColor: Colors.white, accentColor: Colors.red),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: asalKotaTextField = AutoCompleteTextField(
                        style:
                            new TextStyle(color: Colors.white, fontSize: 20.0),
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.redAccent)),
                            // icon: Icon(Icons.perm_identity, color: Colors.red,),
                            suffixIcon: Container(
                              width: 85.0,
                              height: 60.0,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                            filled: true,
                            fillColor: Colors.transparent,
                            labelText: 'Kota Tujuan',
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 20.0)),
                        itemSubmitted: (item) {
                          // setState(() => _tujuanKotaController.text = item.cityName);
                          setState(() {
                            _tujuanKotaController.text = item.cityName;
                            _kotaTujuan = item.cityId;
                          });
                        },
                        suggestionsAmount: 3,
                        clearOnSubmit: false,
                        controller: _tujuanKotaController,
                        key: _tujuanKotaKey,
                        suggestions: snapshot.rajaongkir.results,
                        itemBuilder: (context, item) {
                          return SingleChildScrollView(
                            child: ListTile(
                              title: Text(
                                item.cityName,
                                style: TextStyle(
                                    fontSize: SizeConfig.blockHorizontal * 4),
                              ),
                            ),
                          );
                          // return Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: <Widget>[
                          //     Expanded(
                          //       child: SingleChildScrollView(
                          //         child: Text(
                          //           item.cityName,
                          //           style: TextStyle(
                          //               fontSize:
                          //                   SizeConfig.blockHorizontal * 5),
                          //         ),
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding:
                          //           EdgeInsets.only(bottom: 20.0, top: 20.0),
                          //     ),
                          //     // Text(
                          //     //   item.cityId,
                          //     // )
                          //   ],
                          // );
                        },
                        itemSorter: (a, b) {
                          return a.cityName.compareTo(b.cityName);
                        },
                        itemFilter: (item, query) {
                          return item.cityName
                              .toLowerCase()
                              .startsWith(query.toLowerCase());
                        },
                        onFocusChanged: (hasFocus) {},
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, left: 15.0, right: 0.0, bottom: 15.0),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              primaryColor: Colors.white,
                              accentColor: Colors.red),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.redAccent)),
                              // fillColor: Colors.white,
                              labelText: "Pilih Kurir",
                              labelStyle: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                              filled: true,
                            ),
                            value: _kurirTerpilih,
                            onChanged: (String newValue) {
                              setState(() {
                                _kurirTerpilih = newValue;
                              });
                            },
                            items: _daftarKurir.map((Map map) {
                              return DropdownMenuItem<String>(
                                value: map["id"].toString(),
                                child: Text(
                                  map["name"],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                              );
                            }).toList(),
                          ),
                        )),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            primaryColor: Colors.white,
                            accentColor: Colors.red),
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.redAccent)),
                              labelText: "Berat (Gram)",
                              labelStyle: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          keyboardType: TextInputType.number,
                          enableInteractiveSelection: false,
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                          onChanged: (String newValue) {
                            _berat = newValue;
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.blockVertical * 5),
                child: Theme(
                  data: Theme.of(context).copyWith(primaryColor: Colors.red),
                  child: OutlineButton(
                    splashColor: Colors.red,
                    color: Colors.transparent,
                    borderSide: BorderSide(color: Colors.white70, width: 10.0),
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.search, color: Colors.red),
                        Text("CEK ONGKIR!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.blockHorizontal * 4))
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        var checkKotaAsal = snapshot.rajaongkir.results
                            .firstWhere((kota) => kota.cityId == _kotaAsal,
                                orElse: () => null);
                        if (checkKotaAsal == null) {
                          // bloc.getKotaAsal("36");
                          // print("true");
                          _alert("Kota asal tidak boleh kosong!");
                          return;
                        } else {
                          bloc.getKotaAsal(_kotaAsal.toString());
                        }
                        // bloc.getKotaTujuan("321323221");
                        var checkKotaTujuan = snapshot.rajaongkir.results
                            .firstWhere((kota) => kota.cityId == _kotaTujuan,
                                orElse: () => null);
                        if (checkKotaTujuan == null) {
                          // bloc.getKotaTujuan("152");
                          _alert("Kota tujuan tidak boleh kosong!");
                          return;
                        } else {
                          bloc.getKotaTujuan(_kotaTujuan.toString());
                        }
                        if (_kurirTerpilih == null) {
                          _alert("Kurir tidak boleh kosong!");
                          return;
                        } else {
                          bloc.getKurir(_kurirTerpilih.toString());
                        }
                        if (_berat == null) {
                          bloc.getBerat("1000");
                        } else {
                          bloc.getBerat(_berat);
                        }
                        Route route = MaterialPageRoute(
                            builder: (context) => hlOngkir.ViewOngkir());
                        Navigator.push(context, route);
                        // bloc.cekOngkir();
                        // bloc.getOngkir();
                      });
                    },
                  ),
                ),
                // child: RaisedButton(
                //   child: Text(
                //     "Cek Ongkir!",
                //     style: TextStyle(
                //         fontSize: SizeConfig.blockHorizontal * 4,
                //         color: Colors.white),
                //   ),
                //   elevation: 6.0,
                //   highlightElevation: 20.0,
                //   splashColor: Colors.red,
                //   color: Colors.black,
                //   onPressed: () {
                //     setState(() {
                //       var checkKotaAsal = snapshot.rajaongkir.results
                //           .firstWhere((kota) => kota.cityId == _kotaAsal,
                //               orElse: () => null);
                //       if (checkKotaAsal == null) {
                //         // bloc.getKotaAsal("36");
                //         // print("true");
                //         _alert("Kota asal tidak boleh kosong!");
                //         return;
                //       } else {
                //         bloc.getKotaAsal(_kotaAsal.toString());
                //       }
                //       // bloc.getKotaTujuan("321323221");
                //       var checkKotaTujuan = snapshot.rajaongkir.results
                //           .firstWhere((kota) => kota.cityId == _kotaTujuan,
                //               orElse: () => null);
                //       if (checkKotaTujuan == null) {
                //         // bloc.getKotaTujuan("152");
                //         _alert("Kota tujuan tidak boleh kosong!");
                //         return;
                //       } else {
                //         bloc.getKotaTujuan(_kotaTujuan.toString());
                //       }
                //       if (_kurirTerpilih == null) {
                //         _alert("Kurir tidak boleh kosong!");
                //         return;
                //       } else {
                //         bloc.getKurir(_kurirTerpilih.toString());
                //       }
                //       if (_berat == null) {
                //         bloc.getBerat("1000");
                //       } else {
                //         bloc.getBerat(_berat);
                //       }
                //       Route route = MaterialPageRoute(
                //           builder: (context) => hlOngkir.ViewOngkir());
                //       Navigator.push(context, route);
                //       // bloc.cekOngkir();
                //       // bloc.getOngkir();
                //     });
                //   },
                // ),
              )
            ],
          ),
        )
        // return ListView.builder(
        //   itemCount: snapshot2.rajaongkir.results.length,
        //   itemBuilder: (BuildContext context, int i) {
        //     return ListTile(
        //       title: Text(snapshot2.rajaongkir.results[i].province),
        //     );
        //   },
        // );
        // return Container(
        //   child: Text(snapshot.rajaongkir.results[0].cityName),
        // );
        );
    // }
  }
}
