part of 'custom_widgets.dart';

class WorkAreaRegistroPageWidget extends StatefulWidget {
  final  RxBool peticionServer;
  final String name;
  final List<Widget> contenido;
  final bool btnAtras;
  final VoidCallback? pantallaIrAtras;
  final Widget? widgetBtnFinal;
  final EdgeInsetsGeometry? paddin;
  final FloatingActionButtonLocation ubicacionBtnFinal;
  final imgFondo;
  final double sizeTittle;
  final bool mostrarVersion;

  const WorkAreaRegistroPageWidget({
    required this.peticionServer,
    required this.contenido,
    this.btnAtras = false,
    this.widgetBtnFinal,
    this.paddin,
    this.ubicacionBtnFinal = FloatingActionButtonLocation.centerFloat,
    this.imgFondo,
    this.sizeTittle = 0,
    this.mostrarVersion = false,
    this.pantallaIrAtras,
    this.name = '',
  });

  get selectedDate => null;

  get onSelectedDate => null;

  @override
  _WorkAreaRegistroPageWidgetState createState() => _WorkAreaRegistroPageWidgetState();
}
class _WorkAreaRegistroPageWidgetState extends State<WorkAreaRegistroPageWidget> {
  late double _height;
  late double _width;

  String _setTime='', _setDate='';

  late String _hour, _minute, _time;

  late String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = DateTime(2023,03 , 07, DateTime.now().hour, DateTime.now().minute).toString();
    final responsive = ResponsiveUtil();
    Widget wgImgFondo = Container(
      height: responsive.alto,
      width: responsive.ancho,
      child: Image.asset(
        widget.imgFondo ?? AppImages.imgarea,
        fit: BoxFit.fill,
      ),
    );

    Widget wgbuscaCedula= Container(
    decoration: BoxDecoration(
    color: Colors.white54,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: Color(0xFF04589A),
      width: 4,
    ),
  ),
  child: InkWell(
    child: Container(
      width: responsive.anchoP(70),
      height: responsive.anchoP(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: responsive.altoP(2),
          ),
          Expanded(
              child: Form(
                child: ImputTextWidget(
                  keyboardType: TextInputType.number,
                  icono: const Icon(
                    Icons.assignment_sharp,
                    color: Colors.black38,
                    size: 20,
                  ),
                  label: "Cédula",
                  fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
                ),
              )),
          SizedBox(
            width: responsive.altoP(1),
          ),
          BtnIconWidget(
            onTap: () async {
            },
            iconData: Icons.search, color: Colors.white,
          ),
        ],
      ),
    ),
  ),
);
    Widget wgDatosPolcia= Container(
      width: responsive.anchoP(88),
      height: responsive.altoP(15.5),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF04589A),
          width: 4,
        ),
      ),
      child: InkWell(
        child: Container(
          child: Row(
           children: <Widget>[
              SizedBox(
                width: responsive.altoP(1.5),
              ),
              Expanded(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: responsive.altoP(1.5),
                        ),
                        Container(child:
                        Text(
                          textAlign: TextAlign.start,
                          "Nombres y Apellidos:",
                          style: TextStyle(
                              fontSize: responsive.diagonalP(1.2),
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),),
                        SizedBox(
                          height: responsive.altoP(1.5),
                        ),
                        Container(

                          child:
                        Text(
                          textAlign: TextAlign.start,
                          "Grado:",
                          style: TextStyle(
                              fontSize: responsive.diagonalP(1.2),
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),),
                        SizedBox(
                          height: responsive.altoP(1.5),
                        ),
                        Container(child:
                        Text(
                          textAlign: TextAlign.start,
                          "Unidad:",
                          style: TextStyle(
                              fontSize: responsive.diagonalP(1.2),
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),),
                        SizedBox(
                          height: responsive.altoP(1.5),
                        ),
                        Container(child:
                        Text(
                          textAlign: TextAlign.start,
                          "Designación:",
                          style: TextStyle(
                              fontSize: responsive.diagonalP(1.2),
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),),
                      ],
                    )
                  )),
              Expanded(
                  child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: responsive.altoP(1),
                          ),
                          Container(child:
                          Text(
                            "POZO CANACUAN JAIRO FERNANDO",
                            style: TextStyle(
                                fontSize: responsive.diagonalP(1.0),
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent),
                          ),),
                          SizedBox(
                            height: responsive.altoP(1.5),
                          ),
                          Container(child:
                          Text(
                            "TENIENTE",
                            style: TextStyle(
                                fontSize: responsive.diagonalP(1.0),
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent),
                          ),),
                          SizedBox(
                            height: responsive.altoP(1),
                          ),
                          Container(child:
                          Text(
                            "NAS-DNTIC-DINN-DSOF-",
                            style: TextStyle(
                                fontSize: responsive.diagonalP(1.0),
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent),
                          ),),
                          SizedBox(
                            height: responsive.altoP(1.5),
                          ),
                          Container(child:
                          Text(
                            "ANALISTA DE INGENIERÍA DE SOFTWARE 2",
                            style: TextStyle(
                                fontSize: responsive.diagonalP(1.0),
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent),
                          ),),
                        ],
                      )
                  )),
             Image.asset(
               height:responsive.anchoP(25) ,
               width: responsive.anchoP(25),
               AppImages.imgEscpolicia,
             ),
            ],
          ),
        ),
      ),
    );
    Widget wgRegistro=    Container(
      width: responsive.anchoP(95),
      height: responsive.altoP(60),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF04589A),
          width: 2,
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: responsive.altoP(1.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: <Widget>[
                  Container(
                      child:   Column(
                        children: [
                         SizedBox(
                            height: responsive.altoP(0.5),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    const Text(
                                      'Seleccione la fecha',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                      child: Container(
                                        width: responsive.anchoP(30),
                                        height: responsive.altoP(6),
                                        margin: const EdgeInsets.only(top: 5),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white54,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Color(0xFF04589A),
                                            width: 3,
                                          ),
                                        ),
                                        child: TextFormField(
                                          style: const TextStyle(
                                            fontSize: 20),
                                          textAlign: TextAlign.center,
                                          enabled: false,
                                          keyboardType: TextInputType.text,
                                          controller: _dateController,
                                          onSaved: (val) {
                                            _setDate = val!;
                                          },
                                          decoration: const InputDecoration(
                                              disabledBorder:
                                              UnderlineInputBorder(borderSide: BorderSide.none),
                                              // labelText: 'Time',
                                              contentPadding: EdgeInsets.only(top: 0.0)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    const Text(
                                      'Seleccione la hora',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _selectTime(context);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        width: responsive.anchoP(48.5),
                                        height: responsive.altoP(6),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white54,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Color(0xFF04589A),
                                            width: 3,
                                          ),
                                        ),
                                        child: TextFormField(
                                          style: const TextStyle(fontSize: 20),
                                          textAlign: TextAlign.center,
                                          onSaved: ( val) {
                                            _setTime = val!;
                                          },
                                          enabled: false,
                                          keyboardType: TextInputType.text,
                                          controller: _timeController,
                                          decoration: const InputDecoration(
                                              disabledBorder:
                                              UnderlineInputBorder(borderSide: BorderSide.none),
                                              // labelText: 'Time',
                                              contentPadding: EdgeInsets.all(5)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                       ],
                      ),
                  ),
                ],
              )
            ],
          ),
          Row(children: [
            SizedBox(
              width: responsive.anchoP(2.0),
            ),
            Container(
              child:    Expanded(
                  child: Form(
                    child:      Container(
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: responsive.altoP(2),
                          ),
                          Container(child:
                          Text(
                            textAlign: TextAlign.start,
                            "Seleccione un Aspecto",
                            style: TextStyle(
                                fontSize: responsive.diagonalP(1.5),
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),),
                          DecoratedBox(
                              decoration: BoxDecoration(
                                  color:Colors.white54, //background color of dropdown button
                                  border: Border.all(color: Colors.black38, width:3), //border of dropdown button
                                  borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
                                  boxShadow: const <BoxShadow>[ //apply shadow on Dropdown button
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                        blurRadius: 5) //blur radius of shadow
                                  ]
                              ),

                              child:Padding(
                                  padding: const EdgeInsets.only(left:30, right:30),
                                  child:DropdownButton(
                                    value: "Puntualidad",
                                    items: const [ //add items in the dropdown
                                      DropdownMenuItem(
                                        value: "Puntualidad",
                                        child: Text("Puntualidad"),
                                      ),
                                      DropdownMenuItem(
                                          value: "Condecoración",
                                          child: Text("Condecoración")
                                      ),
                                      DropdownMenuItem(
                                        value: "Productividad",
                                        child: Text("Productividad"),
                                      )

                                    ],
                                    onChanged: (value){ //get value when changed
                                      print("You have selected $value");
                                    },
                                    icon: const Padding( //Icon at tail, arrow bottom is default icon
                                        padding: EdgeInsets.only(left:50),
                                        child:Icon(Icons.arrow_circle_down_sharp)
                                    ),
                                    iconEnabledColor: Colors.white, //Icon color
                                    style: const TextStyle(  //te
                                        color: Colors.black, //Font color
                                        fontSize: 20 //font size on dropdown button
                                    ),
                                    dropdownColor: Colors.white, //dropdown background color
                                    underline: Container(), //remove underline
                                    isExpanded: true, //make true to make width 100%
                                  )
                              )
                          ),
                        ],
                      ),

                    ),
                  )), ),
            SizedBox(
              width: responsive.anchoP(2.0),
            ),
          ],),
          SizedBox(
            height: responsive.altoP(1.5),
          ),
          Expanded(
              child: Form(
                  child:   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child:
                      Text(
                        textAlign: TextAlign.start,
                        "Observación",
                        style: TextStyle(
                            fontSize: responsive.diagonalP(1.5),
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),),
                      Column(
                        children: const <Widget>[
                          Card(
                             color: Colors.white54,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  maxLength:500,
                                  maxLines: 10, //or null
                                  decoration: InputDecoration.collapsed(hintText: "Ingrese la Observación"),
                                ),
                              )
                          )
                        ],
                      )

                    ],
                  )
              )),




        ],
      ),
    );
    Widget wgBotones= Container(
    child:  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width:responsive.anchoP(5),
            ),
            Container(
    decoration: BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.black,
        width: 3,
      ),
    ),
    child: InkWell(
      child: Container(
        width: responsive.anchoP(35),
        height: responsive.anchoP(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Form(
                  child:  Image.asset(
                    height:responsive.anchoP(25) ,
                    width: responsive.anchoP(25),
                    AppImages.imgGuardar,
                  ),
                )),
            Container(child:
            Text(
              "Guardar",
              style: TextStyle(
                  fontSize: responsive.diagonalP(1.0),
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),),
          ],
        ),
      ),
    ),
    ),
            SizedBox(width: 35,),
            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
              ),
              child: InkWell(
                onTap: ()=>{Get.offAllNamed(AppRoutes.MENU)},
                child: Container(
                  width: responsive.anchoP(35),
                  height: responsive.anchoP(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: Form(
                            child:  Image.asset(
                              height:responsive.anchoP(25) ,
                              width: responsive.anchoP(25),
                              AppImages.imgAtras,
                            ),
                          )),
                      Container(child:
                      Text(
                        "Cancelar",
                        style: TextStyle(
                            fontSize: responsive.diagonalP(1.0),
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width:responsive.anchoP(5),),

          ],
        ),
      ],
    )
);
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: [
                wgImgFondo,
                SafeArea(
                  child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        SizedBox(
                          height: responsive.altoP(3.5),
                        ),
                        Container(child:         Text(
                          "REGISTRO DE ASPECTOS POSITIVOS",
                          style: TextStyle(
                              fontSize: responsive.diagonalP(2.0),
                              fontWeight: FontWeight.w700,
                              color: Colors.blueAccent),
                        ),),
                        SizedBox(
                          height: responsive.altoP(2),
                        ),
                        wgbuscaCedula,
                        SizedBox(
                          height: responsive.altoP(1),
                        ),
                        Container(child:

                        Text(
                          "DATOS SERVIDOR POLICIAL",
                          style: TextStyle(
                              fontSize: responsive.diagonalP(1.5),
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),),
                        SizedBox(
                          height: responsive.altoP(1),
                        ),
                        wgDatosPolcia,
                        SizedBox(
                          height: responsive.altoP(1),
                        ),
                        Container(child:

                        Text(
                          "DATOS REGISTRO",
                          style: TextStyle(
                              fontSize: responsive.diagonalP(1.5),
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),),
                        SizedBox(
                          height: responsive.altoP(1),
                        ),
                        wgRegistro,
                            SizedBox(
                              height: responsive.altoP(1),
                            ),
                        wgBotones
                      ])),
                ),
                Obx(()=>  CargandoWidget(
                  mostrar: widget.peticionServer.value,
                ))
              ],
            )));
  }
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }
  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = '$_hour : $_minute';
        _timeController.text = _time;
       _timeController.text = DateTime(selectedTime.hour, selectedTime.minute).toString();
      });
    }}
}



