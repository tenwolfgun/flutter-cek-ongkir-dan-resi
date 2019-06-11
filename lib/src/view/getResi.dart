import 'package:flutter/material.dart';
import 'package:cek_ongkir_dan_resi/src/blocs/cekResiBloc.dart';
import 'package:cek_ongkir_dan_resi/src/models/cekResiModel.dart';

void main() {
  runApp(MaterialApp(
    title: 'Cek Ongkir dan Resi',
    home: ViewResi(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(canvasColor: Colors.transparent),
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
            color: Colors.black,
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 3.0),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            )
          ],
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1.0, style: BorderStyle.solid, color: Colors.black),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(15.0))),
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
        Text("Memeriksa ongkir..."),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        CircularProgressIndicator()
      ],
    ));
  }

  Widget resiView(Resi snapshot) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(2.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
        )),
        elevation: 6.0,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    elevation: 10.0,
                    child: Container(
                      color: Colors.black,
                      padding: EdgeInsets.all(10.0),
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Cek Resi",
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Flexible(
              child: ListView.builder(
                itemCount: snapshot.data.results.length,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
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
            )
          ],
        ),
      ),
    );
  }
}
