
import 'package:flutter/material.dart';

import '../../core/values/app_colors.dart';

class TextoColorParser {

  static Widget textoConColores(
      String texto, {
        double fontSize = 15,
        TextAlign textAlign = TextAlign.center,
        FontWeight fontWeight = FontWeight.normal,
      }) {

    final RegExp regex = RegExp(
      r'\[(rojo|azul|verde|negro|amarillo|gris)\](.*?)\[\/\1\]',
      caseSensitive: false,
    );

    List<TextSpan> spans = [];

    int lastIndex = 0;

    for (final match in regex.allMatches(texto)) {

      // Texto normal
      if (match.start > lastIndex) {
        spans.add(
          TextSpan(
            text: texto.substring(lastIndex, match.start),
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        );
      }

      String colorTexto = match.group(1)!.toLowerCase();
      String contenido = match.group(2)!;

      Color color = _obtenerColor(colorTexto);

      spans.add(
        TextSpan(
          text: contenido,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      lastIndex = match.end;
    }

    // Texto restante
    if (lastIndex < texto.length) {
      spans.add(
        TextSpan(
          text: texto.substring(lastIndex),
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      );
    }

    return RichText(
      textAlign: textAlign,
      text: TextSpan(children: spans),
    );
  }

  static Color _obtenerColor(String color) {

    switch (color) {

      case 'rojo':
        return Colors.red;

      case 'azul':
        return AppColors.colorAzulTitle;

      case 'verde':
        return Colors.green;

      case 'amarillo':
        return Colors.yellow;

      case 'gris':
        return Colors.grey;

      case 'negro':
        return Colors.black;

      default:
        return Colors.black;
    }
  }
}

/*
╔══════════════════════════════════════╗
║         TEXTO COLOR PARSER          ║
╚══════════════════════════════════════╝

✔ Convierte etiquetas en texto coloreado.

ETIQUETAS DISPONIBLES:

[rojo]texto[/rojo]
[azul]texto[/azul]
[verde]texto[/verde]
[amarillo]texto[/amarillo]
[gris]texto[/gris]
[negro]texto[/negro]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EJEMPLO:

TextoColorParser.textoConColores(
  "Hola [rojo]Mundo[/rojo]"
);

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EJEMPLO DINÁMICO:

String descripcion =
"[rojo]ERROR:[/rojo] Usuario inválido";

TextoColorParser.textoConColores(descripcion);

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
*/