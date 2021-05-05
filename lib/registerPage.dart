import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'loginPage.dart';

Future<bool> createUser(String email, String password, String name) async {
  var response = await http.post(
      Uri.parse("https://8a9bacc5a169.ngrok.io/api/v1/user"),
      body: {'name': name, 'email' : email , 'senha': password});
  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception(json.decode(response.body)['mesage']);
  }

  // otem os dados JSON
  //data = json.decode(response.body)['results'];
}
class RegisterPage extends StatefulWidget{
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  String name = '';
  String email = '';
  String password = '';
  String passwordComfirm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        //Here is the preferred height.
        preferredSize: Size.fromHeight(120.0),
        child: SafeArea(
          child : ListView(
              children: <Widget>[
                Container(
                  child: AppBar(
                    title: Text(''),
                    centerTitle: true,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30.0, 30.0, 0.0, 10.0),
                  color: Colors.red,
                  child : Text("Registrar", style: TextStyle(fontSize: 25,
                      color: Colors.white),),
                )
              ]
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            TextFormField(
              onChanged: (text) {
                setState(() {
                  name = text;
                });
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              onChanged: (text) {
                setState(() {
                  email = text;
                });
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              onChanged: (text) {
                setState(() {
                  password = text;
                });
              },
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              onChanged: (text) {
                setState(() {
                  passwordComfirm = text;
                });
              },
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Confirmar senha",
                labelStyle: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text("Já possui uma conta?"),
                textColor: Colors.redAccent,
                onPressed: () {
                  //ADICIONAR AQUI O METODO DO BOTAO "ESQUECEU A SENHA"
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  )),
              child: SizedBox.expand(
                child: FlatButton(
                  onPressed: () async {
                    try {
                      await createUser(email, password, name);
                      Navigator.of(context).pop();
                    } catch (error) {
                      print(error);
                    }
                  },
                  child: Text(
                    "Registrar",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
