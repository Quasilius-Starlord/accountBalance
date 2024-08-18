import 'dart:io';
// https://stackoverflow.com/questions/2169294/how-to-add-manifest-permission-to-an-application
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}