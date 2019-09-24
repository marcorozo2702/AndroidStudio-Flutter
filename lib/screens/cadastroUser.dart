import 'package:flutter/material.dart';
import 'package:flutter_app_screens/helper/usuario_helper.dart';

class CadastroUser extends StatefulWidget {
  final User user;
  CadastroUser({this.user});

  @override
  _CadastroUserState createState() => _CadastroUserState();
}

class _CadastroUserState extends State<CadastroUser> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _nameFocus = FocusNode();

  User _editedContact;
  bool _userEdited = false;


  @override
  void initState() {
    super.initState();
    if (widget.user == null) {
      _editedContact = User();
    } else {
      _editedContact = User.fromMap(widget.user.toMap());
      _emailController.text = _editedContact.email;
      _passwordController.text = _editedContact.password;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //remove o botão voltar da APPBAR
        //automaticallyImplyLeading: false,
        title: Text('Cadastro de Usuario'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              focusNode: _nameFocus,
              onChanged: (text) {
                _userEdited = true;
                setState(() {
                  _editedContact.email = text;
                });
              },
              controller: _emailController,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(labelText: 'Senha'),
              onChanged: (text) {
                _userEdited = true;
                _editedContact.password = text;
              },
              controller: _passwordController,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Container(
                width: 220.0,
                height: 40.0,
                child: RaisedButton(
                  onPressed: () {
                    if (_editedContact.email != null &&
                        _editedContact.email.isNotEmpty) {
                      Navigator.pop(context, _editedContact);
                    } else {
                      FocusScope.of(context).requestFocus(_nameFocus);
                    }
                  },
                  color: Colors.white70,
                  child: Text(
                    "Salvar",
                    style: TextStyle(color: Colors.black87, fontSize: 20.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

