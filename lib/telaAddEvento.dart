import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:image_picker/image_picker.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:sextou_app/telaInicial.dart';

class newAddress {
  String address;
  double latitude;
  double longitude;
  newAddress(String address , double latitude, double longitude) {
    this.address = address;
    this.latitude = latitude;
    this.longitude = longitude;
  }
}

class Evento {
  String name;
  String sobre;
  newAddress address1;
  newAddress address2;
  DateTime data1;
  DateTime data2;
  DateTime dataVotacao;
  TimeOfDay hora1;
  TimeOfDay hora2;
  bool privacidade;
  Evento(String nome, newAddress address1, newAddress address2, DateTime data1,
      DateTime data2, DateTime dataVotacao , TimeOfDay hora1, TimeOfDay hora2, String description, bool privacidade ) {
    this.name = nome;
    this.address1 = address1;
    this.address2 = address2;
    this.data1 = data1;
    this.data2 = data2;
    this.dataVotacao = dataVotacao;
    this.hora1 = hora1;
    this.hora2 = hora2;
    this.sobre = description;
    this.dataVotacao = dataVotacao;
    this.privacidade = privacidade;
  }
}


class addEventos extends StatefulWidget{
  @override
  final String id;
  const addEventos({Key key, this.id}) : super(key: key);
  _addEventos createState() => _addEventos();
}
Future<bool> postEvento(Evento evento, String myId) async {
  var response = await http.post(
      Uri.parse("https://8a9bacc5a169.ngrok.io/api/v1/evento"),
      body: {
        'name' : "${evento.name}",
        'sobre' : "${evento.sobre}",
        'address1' : "${evento.address1.address}",
        'latitude1' : "${evento.address1.latitude}",
        'longitude1' : "${evento.address1.longitude}",
        'address2' : "${evento.address2.address}",
        'latitude2' : "${evento.address2.latitude}",
        'longitude2' : "${evento.address2.longitude}",
        'data1' : "${evento.data1.toString().replaceAll(' 00:00:00.000', '')}",
        'data2' : "${evento.data2.toString().replaceAll(' 00:00:00.000', '')}",
        'dataVotacao' : "${evento.dataVotacao}",
        'hora1' : " ${evento.hora1.toString().replaceAll('TimeOfDay(', '')
            .replaceAll(')', '')}",
        'hora2' : "${evento.hora2.toString().replaceAll('TimeOfDay(', '')
            .replaceAll(')', '')}",
        'publico' : "${evento.privacidade}"
      });
  print(response.statusCode);
  if (response.statusCode == 200) {
    var addEvento = await http.post(
        Uri.parse("https://8a9bacc5a169.ngrok.io/api/v1/add-meu-evento"),
        body: {
          'id' : "${myId}",
          'idEvento' : "${response.body}"
        });
    return true;
  } else {
    print(response.body);
    throw Exception(json.decode(response.body)['mesage']);
  }
}
// ignore: camel_case_types
class _addEventos extends State<addEventos> {
  final description = TextEditingController();
  final eventName = TextEditingController();
  File imagem;
  File imagemTemporaria;
  newAddress address1;
  newAddress address2;
  DateTime data1;
  DateTime data2;
  DateTime dataVotacao;
  TimeOfDay hora1;
  TimeOfDay hora2;
  bool privacidade = false;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _valueChanged(bool value) => setState(() => privacidade = value);

  @override
  void initState(){
    super.initState();
      data1 = DateTime.now();
      hora1 = TimeOfDay.now();
  }
  void pegarImagemGaleria() async {
    // ignore: deprecated_member_use
    imagemTemporaria = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagem = imagemTemporaria;
    });
}
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
                  child : Text("Criar evento", style: TextStyle(fontSize: 25,
                      color: Colors.white),),
                )
              ]
          ),
        ),
      ),
        body : ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: TextFormField(
                controller: eventName,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                  labelStyle: TextStyle(color: Colors.redAccent),
                    labelText: 'Nome do Evento *'
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
              child: Center(
                child: Text("Opções de endereço", style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.normal,
                  fontSize: 12,
                )),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: SearchMapPlaceWidget(
                apiKey :'AIzaSyCi7Bm7jDmmY9APxb-p25B7mFZydRbUsFc',
                hasClearButton: true,
                placeholder: "1º endereço *",
                onSelected: (Place place) async {
                  Geolocation geolocation = await place.geolocation;
                  String cordernadas = geolocation.coordinates.toString()
                      .replaceAll('LatLng(', '').replaceAll(')', '');
                  var cordernadasList = cordernadas.split(",");
                  address1 = newAddress(place.description.toString(),
                      double.parse(cordernadasList[0]),
                      double.parse(cordernadasList[1]));
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: SearchMapPlaceWidget(
                apiKey :'AIzaSyCi7Bm7jDmmY9APxb-p25B7mFZydRbUsFc',
                hasClearButton: true,
                placeholder: "2º endereço",
                onSelected: (Place place) async {
                  Geolocation geolocation = await place.geolocation;
                  String cordernadas = geolocation.coordinates.toString()
                      .replaceAll('LatLng(', '').replaceAll(')', '');
                  var cordernadasList = cordernadas.split(",");
                  address2 = newAddress(place.description.toString(),
                      double.parse(cordernadasList[0]),
                      double.parse(cordernadasList[1]));
                },
              ),
            ),SizedBox(
              height: 5,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Container(
                  height: 135.0,
                  width: 195.0,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        Text("Opções de datas", style: TextStyle(fontSize: 12,
                            color: Colors.black)),
                        ListTile(
                          title: Text("* ${_dataFormat(data1)}",
                            style: TextStyle(fontSize: 12,
                                color: Colors.redAccent),),
                          trailing: Icon(Icons.calendar_today_outlined,
                              size: 15.0),
                          onTap: _pickDate,
                        ),
                        ListTile(
                          title: Text("${_dataFormat(data2)}",
                              style: TextStyle(fontSize: 12,
                                  color: Colors.redAccent)),
                          trailing: Icon(Icons.calendar_today_outlined,
                              size: 15.0),
                          onTap: _pickDate2,
                        )
                      ],
                    ),
                  ),
                ),
                  Container(
                    height: 135.0,
                    width: 175.0,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Text("Opções de horas", style: TextStyle(
                              fontSize: 12, color: Colors.black)),
                          ListTile(
                            title: Text("* ${_timeFormat(hora1)}",
                                style: TextStyle(fontSize: 12,
                                    color: Colors.redAccent)),
                            trailing: Icon(Icons.access_time, size: 20.0),
                            onTap: _pickTime1,
                          ),
                          ListTile(
                            title: Text("${_timeFormat(hora2)}",
                                style: TextStyle(fontSize: 12,
                                    color: Colors.redAccent)),
                            trailing: Icon(Icons.access_time,size: 20.0),
                            onTap: _pickTime2,
                          )
                        ],
                      ),
                    ),
                  ),
              ],
              )
            ),
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 85.0,
                      width: 195.0,
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Text("Encerrar votação",style: TextStyle(
                                fontSize: 12, color: Colors.black)),
                            ListTile(
                              title: Text("* ${_dataFormat(dataVotacao)}",
                                style: TextStyle(fontSize: 12,
                                    color: Colors.redAccent),),
                              trailing: Icon(Icons.calendar_today_outlined,
                                  size: 15.0),
                              onTap: _pickDate3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 85.0,
                      width: 175.0,
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Text("Privacidade",style: TextStyle(fontSize: 12,
                                color: Colors.black)),
                            ListTile(
                              title: Text("Publico"),
                              leading: CircularCheckBox(value: this.privacidade,
                                  checkColor: Colors.white  ,
                                  activeColor: Colors.green,
                                  inactiveColor: Colors.redAccent,
                                  disabledColor: Colors.grey ,
                                  onChanged: (val) => this.setState(() {
                                    this.privacidade= !this.privacidade ;}) ),
                              onTap: ()=> this.setState(() {
                                this.privacidade= !this.privacidade ;}),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ),

            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
              child: Text("Adicionar imagem *", style  : TextStyle(
                  color: Colors.redAccent) )
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
              child: Center(
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black12)
                    ),
                    color: Colors.grey,
                    child: Container(
                      child: Text("Selecionar imagem", style: TextStyle(
                          color: Colors.white),),
                    ),
                    onPressed : (){
                      pegarImagemGaleria();
                    }),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 20.0),
              child: TextFormField(
                controller: description,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                    labelStyle: TextStyle(color: Colors.redAccent),
                    labelText: 'Descrição do Evento *'
                ),
                ),
            ),
            // ignore: deprecated_member_use
            Center(
              child: RaisedButton(
                  color: Colors.green,
                  child: Container(
                    child: Text("      Criar evento      ", style: TextStyle(
                      color: Colors.white, ),),
                  ),
                  onPressed : () async {
                    // ignore: unrelated_type_equality_checks
                    if (address1 == null || eventName == "" ||
                        imagem == null || description.text == null){
                      showAlertDialog1(context);
                    }else {
                      Evento evento = new Evento(
                          eventName.text, address1, address2, data1, data2,
                          dataVotacao, hora1, hora2, description.text ,
                          privacidade);
                      try {
                        await postEvento(evento, widget.id);
                        Navigator.of(context).pop();
                      } catch (error) {
                        print("erro aqui");
                        print(error);
                      }
                    }
                  }),
            )
          ],
        ),
    );
  }
  String _dataFormat(DateTime data)  {
    if (data != null){
      return "Data: ${data.day}/${data.month}/${data.year}";
    }else{
      return "Data: __/__/___";
    }
  }
  String _timeFormat(TimeOfDay time)  {
    if (time != null){
      return "Hora: ${
          time.toString().replaceAll('TimeOfDay(', '').replaceAll(')', '')}";
    }else{
      return "Hora: __:__";
    }
  }
   _pickDate() async {
    DateTime data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (data != null){
      setState(() {
        data1 = data;
      });
    }
  }
  _pickDate2() async {
    DateTime data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (data != null){
      setState(() {
        data2 = data;
      });
    }
  }
  _pickDate3() async {
    DateTime data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (data != null){
      setState(() {
        dataVotacao = data;
      });
    }
  }
  _pickTime1() async {
    TimeOfDay _time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (_time != null){
      setState(() {
        hora1 = _time;
        print(_time.toString());
      });
    }
  }
  _pickTime2() async {
    TimeOfDay _time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (_time != null){
      setState(() {
        hora2 = _time;
      });
    }
  }
  showAlertDialog1(BuildContext context)
  {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Informações incompletas"),
      content: Text("Por favor preencar todos os campos com * "),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}