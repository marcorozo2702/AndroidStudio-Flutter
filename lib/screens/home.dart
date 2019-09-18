import 'package:flutter/material.dart';
import '../screens/cadastro.dart';
import '../screens/person.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            _itemList(context, 1, 'Marco Antonio rozo', '(49) 99195-0620'),
            _itemList(context, 2, 'Marco Veio', '(49) 99195-0620'),
            _itemList(context, 3, 'Antonio', '(49) 99195-0620'),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cadastro()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _itemList(BuildContext context, int id, String nome, String telefone){
    return GestureDetector(
      child: Card(child: ListTile(title: Text(nome), subtitle: Text(telefone))),
      onTap: (){
        _showOptions(context, id,nome,telefone);
        /*
        Navigator.push(
          context,
         MaterialPageRoute(builder: (context) => Person(id,nome,telefone)),
        );*/
      },
    );
  }

  void _showOptions(BuildContext context, int id, String nome, String telefone) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.person, color: Colors.blue),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Ver',
                                      style: TextStyle(
                                        color: Colors.blue, fontSize: 20.0),
                                    )
                                  ],
                                ))
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Person(id: id, nome: nome, telefone: telefone)));
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.phone_in_talk, color: Colors.blue),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Discar',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 20.0),
                                    )
                                  ],
                                ))
                          ],
                        ),
                        onPressed: () {
                          launch("tel:${telefone}");
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  }
