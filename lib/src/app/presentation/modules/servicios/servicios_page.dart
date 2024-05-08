part of '../pages.dart';

class ServiciosPage extends GetView<ServiciosController> {
  const ServiciosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkAreaItemsPageWidget(
      btnAtras: false,
      peticionServer:  controller.peticionServerState, contenido: getContenido(),
    );
  }
  getContenido(){
    final responsive =ResponsiveUtil();
    return Column(
      children: [
        Stack(children: [

          Container(
            decoration:  const BoxDecoration(
              image:  DecorationImage(
                image:  AssetImage(AppImages.imgFondo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Stack(children: [

            Column(
              children: [
                getCabecera(responsive),
                SizedBox(
                  width: responsive.anchoP(88),
                  height: responsive.altoP(76),
                  child: Obx(() => getListaServicios()),
                ),

              ],
            ),
            warningWidgetGetX(),
          ],)
        ],),

      ],);
  }

  warningWidgetGetX (){
    controller.connectionStatusController();
    return Obx(() {
      return Visibility(
          visible: controller.status.value != ConnectionStatus.online,
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: 70,
              color: Colors.red,
              child: const Row(
                children: [
                  Icon(Icons.wifi_off),
                  SizedBox(width: 10),
                  Text('No tiene Conexión a Internet',  style: TextStyle(
                    fontWeight:
                    FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),),
                ],
              ),
            ),
            const SizedBox(height: 10,)
          ],)
      );
    });
  }

  getListaServicios(){
    final resposnsive=ResponsiveUtil();
    Widget listaU=ListView.builder( padding:  const EdgeInsets.only(top: 2),
      shrinkWrap: true,
      itemCount: controller.listaServicios != null ? controller.listaServicios.length : 0,
      itemBuilder: (context, ind) {
        return Obx(() => InkWell(
          onTap: () => {

            getDatosServicio(ind)
          },
          child:
          Column(
            children: [
              SizedBox(
                width: resposnsive.anchoP(95),
                child:   Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: resposnsive.anchoP(2.0),),
                      imgPerfilRedonda(
                        size: 18,
                        img: controller.listaServicios[ind].imgBase64==''?null:controller.listaServicios[ind].imgBase64,
                      ),
                      SizedBox(width: resposnsive.anchoP(4),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: resposnsive.anchoP(50),
                            child: Text(
                              textAlign: TextAlign.justify,
                              controller.listaServicios[ind].descripcion.toUpperCase(),
                              style: TextStyle(
                                fontSize: resposnsive.diagonalP(1.5),
                                fontWeight: FontWeight.w700,
                                color: Colors.blue[900],),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Divider(
                    color: AppConfig.colorBarras,
                  ),
                ],),)
            ],
          ),
        ));
      },
    );
    return listaU;
  }
  getCabecera(ResponsiveUtil responsive) {
    return Column(
      children: [
        Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: responsive.altoP(20),
                  child: Image.asset(AppImages.imgCabecera2),
                ),
              ),
              Container(
                color: Colors.blue[900],
                child: Column(
                  children: <Widget>[
                    const Divider(
                      color: Colors.transparent,
                      height: 5.0,
                    ),
                    const Divider(
                      color: Colors.transparent,
                      height: 3.0,
                    ),
                    Container(
                      color: Colors.white,
                      child: Text('   ${controller.fecha}    ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: AppConfig.colorBarras,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.transparent,
                      height: 3.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  getDatosServicio(int ind) async {
   String resumen=controller.listaServicios[ind].resumen.toString();
   String img=controller.listaServicios[ind].imgBase64;
    int id =controller.listaServicios[ind].idUpcServicio;
    String servicio=controller.listaServicios[ind].descripcion;
   print("getlistaaaaa");
   await controller.cargarDatosDetalleLista(id);

    DialogosAwesome.getAlertDetalleServicios(body: bodyDetlleListaServicios(resumen, servicio), imagen: img);
  }


  bodyDetlleListaServicios(String resumen,String servicio) {
    final responsive = new ResponsiveUtil();
    Widget tarea = Container(
      child: Stack(children: [
        Column(children: [
          Container(
              decoration: BoxDecoration(
                color: Color(0xFF06245B),
                border: Border.all(
                  color: Colors.grey,
                ), //Border.all
                borderRadius: BorderRadius.circular(15),
              ),
              height: responsive.altoP(4),
              child: Center(
                child: Text(
                  textAlign: TextAlign.justify,
                  servicio,
                  style: TextStyle(
                      fontSize:
                      responsive.diagonalP(1.4),
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),)
          ),
          SizedBox(height: responsive.altoP(2),),
          Container(
            width: responsive.anchoP(70.0),
            child:    Text(
              textAlign: TextAlign.justify,
              resumen,
              style: TextStyle(
                  fontSize:
                  responsive.diagonalP(1.4),
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),),
          SizedBox(height: responsive.altoP(2),),
          Container(
              decoration: BoxDecoration(
                color: const Color(0xFF06245B),
                border: Border.all(
                  color: Colors.grey,
                ), //Border.all
                borderRadius: BorderRadius.circular(15),
              ),
              height: responsive.altoP(4),
              child: Center(
                child: Text(
                  textAlign: TextAlign.justify,
                  controller.detalle,
                  style: TextStyle(
                      fontSize:
                      responsive.diagonalP(1.4),
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),)
          ),
          getListaItemsServicios(),
        ],)
      ],),
    );
    return tarea;
  }
  getListaItemsServicios() {
    final resposnsive=ResponsiveUtil();
    Widget listaU=     Obx(() => Container (
        height: resposnsive.altoP(30),
        child: ListView.builder(
      shrinkWrap: true,
      padding:  EdgeInsets.only(top: 2),
      itemCount: controller.listaItemsServicios.length,
      itemBuilder: (context, ind) {
        return Padding(
            padding: EdgeInsets.only(right: 5, left: 5),
            child:
         Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: resposnsive.anchoP(2),
                  ),
                  Image.asset(
                    height: resposnsive.altoP(4),
                    width: resposnsive.anchoP(4),
                    AppImages.vineta,
                  ),
                  SizedBox(
                    width: resposnsive.anchoP(2),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: resposnsive.anchoP(65.0),
                        child:    Text(
                          textAlign: TextAlign.justify,
                          controller.listaItemsServicios[ind].descripcion,
                          style: TextStyle(
                              fontSize:
                              resposnsive.diagonalP(1.3),
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),),
                    ],
                  ),

                ],
              ),
              Divider(
                color: AppConfig.colorBarras,
              ),
            ],));
      },
    )),);
    return listaU;
  }
}

