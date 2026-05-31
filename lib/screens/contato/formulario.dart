import 'package:flutter/material.dart';
import '../../models/contato.dart';
import '../../database/contato_dao.dart';

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
      appBar: AppBar(title: const Text('Novo Contato')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controladorNome,
              decoration: const InputDecoration(
                labelText: 'Nome',
                hintText: 'Ex: Maria Oliveira',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controladorConta,
              decoration: const InputDecoration(
                labelText: 'Número da conta',
                hintText: '0000',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _salvar(context),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Salvar', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _salvar(BuildContext context) async {
    final String nome = _controladorNome.text.trim();
    final int? conta = int.tryParse(_controladorConta.text);

    if (nome.isNotEmpty && conta != null) {
      final contatoCriado = Contato(nome, conta);

      try {
        // Salva no banco e obtém o id gerado
        final idGerado = await ContatoDao.inserir(contatoCriado);
        debugPrint(
          'Contato salvo: id:$idGerado | nome:${contatoCriado.nome}, conta:${contatoCriado.numeroConta}',
        );

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contato salvo com sucesso!')),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos corretamente.')),
      );
    }
  }
}
