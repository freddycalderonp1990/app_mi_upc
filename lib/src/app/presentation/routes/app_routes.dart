class AppRoutesMiUpc{
  static const String _nameApp = "/miUpcApp_";

  static var SPLASH = _nameApp + "splash";
  static var MENU = _nameApp + "menu";
  static var SERVICIOS = _nameApp + "servicios";
  static var ACUERDO = _nameApp + "acuerdo";
  static var ITEMSSERVICIOS = _nameApp + "itemsServicios";
  static var ITEMSTIPS = _nameApp + "itemsTips";
  static var MAPAUPC = _nameApp + "mapaUpc";
  static var REGISTROUSUARIO = _nameApp + "registroUsuario";

  static var REGISTRAR_EVENTO = _nameApp + "registroEvento";
  static var CONSULTAVEHICULO = _nameApp + "consultaVehiculo";
  static var DETALLEALERTAS = _nameApp + "detalleAlertas";
  static var ALERTASDELITOS = _nameApp + "AlertasDelitos";


  static var nameMenuInit = "Inicio";

  static var pageMenuInit = "";


  static setPageInicio(String appRoute){
    pageMenuInit=appRoute;
  }


  static setNameMenu({String name="Inicio"}){
    nameMenuInit=name;

  }

}