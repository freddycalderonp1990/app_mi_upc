part of '../../providers_impl.dart';

class HostApp {
  //se utiliza el onlyUrl para no incluir el segmento
  // api/v1/siipne-movil/




  static getDes() {
    return dotenv.env['HOST_DEV'] ?? 'https://siipne3wv2.policia.gob.ec/';
  }

  static getTest() {
    return dotenv.env['HOST_TEST'] ?? 'https://siipne3wv2.policia.gob.ec/';

  }

  static getProd() {
    return dotenv.env['HOST_PROD'] ?? 'https://siipne3wv2.policia.gob.ec/';
  }

  static gethost({required String segmento}) {
    String url = '';

    switch (AppConfig.AmbienteUrl) {
      case Ambiente.desarrollo:
        url = getDes() + segmento; //Desarrollo

        break;
      case Ambiente.prueba:
        url = getTest() + segmento; //Pruebas

        break;
      case Ambiente.produccion:
        url = getProd() + segmento; //Produccion

        break;
    }
    return url;
  }



  static getAmbiente() {
    String ambiente = '';
    switch (AppConfig.AmbienteUrl) {
      case Ambiente.desarrollo:
        ambiente = "Desc"; //Desarrollo

        break;
      case Ambiente.prueba:

        ambiente="Test";
        break;
      case Ambiente.produccion:
        ambiente = "Prod"; //Produccion

        break;
    }
    return ambiente;
  }


}
