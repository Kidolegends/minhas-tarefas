import 'package:flutter/material.dart';

class TarefasWidget extends StatefulWidget {
  final DateTime data;

  const TarefasWidget({super.key, required this.data});

  @override
  State<TarefasWidget> createState() => _TarefasWidgetState();
}

class _TarefasWidgetState extends State<TarefasWidget> {
  List<Map<String, dynamic>> tarefas = [];

  void adicionarTarefa() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Adicionar tarefa"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: "Descrição da tarefa",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    tarefas.add({
                      "descricao": controller.text.trim(),
                      "concluida": false
                    });
                    ordenarLista();
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("Adicionar"),
            ),
          ],
        );
      },
    );
  }

  void ordenarLista() {
    tarefas.sort((a, b) {
      if (a["concluida"] == b["concluida"]) {
        return a["descricao"].compareTo(b["descricao"]);
      }
      return a["concluida"] ? 1 : -1; // pendente primeiro
    });
  }

  @override
  Widget build(BuildContext context) {
    String dataTexto =
        "${widget.data.day}/${widget.data.month}/${widget.data.year}";

    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas de $dataTexto"),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: adicionarTarefa,
        child: const Icon(Icons.add),
      ),
      body: tarefas.isEmpty
          ? const Center(
        child: Text(
          "Nenhuma tarefa adicionada 🤔",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (_, index) {
          final tarefa = tarefas[index];

          return Card(
            child: ListTile(
              leading: Checkbox(
                value: tarefa["concluida"],
                onChanged: (v) {
                  setState(() {
                    tarefa["concluida"] = v!;
                    ordenarLista();
                  });
                },
              ),
              title: Text(
                tarefa["descricao"],
                style: TextStyle(
                  decoration: tarefa["concluida"]
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    tarefas.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
