import 'package:cek_ongkir_dan_resi/src/layout/layout_config.dart';
import 'package:cek_ongkir_dan_resi/src/view/waiting_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cek_ongkir_dan_resi/src/blocs/cekResiBloc.dart';

class CekResi extends StatefulWidget {
  @override
  _CekResiState createState() => _CekResiState();
}

class _CekResiState extends State<CekResi> {
  String _nomorResi;
  String _kurirTerpilih;

  List<Map> _daftarKurir = [
    {"id": "jne", "name": "JNE"},
    {"id": "tiki", "name": "TIKI"},
    {"id": "pos-indonesia", "name": "POS Indonesia"},
    {"id": "lion-parcel", "name": "Lion Parcel"},
    {"id": "wahana", "name": "Wahana"}
  ];

  // void initState() {
  //   super.initState();
  //   bloc.fetchResi();
  // }

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
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Container(
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
                Row(
                  children: <Widget>[
                    // Expanded(
                    //   //  flex: 10,
                    //   child: Card(
                    //     elevation: 10.0,
                    //     child: Container(
                    //       color: Colors.black,
                    //       padding: EdgeInsets.all(10.0),
                    //       height: 50.0,
                    //       child: Center(
                    //         child: Text(
                    //           "Cek Resi",
                    //           style:
                    //               TextStyle(fontSize: 25.0, color: Colors.white),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          primaryColor: Colors.white, accentColor: Colors.red),
                      child: TextField(
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.redAccent)),
                            labelText: "Nomor Resi",
                            labelStyle:
                                TextStyle(fontSize: 20.0, color: Colors.white)),
                        onChanged: (value) {
                          setState(() {
                            _nomorResi = value;
                          });
                        },
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        primaryColor: Colors.white, accentColor: Colors.red),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent)),
                          labelText: "Pilih Kurir",
                          labelStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white)),
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: SizeConfig.blockVertical * 5),
                    child: Theme(
                      data:
                          Theme.of(context).copyWith(primaryColor: Colors.red),
                      child: OutlineButton(
                        splashColor: Colors.red,
                        color: Colors.transparent,
                        borderSide:
                            BorderSide(color: Colors.white70, width: 10.0),
                        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.search, color: Colors.red),
                            Text("CEK RESI!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.blockHorizontal * 4))
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            bloc.getNomorResi(_nomorResi).toString();
                            bloc.getKurir(_kurirTerpilih).toString();
                            Route route = MaterialPageRoute(
                                builder: (context) => LoadResi());
                            Navigator.push(context, route);
                          });
                        },
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
