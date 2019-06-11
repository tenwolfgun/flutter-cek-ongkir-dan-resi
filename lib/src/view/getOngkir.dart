import 'package:cek_ongkir_dan_resi/src/layout/layout_config.dart';
import 'package:flutter/material.dart';
import 'package:cek_ongkir_dan_resi/src/blocs/cityBloc.dart';
import 'package:cek_ongkir_dan_resi/src/models/ongkirModel.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

void main() {
  runApp(MaterialApp(
    title: 'Cek Ongkir dan Resi',
    home: ViewOngkir(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(canvasColor: Color(0xff29332F)),
  ));
}

class ViewOngkir extends StatefulWidget {
  @override
  _ViewOngkirState createState() => _ViewOngkirState();
}

class _ViewOngkirState extends State<ViewOngkir> {
  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: 12345678.9012345);

  String _titleText;

  @override
  void initState() {
    super.initState();
    bloc.cekOngkir();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   "Cek Ongkir dan Resi",
        //   style: TextStyle(fontFamily: "Serif", fontSize: 20.0, color: Colors.black),
        // ),
        leading: Icon(
          Icons.android,
          color: Colors.white,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.redAccent,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
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
      resizeToAvoidBottomPadding: false,
      body: StreamBuilder(
        stream: bloc.allOngkir,
        builder: (context, AsyncSnapshot<Ongkir> snapshot) {
          if (snapshot.hasData) {
            return ongkirView(snapshot.data);
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Memeriksa ongkir...",
          style: TextStyle(color: Colors.white),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        CircularProgressIndicator()
      ],
    ));
  }

  Widget ongkirView(Ongkir snapshot) {
    if (snapshot.rajaongkir.status.code.toString() == "400") {
      _titleText = snapshot.rajaongkir.status.description;
    } else {
      _titleText = snapshot.rajaongkir.results[0].name;
    }
    // if (snapshot.rajaongkir.results.length == null) {
    //   print("gagal");
    //   bloc.cekOngkir();
    // }
    return Container(
      color: Color(0xff29332F),
      padding: EdgeInsets.all(2.0),
      child: Card(
        color: Color(0xff29332F),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(30.0),
        )),
        elevation: 6.0,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    shape: Border(
                        top: BorderSide(color: Colors.white24, width: 1.0),
                        bottom: BorderSide(color: Colors.white24, width: 1.0)),
                    elevation: 10.0,
                    child: Container(
                      color: Color(0xff29332F),
                      padding: EdgeInsets.all(10.0),
                      height: 50.0,
                      child: Center(
                        child: Text(
                          _titleText,
                          style: TextStyle(
                              fontSize: SizeConfig.blockHorizontal * 4.5,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Flexible(
              child: ListView.builder(
                itemCount: snapshot.rajaongkir.results[0].costs.length,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Card(
                          // shape: RoundedRectangleBorder(
                          //   side: BorderSide(width: 1.0, color: Colors.redAccent)
                          // ),
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          elevation: 1.0,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            // leading: Container(
                            //   padding: EdgeInsets.only(right: 12.0),
                            //   decoration: new BoxDecoration(
                            //       border: new Border(
                            //           right: new BorderSide(
                            //               width: 1.0, color: Colors.black))),
                            //   child: Text(
                            //     snapshot.rajaongkir.results[0].costs[i].service,
                            //     style: TextStyle(fontSize: 30.0),
                            //   ),
                            // ),
                            title: Text(
                              snapshot
                                  .rajaongkir.results[0].costs[i].description,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.blockHorizontal * 4),
                            ),
                            subtitle: Column(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                ),
                                Text("${snapshot.rajaongkir.results[0].costs[i]
                                    .cost[0].etd} Hari", style:  TextStyle(fontSize: SizeConfig.blockHorizontal * 3),),
                                Text("Berat: ${snapshot.rajaongkir.query.weight} Gram".toString(), style:  TextStyle(fontSize: SizeConfig.blockHorizontal * 3)),
                                Text(
                                    "${snapshot.rajaongkir.originDetails.cityName} - ${snapshot.rajaongkir.destinationDetails.cityName}", style:  TextStyle(fontSize: SizeConfig.blockHorizontal * 3)),
                              ],
                            ),
                            trailing: Text(fmf
                                .copyWith(
                                    amount: snapshot.rajaongkir.results[0]
                                        .costs[i].cost[0].value
                                        .toDouble(),
                                    symbol: 'Rp',
                                    symbolAndNumberSeparator: ' ',
                                    thousandSeparator: '.',
                                    decimalSeparator: ',')
                                .output
                                .symbolOnLeft, style:  TextStyle(fontSize: SizeConfig.blockHorizontal * 4, fontStyle: FontStyle.italic)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // child: Column(
      //   children: <Widget>[
      //     Container(
      //       padding: EdgeInsets.all(10.0),
      //       decoration: BoxDecoration(shape: BoxShape.rectangle),
      //       child: Center(
      //         child: Text(
      //           _titleText,
      //           // snapshot.rajaongkir.results[0].name,
      //           style: TextStyle(fontSize: 30.0),
      //         ),
      //       ),
      //     ),
      //     Flexible(
      //       child: ListView.builder(
      //         itemCount: snapshot.rajaongkir.results[0].costs.length,
      //         itemBuilder: (BuildContext context, int i) {
      //           return Container(
      //             child: Column(
      //               children: <Widget>[
      //                 Card(
      //                   child: ListTile(
      //                     title: Text(
      //                         snapshot.rajaongkir.results[0].costs[i].service),
      //                     subtitle: Text(fmf
      //                         .copyWith(
      //                           amount: snapshot.rajaongkir.results[0].costs[i]
      //                               .cost[0].value
      //                               .toDouble(),
      //                           symbol: 'IDR',
      //                           symbolAndNumberSeparator: ' ',
      //                         )
      //                         .output
      //                         .symbolOnLeft),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
