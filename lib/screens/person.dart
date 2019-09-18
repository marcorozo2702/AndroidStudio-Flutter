import 'package:flutter/material.dart';

class Person extends StatefulWidget {
  final int id;
  final String nome;
  final String telefone;

  //todos os paremetros são obrigatorios bno construtor da classe
  Person({this.id, this.nome, /*@required (usado quando o parametro for obrigatorio)*/ this.telefone});

  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nome),
      ),
      body: Center(child: Column(
        children: <Widget>[
          Text(widget.id.toString()),
          Text(widget.telefone),
        ],
      ),)
      );
  }
}
