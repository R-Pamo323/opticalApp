import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:opticalapp/src/pages/filecli_page.dart';
import 'package:opticalapp/src/services/database.dart';
import 'package:opticalapp/src/utilities/utilites.dart';
import 'package:opticalapp/src/widgets/toast_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  double width;
  double height;
  Stream clientStream;
  TextEditingController searchController = new TextEditingController();
  String searchResult = '';
  DatabaseService databaseService = new DatabaseService();

  @override
  void initState() {
    super.initState();
    databaseService.getClient().then((value) {
      setState(() {
        clientStream = value;
      });
    });
  }

  deleteClient(String userId) async {
    await databaseService.deleteClient(userId);
    toast('Cliente Eliminado', Colors.white, Colors.black, 13);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: clientList(),
    );
  }

  Widget clientList() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchController,
              style: TextStyle(fontFamily: 'Regular', fontSize: 14),
              onChanged: (value) {
                setState(() {
                  searchResult = value;
                });
              },
              decoration: InputDecoration(
                suffixIcon: searchController.text == ""
                    ? Icon(
                        Icons.search,
                        color: Color(0xff0854a0),
                      )
                    : IconButton(
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            searchResult = '';
                          });
                        },
                        icon: Icon(
                          Icons.clear,
                        ),
                      ),
                labelText: 'Buscar',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
              stream: clientStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Container(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator()));
                }
                //print('length = ${snapshot.data.docs.length}');
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, index) {
                    if (snapshot.data.docs[index]
                        .data()["nombre_cli"]
                        .toLowerCase()
                        .contains(searchResult)) {
                      return GestureDetector(
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.SCALE,
                            dialogType: DialogType.INFO_REVERSED,
                            body: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Que accion quieres realizar?',
                                    style: TextStyle(fontFamily: 'Regular'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FileClientPage(snapshot
                                                      .data.docs[index]
                                                      .data()["userId"])));
                                    },
                                    child: Text('Ver ficha Cliente'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      deleteClient(snapshot.data.docs[index]
                                          .data()["userId"]);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Eliminar cliente'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancelar'),
                                  ),
                                ],
                              ),
                            ),
                            title: 'This is Ignored',
                            desc: 'This is also Ignored',
                          )..show();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          margin: EdgeInsets.only(top: 10),
                          width: width,
                          height: height * .15,
                          child: Card(
                              shadowColor: lightblue,
                              elevation: 10,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          CupertinoIcons.person_crop_square,
                                          color: primaryColor,
                                          size: width * .09,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: width * 0.6,
                                          child: Text(
                                            '${snapshot.data.docs[index].data()["nombre_cli"]}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: 'SemiBold',
                                                fontSize: 14,
                                                color: secondaryColor),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.phone,
                                              size: 13,
                                            ),
                                            Text(
                                              '${snapshot.data.docs[index].data()["cel_cli"] == null ? '-' : snapshot.data.docs[index].data()["cel_cli"]}',
                                              style: TextStyle(
                                                  fontFamily: 'Regular',
                                                  fontSize: 13.5,
                                                  color: secondaryColor),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${snapshot.data.docs[index].data()["edad_cli"]}',
                                          style: TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 13.5,
                                              color: secondaryColor),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.calendar,
                                              size: 13,
                                            ),
                                            Text(
                                              '${snapshot.data.docs[index].data()["fecha_cli"]}',
                                              style: TextStyle(
                                                  fontFamily: 'Regular',
                                                  fontSize: 13.5,
                                                  color: secondaryColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      width: 2,
                                    )),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height: height * .095,
                                      width: 3,
                                    )
                                  ],
                                ),
                              )),
                        ),
                      );
                    } else {
                      return Visibility(
                        visible: false,
                        child: Text(
                          'no match',
                          style: TextStyle(fontSize: 4.0),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
