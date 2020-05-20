library cgi_versoes_helper;

import 'package:cgi_versoes_helper/cgi_notas_versao.page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/versao.dart';

class CGISobrePage extends StatefulWidget {
  @override
  _CGISobrePageState createState() => _CGISobrePageState();
}

class _CGISobrePageState extends State<CGISobrePage> {
  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }  

  Future<String> getUrlPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return 'https://play.google.com/store/apps/details?id=${packageInfo.packageName}';
  }

  int versonify(String versao) {
    int _versonNumber = 0;
    var arr = versao.split('.');
    _versonNumber = _versonNumber + int.parse(arr[0]) * 1000000;
    _versonNumber = _versonNumber + int.parse(arr[1]) * 1000;
    _versonNumber = _versonNumber + int.parse(arr[2]) * 1;
    return _versonNumber;
  }

  Future<bool> getLastVersion() async {
    String versaoAtual = '';

    versaoAtual = await getVersionNumber();

    int _iVersaoAtual = this.versonify(versaoAtual);

    QuerySnapshot snapshot =
        await Firestore.instance.collection("Info").limit(1).getDocuments();

    List<UltimaVersao> ultimaVersao =
      snapshot.documents.map((ult) => new UltimaVersao.fromDocument(ult)).toList();

    var ult = ultimaVersao[0];

    int _iUltimaVersao = this.versonify(ult.lastVersion);

    return !(_iVersaoAtual < _iUltimaVersao);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inspeção de Equipamentos"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: FutureBuilder(
              future: getVersionNumber(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                  Text(
                snapshot.hasData
                    ? "Versão do App: ${snapshot.data}"
                    : "Carregando ...",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                ),
              ),
            ),
          ),
          Center(
            child: FutureBuilder<bool>(
              future: getLastVersion(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
                  snapshot.hasData
                      ? snapshot.data
                          ? Text(
                              "Parabéns seu app está atualizado!",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                              ),
                            )
                          : InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Seu App está desatualizado! Por favor, clique aqui para atualizar.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              onTap: _launchURL,
                            )
                      : Text(
                          "Carregando ...",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              width: 300,
              height: 60,
              child: RaisedButton(
                textColor: Colors.white,
                color: Theme.of(context).buttonColor,
                child: Text(
                  "Notas de Versão",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CGINotasVersaoPage()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    final url = await getUrlPackageName();
   
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
