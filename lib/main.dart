import 'package:cek_ongkir_dan_resi/src/layout/layout_config.dart';
// import 'package:cek_ongkir_dan_resi/src/models/ongkirModel.dart';
import 'package:flutter/material.dart';
import 'package:cek_ongkir_dan_resi/src/view/cekOngkir.dart';
import 'package:cek_ongkir_dan_resi/src/view/cekResi.dart';
import 'package:cek_ongkir_dan_resi/src/view/getOngkir.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:rxdart/rxdart.dart';

// void main() {
//   runApp(MaterialApp(
//     title: 'Cek Ongkir dan Resi',
//     home: MyApp(),
//   ));
// }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cek Ongkir dan Resi',
      home: new HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(canvasColor: Color(0xff29332F)),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;

  final _layoutPage = [CekOngkir(), CekResi(), ViewOngkir()];

  void _onTabItem(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CEK ONGKIR DAN RESI",
          style: TextStyle(
              fontFamily: "roboto", fontSize: 20.0, color: Colors.white),
        ),
        leading: Icon(
          Icons.android,
          color: Colors.white,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            // child: Icon(Icons.airport_shuttle, color: Colors.black,),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0.0, style: BorderStyle.none, color: Colors.black),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(30.0))),
      ),
      body: _layoutPage.elementAt(_selectedTab),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.red,
        backgroundColor: Colors.transparent,
        height: SizeConfig.blockVertical * 8,
        color: Colors.red,
        onTap: _onTabItem,
        items: <Widget>[
          // Column(
          //   children: <Widget>[Icon(Icons.attach_money, size: 40), Text('Cek Ongkir')],
          // ),
          // Column(
          //   children: <Widget>[
          //     Icon(Icons.airport_shuttle, size: 20),
          //     Text('Cek Resi')
          //   ],
          // ),
          Icon(Icons.attach_money, size: 40, color: Colors.white,),
          Icon(Icons.airport_shuttle, size: 40, color: Colors.white)

        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.red,
      //   selectedItemColor: Colors.white,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.attach_money, color: Colors.white,),
      //         title: Text(
      //           "Cek Ongkir",
      //           style: TextStyle(fontSize: SizeConfig.blockHorizontal * 3, color: Colors.white),
      //         )),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.airport_shuttle),
      //         title: Text(
      //           "Cek Resi",
      //           style: TextStyle(fontSize: SizeConfig.blockHorizontal * 3),
      //         )),
      //     //           BottomNavigationBarItem(
      //     //   icon: Icon(Icons.airport_shuttle),
      //     //   title: Text("Cek Resi")
      //     // )
      //   ],
      //   currentIndex: _selectedTab,
      //   onTap: _onTabItem,
      //   type: BottomNavigationBarType.fixed,
      // ),
    );
  }
}
