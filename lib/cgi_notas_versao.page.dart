library cgi_versoes_helper;

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/versao.dart';

class CGINotasVersaoPage extends StatefulWidget {
  @override
  _CGINotasVersaoPageState createState() => _CGINotasVersaoPageState();
}

class _CGINotasVersaoPageState extends State<CGINotasVersaoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notas de Versão"),
      ),
      body: _buildExtintoresListView(),
    );
  }

  Future<List<Versao>> _fetchVersoes() async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection("Versoes")
        .orderBy("major", descending: true)
        .orderBy("minor", descending: true)
        .orderBy("patch", descending: true)
        .getDocuments();

    List<Versao> versoes =
        snapshot.documents.map((ver) => new Versao.fromDocument(ver)).toList();

    return versoes;
  }

  ListView _jobsListView(data) {
    var formatter = new DateFormat('dd/MM/yyyy');

    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
            ),
        padding: EdgeInsets.only(top: 8),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(
              '${data[index].major}.${data[index].minor}.${data[index].patch}',
              data[index].description,
              Icons.update,
              formatter.format(DateTime.parse(data[index].launchDate)),
              data[index].notes);
        });
  }

  ListTile _tile(String title, String subtitle, IconData icon,
      String launchDate, List<String> notes) {
    List<Widget> widgets = [
          Text(
            launchDate,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ] +
        notes
            .map((name) => new Text(String.fromCharCode(0x2022) + " " + name))
            .toList();

    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
      leading: Icon(
        icon,
        color: Colors.blue[500],
      ),
    );
  }

  _buildExtintoresListView() {
    return FutureBuilder<List<Versao>>(
      future: _fetchVersoes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Versao> data = snapshot.data;

          return _jobsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 10.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              Theme.of(context).primaryColor,
            ),
          ),
        );
      },
    );
  }
}
