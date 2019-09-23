import 'package:flutter/material.dart';
import 'package:flutter_app_screens/screens/cadastro.dart';
import 'package:flutter_app_screens/helper/person_helper.dart';
import 'package:flutter_app_screens/screens/person.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PersonHelper helper = PersonHelper();
  List<Person> person = List();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showPersonPage();
        },
        child: Icon(Icons.add),
      ),

      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: person.length,
          itemBuilder: (context, index) {
            return _contactCard(context, index);
          }));
  }

  @override
  void initState() {
    super.initState();
    _getAllPerson();
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        person[index].nome ?? "",
                        style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(person[index].telefone ?? "",
                          style: TextStyle(fontSize: 13.0)),
                    ],
                  ),
                )
              ],
            ),
          )),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }



  void _getAllPerson() {
    helper.getAllPersons().then((list) {
      setState(() {
        person = list;
      });
    });
  }


  void _showPersonPage({Person person}) async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Cadastro(
              person: person,
            )));
    if (recContact != null) {
      if (person != null) {
        await helper.updatePerson(recContact);
      } else {
        await helper.savePerson(recContact);
      }
      _getAllPerson();
    }
  }


  void _showOptions(BuildContext context, int index) {
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
                            Icon(Icons.phone_in_talk, color: Colors.blue),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Ligar',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 20.0),
                                    )
                                  ],
                                ))
                          ],
                        ),
                        onPressed: () {
                          launch("tel:${person[index].telefone}");
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.edit, color: Colors.blue),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Editar',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 20.0),
                                    )
                                  ],
                                ))
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _showPersonPage(person: person[index]);
                        },
                      ),
                    ),
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
                                      'Vizualizar',
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
                            MaterialPageRoute(
                                builder:(context) =>PersonPage(
                                  /*erro*/
                                 id:person[index].id,
                                 nome: person[index].nome,
                                  telefone: person[index].telefone,
                                )
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        color: Colors.blue,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.delete, color: Colors.white),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Deletar',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0),
                                    )
                                  ],
                                ))
                          ],
                        ),
                        onPressed: () {
                          helper.deletePerson(person[index].id);
                          setState(() {
                            person.removeAt(index);
                            Navigator.pop(context);
                          });
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
