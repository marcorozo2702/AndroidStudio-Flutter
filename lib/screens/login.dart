import 'package:flutter/material.dart';
import 'package:flutter_app_screens/helper/usuario_helper.dart';
import 'package:flutter_app_screens/screens/cadastroUser.dart';
import 'package:flutter_app_screens/screens/home.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserHelper helper = UserHelper();
  List<User> user = List();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black45,
            title: Text('Login'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('images/user.png')),
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "E-mail"),
                 // controller: _email,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Senha"),
                  keyboardType: TextInputType.visiblePassword,
                 // controller: _senha,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 10),
                  child: Container(
                    width: 220.0,
                    height: 40.0,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()));},
                      color: Colors.black45,
                      child: Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Container(
                    width: 220.0,
                    height: 40.0,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CadastroUser()));},
                      color: Colors.white70,
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.black87, fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  }
