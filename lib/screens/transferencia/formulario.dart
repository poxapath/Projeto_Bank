import 'package:flutter/material.dart';
import '../../components/editor.dart';
import '../../models/transferencia.dart';
import '../../database/transferencia_dao.dart';

class FormularioTransferencia extends StatefulWidget {
  final int? numeroConta;

  FormularioTransferencia({this.numeroConta});

  @override
  State<StatefulWidget> createState() => FormularioTransferenciaState();
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final _controladorCampoNumeroConta = TextEditingController();
  final _controladorCampoValor = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.numeroConta != null) {
      _controladorCampoNumeroConta.text = widget.numeroConta.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criando Transferência')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: 'Número Conta',
              dica: '0000',
            ),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: 'Valor',
              dica: '0.00',
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
              child: Text('Confirmar'),
              onPressed: () => _confirmar(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmar(BuildContext context) async {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);

    if (numeroConta != null && valor != null) {
      final transferencia = Transferencia(valor, numeroConta);
      await TransferenciaDao.inserir(transferencia);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos corretamente!')),
      );
    }
  }
}