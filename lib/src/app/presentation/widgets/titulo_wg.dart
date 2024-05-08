import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TituloWg extends StatefulWidget {

  final String titulo;
  final Color? color;

  const TituloWg({Key? key, required this.titulo, this.color=Colors.amber}) : super(key: key);

  @override
  State<TituloWg> createState() => _TituloWgState();
}

class _TituloWgState extends State<TituloWg> {
  @override
  Widget build(BuildContext context) {
    return   Container(
      color: widget.color,
      width: double.infinity,
      height: 50,child: Center(child: Text(widget.titulo)),);
  }
}
