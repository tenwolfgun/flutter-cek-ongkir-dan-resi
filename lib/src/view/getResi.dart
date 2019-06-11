import 'package:cek_ongkir_dan_resi/src/layout/layout_config.dart';
import 'package:flutter/material.dart';
import 'package:cek_ongkir_dan_resi/src/blocs/cekResiBloc.dart';
import 'package:cek_ongkir_dan_resi/src/models/cekResiModel.dart';

void main() {
  runApp(MaterialApp(
    title: 'Cek Ongkir dan Resi',
    home: ViewResi(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(canvasColor: Color(0xff29332F)),
  ));
}

class ViewResi extends StatefulWidget {
  @override
  _ViewResiState createState() => _ViewResiState();
}

class _ViewResiState extends State<ViewResi> {
  // String _titleText;

  @override
  void initState() {
    super.initState();
    bloc.fetchResi();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 3.0),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
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
          stream: bloc.allResi,
          builder: (context, AsyncSnapshot<Resi> snapshot) {
            if (snapshot.hasData) {
              return resiView(snapshot.data);
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
        Text("Memeriksa ongkir...", style: TextStyle(color: Colors.white)),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        CircularProgressIndicator()
      ],
    ));
  }

  Widget resiView(Resi snapshot) {
    return Container(
      width: SizeConfig.blockHorizontal * 100,
      height: SizeConfig.blockVertical * 90,
      color: Color(0xff29332F),
      padding: EdgeInsets.all(2.0),
      child: Card(
        color: Color(0xff29332F),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(30.0),
        )),
        elevation: 6.0,
        child: ListView.builder(
          itemCount: snapshot.data.results.length,
          itemBuilder: (BuildContext context, int i) {
            return Container(
              child: Column(
                children: <Widget>[
                  Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    elevation: 1.0,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      // leading: Container(
                      //   padding: EdgeInsets.only(right: 12.0),
                      //   decoration: BoxDecoration(
                      //       border: Border(
                      //           right: BorderSide(
                      //               width: 1.0, color: Colors.black))),
                      //   child: Text(
                      //     snapshot.data.results[i].jam,
                      //     style: TextStyle(fontSize: 25.0),
                      //   ),
                      // ),
                      title: Text(
                        snapshot.data.results[i].status,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(snapshot.data.results[i].lokasi),
                      subtitle: Text(
                        snapshot.data.results[i].jam,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
