library cgi_versoes_helper;

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

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
    final jobsListAPIUrl =
        'https://admrh-versions.herokuapp.com/releasenotes/2';
    final response = await Dio().get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      //List jsonResponse = json.decode(response.body);
      List jsonResponse = response.data;
      return jsonResponse.map((job) => new Versao.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
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
              formatter.format(DateTime.parse(data[index].launchDate)));
        });
  }

  ListTile _tile(
      String title, String subtitle, IconData icon, String launchDate) {
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
        children: <Widget>[
          Text(
            launchDate,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Text(
            subtitle,
          ),
        ],
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
        return CircularProgressIndicator();
      },
    );
  }
}