import 'package:flutter/material.dart';
import 'package:flutter_app_screens/helper/person_helper.dart';

class Cadastro extends StatefulWidget {
  final Person person;
  Cadastro({this.person});

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _nameController = TextEditingController();
  final _telefoneController = TextEditingController();
  // final _phoneController = TextEditingController();
  final _nameFocus = FocusNode();


  Person _editedContact;
  bool _userEdited = false;


  @override
  void initState() {
    super.initState();
    if (widget.person == null) {
      _editedContact = Person();
    } else {
      _editedContact = Person.fromMap(widget.person.toMap());
      _nameController.text = _editedContact.nome;
      _telefoneController.text = _editedContact.telefone;
      //_phoneController.text = _editedContact.phone;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //remove o botão voltar da APPBAR
        //automaticallyImplyLeading: false,
        title: Text('Contato'),
        centerTitle: true,
      ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.save),
            backgroundColor: Colors.blue,
            onPressed: () {
              if (_editedContact.nome != null &&
                  _editedContact.nome.isNotEmpty) {
                Navigator.pop(context, _editedContact);
              } else {
                FocusScope.of(context).requestFocus(_nameFocus);
              }
            }),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome...'),
              focusNode: _nameFocus,
              onChanged: (text) {
                _userEdited = true;
                setState(() {
                  _editedContact.nome = text;
                });
              },
              controller: _nameController,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Telefone...'),
              onChanged: (text) {
                _userEdited = true;
                _editedContact.telefone = text;
              },
              controller: _telefoneController,
            ),
          ],
        ),
      ),
    );
  }
  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Descartar alterações?'),
              content: Text('Se sair as alterações serão perdidas.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('Sim'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

}






