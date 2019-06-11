import 'package:cek_ongkir_dan_resi/src/view/getResi.dart';
import 'package:flutter/material.dart';
import 'package:cek_ongkir_dan_resi/src/blocs/cekResiBloc.dart';
import 'package:cek_ongkir_dan_resi/src/models/cekResiModel.dart';

void main() {
  runApp(MaterialApp(
    title: 'Cek Ongkir dan Resi',
    home: LoadResi(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(canvasColor: Color(0xff29332F)),
  ));
}

class LoadResi extends StatefulWidget {
  @override
  _LoadResiState createState() => _LoadResiState();
}

class _LoadResiState extends State<LoadResi> {
  @override
  void initState() {
    super.initState();
    bloc.fetchResi();
    Future.delayed(
        const Duration(seconds: 10),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ViewResi())));
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            // title: Text(
            //   "Cek Ongkir dan Resi",
            //   style: TextStyle(fontFamily: "Serif", fontSize: 20.0, color: Colors.black),
            // ),
            leading: Icon(
              Icons.android,
              color: Colors.white,
            ),
            centerTitle: true,
            title: Text(
              "CEK ONGKIR DAN RESI",
              style: TextStyle(color: Colors.white),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.0, style: BorderStyle.none, color: Colors.black),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(30.0))),
          ),
          body: Container(
            color: Color(0xff29332F),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Sedang menghubungkan ke server", style: TextStyle(color: Colors.white),),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          )),
    );
  }
}
