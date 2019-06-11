import 'package:cek_ongkir_dan_resi/src/view/getResi.dart';
import 'package:flutter/material.dart';
import 'package:cek_ongkir_dan_resi/src/blocs/cekResiBloc.dart';
import 'package:cek_ongkir_dan_resi/src/models/cekResiModel.dart';

void main() {
  runApp(MaterialApp(
    title: 'Cek Ongkir dan Resi',
    home: LoadResi(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(canvasColor: Colors.white),
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
    return Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Sedang menghubungkan ke server"),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            CircularProgressIndicator(),
          ],
      ),
    ),
        ));
  }
}
