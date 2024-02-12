import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:opticalapp/src/services/database.dart';
import 'package:opticalapp/src/utilities/utilites.dart';
import 'package:opticalapp/src/widgets/header_widget.dart';
import 'package:opticalapp/src/widgets/toast_widget.dart';
import 'package:random_string/random_string.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({Key key}) : super(key: key);

  @override
  _AddClientPageState createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  double width;
  double height;
  String userId;
  TextEditingController cel_cli = new TextEditingController();
  TextEditingController nombre_cli = new TextEditingController();
  TextEditingController vende_cli = new TextEditingController();
  TextEditingController od_esf_le = new TextEditingController();
  TextEditingController od_cil_le = new TextEditingController();
  TextEditingController od_eje_le = new TextEditingController();
  TextEditingController od_esf_ce = new TextEditingController();
  TextEditingController od_cil_ce = new TextEditingController();
  TextEditingController od_eje_ce = new TextEditingController();
  TextEditingController oi_esf_le = new TextEditingController();
  TextEditingController oi_cil_le = new TextEditingController();
  TextEditingController oi_eje_le = new TextEditingController();
  TextEditingController oi_esf_ce = new TextEditingController();
  TextEditingController oi_cil_ce = new TextEditingController();
  TextEditingController oi_eje_ce = new TextEditingController();
  TextEditingController od_add = new TextEditingController();
  TextEditingController oi_add = new TextEditingController();
  TextEditingController od_dp = new TextEditingController();
  TextEditingController oi_dp = new TextEditingController();
  TextEditingController dp_total = new TextEditingController();
  TextEditingController obs_cli = new TextEditingController();
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;
  String valueChooseGenre;
  String valueChooseOld;
  List listGenre = ['Masculino', 'Femenino', 'Homosexual', 'Lesbiana', 'Otros'];
  List listOld = ['0 - 14 años', '15 - 24 años', '25 - 59 años', '60 a + años'];
  DateTime selectedDate = DateTime.now();
  TextStyle styleGeneral =
      TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'Regular');

  /* @override
  void dispose() {
    cel_cli.dispose();
    nombre_cli.dispose();
    vende_cli.dispose();
    od_esf_le.dispose();
    od_cil_le.dispose();
    od_eje_le.dispose();
    od_esf_ce.dispose();
    od_cil_ce.dispose();
    od_eje_ce.dispose();
    oi_esf_le.dispose();
    oi_cil_le.dispose();
    oi_eje_le.dispose();
    oi_esf_ce.dispose();
    oi_cil_ce.dispose();
    oi_eje_ce.dispose();
    od_add.dispose();
    oi_add.dispose();
    od_dp.dispose();
    oi_dp.dispose();
    dp_total.dispose();
    obs_cli.dispose();
    cel_cli.dispose();
    super.dispose();
  }*/

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  clearSpaces() {
    toast('Limpiando campos ...', Colors.grey[200], Colors.green, 16);
    cel_cli.clear();
    nombre_cli.clear();
    vende_cli.clear();
    od_esf_le.clear();
    od_cil_le.clear();
    od_eje_le.clear();
    od_esf_ce.clear();
    od_cil_ce.clear();
    od_eje_ce.clear();
    oi_esf_le.clear();
    oi_cil_le.clear();
    oi_eje_le.clear();
    oi_esf_ce.clear();
    oi_cil_ce.clear();
    oi_eje_ce.clear();
    od_add.clear();
    oi_add.clear();
    od_dp.clear();
    oi_dp.clear();
    dp_total.clear();
    obs_cli.clear();
    cel_cli.clear();
  }

  addClient() async {
    setState(() {
      _isLoading = true;
    });
    userId = randomAlphaNumeric(16);
    Map<String, String> userMap = {
      "userId": userId,
      "fecha_cli": DateFormat('yyyy-MM-dd').format(selectedDate).toString(),
      "cel_cli": cel_cli.text.toString(),
      "edad_cli": valueChooseOld,
      "genero_cli": valueChooseGenre,
      "nombre_cli": nombre_cli.text.toString(),
      "vende_cli": vende_cli.text.toString(),
      "od_esf_le": od_esf_le.text.toString(),
      "od_cil_le": od_cil_le.text.toString(),
      "od_eje_le": od_eje_le.text.toString(),
      "od_esf_ce": od_esf_ce.text.toString(),
      "od_cil_ce": od_cil_ce.text.toString(),
      "od_eje_ce": od_eje_ce.text.toString(),
      "oi_esf_le": oi_esf_le.text.toString(),
      "oi_cil_le": oi_cil_le.text.toString(),
      "oi_eje_le": oi_eje_le.text.toString(),
      "oi_esf_ce": oi_esf_ce.text.toString(),
      "oi_cil_ce": oi_cil_ce.text.toString(),
      "oi_eje_ce": oi_eje_ce.text.toString(),
      "od_add": od_add.text.toString(),
      "oi_add": oi_add.text.toString(),
      "od_dp": od_dp.text.toString(),
      "oi_dp": oi_dp.text.toString(),
      "dp_total": dp_total.text.toString(),
      "obs_cli": obs_cli.text.toString(),
    };
    await databaseService.createClient(userMap, userId).then((value) {
      setState(() {
        _isLoading = false;
        toast('Tu cliente se ha agregado correctamente :3', Colors.grey[200],
            Colors.green, 16);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              headerWid(
                width,
                height * 0.05,
                'Detalles de Registro',
                Icon(
                  CupertinoIcons.doc_text,
                  size: 35,
                  color: secondaryColor,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Chip(
                    backgroundColor: Colors.transparent,
                    avatar: Icon(CupertinoIcons.calendar_today),
                    label: Text(
                      DateFormat('yyyy-MM-dd').format(selectedDate),
                      style: styleGeneral,
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.calendar_badge_plus),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Cambiar Fecha',
                            style: TextStyle(fontFamily: 'SemiBold'),
                          )
                        ],
                      ))
                ],
              ),
              headerWid(
                width,
                height * 0.05,
                'Datos del Cliente',
                Icon(
                  CupertinoIcons.person_alt,
                  size: 35,
                  color: secondaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton(
                  hint: Text('Genero del Cliente', style: styleGeneral),
                  icon: Icon(CupertinoIcons.chevron_down),
                  iconSize: 14,
                  isExpanded: true,
                  underline: SizedBox(),
                  style: TextStyle(
                      color: Colors.black, fontSize: 13, fontFamily: 'Regular'),
                  value: valueChooseGenre,
                  items: listGenre.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      valueChooseGenre = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton(
                  hint: Text(
                    'Rango de Edad',
                    style: styleGeneral,
                  ),
                  icon: Icon(CupertinoIcons.chevron_down),
                  iconSize: 14,
                  isExpanded: true,
                  underline: SizedBox(),
                  style: TextStyle(
                      color: Colors.black, fontSize: 12, fontFamily: 'Regular'),
                  value: valueChooseOld,
                  items: listOld.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      valueChooseOld = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: TextField(
                  style: styleGeneral,
                  textCapitalization: TextCapitalization.words,
                  controller: nombre_cli,
                  decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.person_crop_square),
                    labelText: 'Nombre Completo del Cliente',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: TextField(
                  style: styleGeneral,
                  textCapitalization: TextCapitalization.words,
                  controller: cel_cli,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.phone),
                    labelText: 'Numero Telefonico del Cliente',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: TextField(
                  style: styleGeneral,
                  textCapitalization: TextCapitalization.words,
                  controller: vende_cli,
                  decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.person_3),
                    labelText: 'Vendedor',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              headerWid(
                width,
                height * 0.05,
                'Medida Ojo Derecho',
                Icon(
                  CupertinoIcons.eye,
                  size: 35,
                  color: secondaryColor,
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(''),
                      Text('ESF'),
                      Text('CIL'),
                      Text('EJE'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lejos ',
                        style: styleGeneral,
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: od_esf_le,
                          keyboardType: TextInputType.phone,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: od_cil_le,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: od_eje_le,
                          keyboardType: TextInputType.phone,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cerca',
                        style: styleGeneral,
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: od_esf_ce,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: od_cil_ce,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: od_eje_ce,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ADD'),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: od_add,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              headerWid(
                width,
                height * 0.05,
                'Medida Ojo Izquierdo',
                Icon(
                  CupertinoIcons.eye,
                  size: 35,
                  color: secondaryColor,
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(''),
                      Text('ESF'),
                      Text('CIL'),
                      Text('EJE'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lejos ',
                        style: styleGeneral,
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: oi_esf_le,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: oi_cil_le,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: oi_eje_le,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cerca',
                        style: styleGeneral,
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: oi_esf_ce,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: oi_cil_ce,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: oi_eje_ce,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ADD'),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: oi_add,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              headerWid(
                width,
                height * 0.05,
                'DP Ajustes',
                Icon(
                  CupertinoIcons.gear_alt,
                  size: 35,
                  color: secondaryColor,
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(''),
                      Text('DER'),
                      Text('IZQ'),
                      Text('TOTAL'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('DP'),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: od_dp,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: oi_dp,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          controller: dp_total,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              headerWid(
                width,
                height * 0.05,
                'Observaciones',
                Icon(
                  CupertinoIcons.text_bubble,
                  size: 35,
                  color: secondaryColor,
                ),
              ),
              TextField(
                controller: obs_cli,
                maxLines: 10,
                style: styleGeneral,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    labelText: 'Observaciones', border: OutlineInputBorder()),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          clearSpaces();
                        },
                        child: Text(
                          'Limpiar Formulario',
                          style: TextStyle(fontFamily: 'Semibold'),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        onPressed: () {
                          addClient();
                        },
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.check_mark),
                            Text(
                              'Guardar Cliente',
                              style: TextStyle(fontFamily: 'Semibold'),
                            )
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
