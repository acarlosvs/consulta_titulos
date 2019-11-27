import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/titulo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Titulo> titulos = new List<Titulo>();

  Future<List<Titulo>> buscarTitulos() async {
    String url = "http://10.121.2.212:9878/titulospagar";

    http.Response response  = await http.get(url);

    List<dynamic> result = json.decode(response.body);

    for (dynamic item in result) {
      Titulo titulo = new Titulo(sequencial: item["fn06_SEQU"].toString(), numeroTitulo: item["fn06_NUME_TITULO"].toString(), valorDevedor: item["fn06_VALOR_DEVEDOR"].toString(), status: item["fn06_STATUS"].toString(), observacao: item["fn06_OBSE"].toString());

      titulos.add(titulo);
    }

    return titulos;
  }

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de  Titulos"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<Titulo>>(
                future: buscarTitulos(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.active: 
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return AlertDialog(
                          title: Text("Erro"),
                          titlePadding: EdgeInsets.all(10),
                          content: Text("Erro ao conectar ao servidor."),
                          contentPadding: EdgeInsets.all(40),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Fechar"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      } else {
                        return Container(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, indice) {
                              List<Titulo> listaTitulos = snapshot.data;
                              Titulo titulo = listaTitulos[indice];

                              return ListTile(
                                title: Text(titulo.sequencial),
                                subtitle: Text(titulo.numeroTitulo),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Detalhes do titulo " + titulo.numeroTitulo),
                                        titlePadding: EdgeInsets.all(20),
                                        content: Text("Valor Devedor: R\$ " + titulo.valorDevedor),
                                        contentPadding: EdgeInsets.all(50),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Fechar"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    }
                                  );
                                },
                              );
                            },
                          ),
                        );
                      }
                  }
                  return Container();
                },
              ),
            ),
            // Row(
            //   children: <Widget>[
            //     RaisedButton(
            //       child: Text("Atualizar"),
            //       onPressed: buscarTitulos,
            //     ),
            //     RaisedButton(
            //       child: Text("Inserir"),
            //       onPressed: buscarTitulos,
            //     ),
            //     RaisedButton(
            //       child: Text("Deletar"),
            //       onPressed: buscarTitulos,
            //     ),
            //   ],
            // )
          ],
        ),
      )
    );
  }
}

