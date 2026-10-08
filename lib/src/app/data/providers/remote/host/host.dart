part of '../../providers_impl.dart';

class Host {
  static gethost({bool onlyUrl = false})  {
    String url = '';
     switch (AppConfig.AmbienteUrl) {
      case Ambiente.desarrollo:
         url="https://siipne3wv2.policia.gob.ec/appmovil/";
        url=_setSegmentoApp(url,onlyUrl);
        break;
      case Ambiente.prueba:
        url="https://test.policia.gob.ec/appmovil/";//Pruebas
        url=_setSegmentoApp(url,onlyUrl);
        break;
      case Ambiente.produccion:
        url="https://siipne.policia.gob.ec/appmovil/";
        url=_setSegmentoApp(url,onlyUrl);
        break;
    }
    return url;
  }
  static gethostApis({bool onlyUrl = false})  {
    String url = '';
    switch (AppConfig.AmbienteUrl) {
      case Ambiente.desarrollo:
        url="https://backendtest.policia.gob.ec/";
        url=_setSegmentoAppApis(url,onlyUrl);
        break;
      case Ambiente.prueba:
        url="https://apisTest.policia.gob.ec/";//Pruebas
        url=_setSegmentoAppApis(url,onlyUrl);
        break;
      case Ambiente.produccion:
        url="https://apis.policia.gob.ec/";
        url=_setSegmentoAppApis(url,onlyUrl);
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

  static  _setSegmentoApp(String url, onlyUrl) {
    return url;
  }

  static  _setSegmentoAppApis(String url, onlyUrl) {
    return url;
  }
}
