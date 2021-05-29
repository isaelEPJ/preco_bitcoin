import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

double _priceDolarBitcoin = 0.0;
double _priceRealBitcoin = 0.0;
double _priceEuroBitcoin = 0.0;
double _priceDolar = 0.0;
double _priceReal = 0.0;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _recuperaPreco();
  }

  Future<Map> _recuperaPreco() async {
    String url = 'https://blockchain.info/pt/ticker';
    http.Response response = await http.get(Uri.parse(url));
    return json.decode(response.body) ?? [];

    // setState(() {
    //   _priceRealBitcoin = result['BRL']['last'];
    //   _priceDolarBitcoin = result['USD']['last'];
    //   _priceEuroBitcoin = result['EUR']['last'];
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/bitcoin.png'),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Preço do bitcoin Hoje',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          onPrimary: Colors.white,
                        ),
                        child: Text('Atualizar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        onPressed: _recuperaPreco,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Bitcoin em Real:  ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      FutureBuilder(
                        future: _recuperaPreco(),
                        builder: (context, snapshot) {
                          // double valor = snapshot.data["BRL"]["buy"];
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            Scaffold.of(context)
                                .showBottomSheet((context) => Text('erro'));
                          }
                          return Text(
                            'R\$ ${_priceRealBitcoin.toStringAsFixed(2).replaceAll('.', ',')}',
                            // 'R\$ ${snapshot.data["BRL"]["buy"].toStringAsFixed(2).replaceAll('.', ',')}',
                            // snapshot.data["BRL"].toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Bitcoin em Dolar:  ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$ ${_priceDolarBitcoin.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Bitcoin em Euro:  ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$ ${_priceEuroBitcoin.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
