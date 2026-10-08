
// se inicializan nuestras preferencias en el main
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  late SharedPreferences _prefs;

  PreferenciasUsuario._internal();

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }



  // GET y SET del idUser
  getIdUsuario() {
    print('retronadno id');
    return _prefs.getString('idUsuario') ?? "0";
  }

  setIdUsuario(String value) {
    print('insertando id');
    _prefs.setString('idUsuario', value);
  }


  // GET y SET del idUser
  getIdGenPersona() {
    print('retronadno idGenPersona');
    return _prefs.getString('idGenPersona') ?? "0";
  }

  setIdGenPersona(String value) {
    print('idGenPersona id {$value}');
    _prefs.setString('idGenPersona', value);
  }


  // GET y SET del nombreUsuario
  String getNombreUsuario() {
    return _prefs.getString('nombreUsuario') ?? '';
  }

  setNombreUsuario(String value) {
    _prefs.setString('nombreUsuario', value);
  }

  // GET y SET de la cedula
  getCedula() {
    return _prefs.getString('cedula') ?? '';
  }

  setCedula(String value) {
    _prefs.setString('cedula', value);
  }

  // GET y SET de la Celular
  getCelular() {
    return _prefs.getString('celular') ?? '';
  }

  setCelular(String value) {
    _prefs.setString('celular', value);
  }

  // GET y SET de la nombres
  getNombres() {
    print('los nombres');
    print(_prefs.getString('nombres'));
    return _prefs.getString('nombres') ?? '';
  }

  setNombres(String value) {
    print('set nombres' + value);

    _prefs.setString('nombres', value);
  }

  // GET y SET de la email
  getEmail() {
    return _prefs.getString('email') ?? '';
  }

  setEmail(String value) {
    _prefs.setString('email', value);
  }

  // GET y SET de la email
  bool getIsNacional() {
    bool result = false;
    String valor = _prefs.getString('nacional') ?? '';
    valor == 'SI' ? result = true : result = false;
    return result;
  }

  setIsNacional(bool valor) {
    String value = 'NO';
    valor ? value = 'SI' : value = 'NO';
    _prefs.setString('nacional', value);
  }

  // GET y SET de la token
  //se definen dos token para almacenar el nuevo y antiguo token
  getToken1() {
    return _prefs.getString('token1') ?? '';
  }

  setToken1(String value) {

    _prefs.setString('token1', value);
  }

  getToken2() {
    return _prefs.getString('token2') ?? '';
  }

  setToken2(String value) {
    _prefs.setString('token2', value);
  }


  getImei() {
    return _prefs.getString('imei') ?? '';
  }

  setImei(String value) {
    _prefs.setString('imei', value);
  }
  setDatosUser(
      {
        required String idGenPersona,
        required String nombreUser,
        required  String cedulaV,
        required String emailV,
        required  String nombresV,
        required String celular,
        required String idUsuario,
        required  bool isNacional,
        required String imei}) {

    setIdGenPersona(idGenPersona);
    setNombreUsuario(nombreUser);
    setCedula(cedulaV);
    setEmail(emailV);
    setNombres(nombresV);
    setCelular(celular);
    setIdUsuario(idUsuario);
    setIsNacional(isNacional);
    setImei(imei);
  }

  clearDatosUser() {
    setIdGenPersona('');
    setNombreUsuario('');
    setCedula('');
    setEmail('');
    setNombres('');
    setCelular('');
    setIdUsuario('');
    setIsNacional(true);
    setToken1('');
    setToken2('');
    setImei('');

    print(clearDatosUser);
  }
}
