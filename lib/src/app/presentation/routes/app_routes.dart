class AppRoutesMiUpc {
  static var SPLASH = _nameApp + "splash";
  static var nameMenuInit = "Inicio";
  static var pageMenuInit = "";
  static const _nameApp = "/miUpcApp_";


  static const MENU = _nameApp + "menu";
  static const SERVICIOS = _nameApp + "servicios";
  static const ACUERDO = _nameApp + "acuerdo";
  static const ITEMSSERVICIOS = _nameApp + "itemsServicios";
  static const ITEMSTIPS = _nameApp + "itemsTips";
  static const MAPAUPC = _nameApp + "mapaUpc";
  static const REGISTROUSUARIO = _nameApp + "registroUsuario";


   static setPageInicio(String appRoute){
     pageMenuInit=appRoute;
  }


  static setNameMenu({String name="Inicio"}){
    nameMenuInit=name;

  }


}
