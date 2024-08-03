import 'package:elgin/elgin.dart';
import '../config/constantes.dart';

class Ferramentas {
  static Future<int?> conectarImpressora() async {
    final driver = ElginPrinter(
      type: ElginPrinterType.MINIPDV,
    );

    return Elgin.printer.connect(driver: driver);
  }

  static String horario() {
    var date = DateTime.now();
    String hora =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}';
    return hora;
  }

  static String hoje() {
    var date = DateTime.now();
    String dataFormatada =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    return dataFormatada;
  }

  static Future<void> imprimir(
    String fila,
    String prefixo,
    int senha,
  ) async {
    await Elgin.printer.printString(
      Constantes().empresa!.nome!,
      align: ElginAlign.CENTER,
      fontSize: ElginSize.SM,
    );
    await Elgin.printer.printString(
      '---------------',
      align: ElginAlign.CENTER,
      fontSize: ElginSize.MD,
    );
    await Elgin.printer.feed(2);
    await Elgin.printer.printString(
      fila,
      align: ElginAlign.CENTER,
      fontSize: ElginSize.MD,
    );
    await Elgin.printer.feed(4);
    await Elgin.printer.printString(
      '$prefixo${senha.toString().padLeft(4, '0')}',
      align: ElginAlign.CENTER,
      fontSize: ElginSize.LG,
    );
    await Elgin.printer.feed(4);
    await Elgin.printer.printString(
      horario(),
      align: ElginAlign.CENTER,
      fontSize: ElginSize.MD,
    );
    await Elgin.printer.feed(1);
    await Elgin.printer.printString(
      hoje(),
      align: ElginAlign.CENTER,
      fontSize: ElginSize.MD,
    );
    await Elgin.printer.feed(4);
    await Elgin.printer.printString(
      '---------------',
      align: ElginAlign.CENTER,
      fontSize: ElginSize.MD,
    );
    await Elgin.printer.printString(
      Constantes().empresa!.endereco!,
      align: ElginAlign.CENTER,
      fontSize: ElginSize.SM,
    );
    await Elgin.printer.feed(2);
    await Elgin.printer.cut(lines: 2);
    await Elgin.printer.disconnect();
  }
}
