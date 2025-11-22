import 'package:flutter/material.dart';
import '../models/tarefa.dart';

class TarefasPage extends StatefulWidget {
  final DateTime dia;

  const TarefasPage({super.key, required this.dia});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  List<Tarefa> tarefas = [];
  final controller = TextEditingController();

  void ordenar() {
    tarefas.sort((a, b) {
      if (a.concluida == b.concluida) {
        return a.titulo.compareTo(b.titulo);
      }
      return a.concluida ? 1 : -1;
    });
  }

  void adicionarTarefa() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nova Tarefa"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Título"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                tarefas.add(Tarefa(titulo: controller.text));
                ordenar();
              });
              controller.clear();
              Navigator.pop(context);
            },
            child: const Text("Adicionar"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade400,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "Tarefas (${widget.dia.day}/${widget.dia.month}/${widget.dia.year})",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: adicionarTarefa,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (_, i) {
          final t = tarefas[i];
          return ListTile(
            leading: Checkbox(
              value: t.concluida,
              onChanged: (v) {
                setState(() {
                  t.concluida = v!;
                  ordenar();
                });
              },
            ),
            title: Text(
              t.titulo,
              style: TextStyle(
                decoration: t.concluida
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  tarefas.removeAt(i);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
