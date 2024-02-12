import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> createClient(Map userData, String userId) async {
    await FirebaseFirestore.instance
        .collection("Clientes")
        .doc(userId)
        .set(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getClient() async {
    return await FirebaseFirestore.instance.collection("Clientes").snapshots();
  }

  deleteClient(String userId) async {
    return await FirebaseFirestore.instance
        .collection('Clientes')
        .doc(userId)
        .delete();
  }

  getDataUser(String userId) async {
    return await FirebaseFirestore.instance
        .collection('Clientes')
        .doc(userId)
        .get();
    // final ref = referenceDatabase.reference();
    // var currentUser = FirebaseAuth.instance.currentUser;
    // if (currentUser != null) {
    //   print('usuario actual' + currentUser.uid);
    // }
    // await ref
    //     //.child('users/' + currentUser.uid + '/name')
    //     .child('users/' + currentUser.uid)
    //     .get()
    //     .then((value) {

    //   //return value.value;
    // });
    //para la parte de abajo podriamos establecer una clase para poder usar get
    //.then((value) => {print('valorRRr' + value.value['name'])});
  }
}
