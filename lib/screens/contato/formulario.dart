import 'package:flutter/material.dart';
import '../../models/contato.dart';

class FormularioContato extends StatefulWidget {
  @override
  State<FormularioContato> createState() => _FormularioContatoState();
}

class _FormularioContatoState extends State<FormularioContato> {
  final _controladorNome = TextEditingController();
  final _controladorConta = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Contato')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controladorNome,
              decoration: InputDecoration(
                labelText: 'Nome',
                hintText: 'Ex: João Silva',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _controladorConta,
              decoration: InputDecoration(
                labelText: 'Número da Conta',
                hintText: 'Ex: 12345',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.account_balance),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _confirmar(context),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text('Salvar Contato', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmar(BuildContext context) {
    final nome = _controladorNome.text.trim();
    final int? numeroConta = int.tryParse(_controladorConta.text);

    if (nome.isNotEmpty && numeroConta != null) {
      final contato = Contato(nome, numeroConta);
      Navigator.pop(context, contato);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos corretamente!')),
      );
    }
  }
}
