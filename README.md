# cgi_versoes_helper

Pacote para controle de Versão dos Aplicativos da CGI Software.

## Instalação.

Adicione o cgi_versoes_helper: 1.0.3 no pubspec.yaml do seu aplicativo.

## Utilização.

Para acessar a tela de Sobre : CGISobrePage()
Para acessar a tela de Notas de Versão : CGINotasVersaoPage()

## Funcionalidades.
* Tela de Sobre mostrando a versão atual do app, e se existe alguma nova versão cadastrada no repositório do projeto na Firebase.
* Tela de Sobre mensagem informativa em apps com versões desatualizadas com link para atualizar o app na Google Play Store.
* Tela de Notas de Versão que recupera as informações disponíveis para cada versão no repositório do projeto na Firebase.

## Dependências.
O Pacote faz utilização dos seguintes pacotes: `cloud_firestore`, `url_launcher`, `package_info`, `intl`