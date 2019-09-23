import 'package:flutter/material.dart';
import 'package:flutter_app_screens/helper/person_helper.dart';


class PersonPage extends StatefulWidget {
  final int id;
  final String nome;
  final String telefone;

  //todos os paremetros são obrigatorios bno construtor da classe ------ @required (usado quando o parametro for obrigatorio)
  PersonPage({this.id, this.nome, this.telefone});

  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nome),
        centerTitle: true,
      ),
        body: Center(child: Column(
          children: <Widget>[
            Text(widget.id.toString(),
            style: TextStyle(color: Colors.blue, fontSize: 20.0),),
            Text(widget.telefone,
              style: TextStyle(color: Colors.blue, fontSize: 20.0),),
          ],
        ),)
    );
  }
}
