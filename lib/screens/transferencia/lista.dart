import 'package:flutter/material.dart';
import 'formulario.dart';
import '../../models/transferencia.dart';
import '../../database/transferencia_dao.dart';
import '../contato/lista.dart';

class ListaTransferencias extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListaTranferenciaState();
  }
}

class ListaTranferenciaState extends State<ListaTransferencias> {
  static const _tituloAppBar = 'Transferência';
  List<Transferencia> _transferencias = [];

  @override
  void initState() {
    super.initState();
    _carregarTransferencias();
  }

  Future<void> _carregarTransferencias() async {
    final lista = await TransferenciaDao.listar();
    setState(() {
      _transferencias = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _tituloAppBar,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.people, color: Colors.white),
            tooltip: 'Contatos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ListaContatos()),
                //ScaffoldMessenger.of(context).showSnackBar(
                //SnackBar(content: Text('Lista de contatos em breve!')),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = _transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormularioTransferencia()),
          ).then((_) => _carregarTransferencias());
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;
  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.monetization_on, color: Colors.white),
        ),
        title: Text(
          'R\$ ${_transferencia.valor.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Conta: ${_transferencia.numeroConta}'),
      ),
    );
  }
}
