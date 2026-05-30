import 'package:flutter/material.dart';
import '../../models/contato.dart';
import '../../database/contato_dao.dart';
import 'formulario.dart';
import '../transferencia/formulario.dart';

class ListaContatos extends StatefulWidget {
  @override
  State<ListaContatos> createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  List<Contato> _contatos = [];

  @override
  void initState() {
    super.initState();
    _carregarContatos();
  }

  Future<void> _carregarContatos() async {
    final lista = await ContatoDao.listar();
    setState(() {
      _contatos = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contatos')),
      body: _contatos.isEmpty
          ? Center(child: Text('Nenhum contato ainda.'))
          : ListView.builder(
              itemCount: _contatos.length,
              itemBuilder: (context, index) {
                final contato = _contatos[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text(
                        contato.nome[0].toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      contato.nome,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Conta: ${contato.numeroConta}'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FormularioTransferencia(
                            numeroConta: contato.numeroConta,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FormularioContato()),
          ).then((contatoRecebido) {
            if (contatoRecebido != null) {
              ContatoDao.inserir(contatoRecebido).then((_) {
                _carregarContatos();
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
