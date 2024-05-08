part of '../pages.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    return GetBuilder<SplashController>(
        builder: (_) => Scaffold(
          body:
             SingleChildScrollView(child:
             Stack(children: [
               SizedBox(
                 height: responsive.alto,
                 width: responsive.ancho,
                 child:       Image.asset(
                   AppImages.imgSplash,
                   fit: BoxFit.fill,
                 ),
               ),
               Center(
                 heightFactor: 1.5,
                 child:Container(
                   height: responsive.altoP(85),
                   width: responsive.anchoP(80),
                   child:
                   Column(
                     children: [
                       SizedBox(
                         height: responsive.altoP(60.5),
                       ),
                       Center(
                           child: Loading(
                             radius: 18.0,
                             dotRadius: 8.0,
                           )),
                     ],),

                 ) ,),
             ],),),
        ),
    );

  }

}
