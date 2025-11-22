import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TarefasWidget extends StatefulWidget {
  const TarefasWidget({super.key});

  @override
  State<TarefasWidget> createState() => _TarefasWidgetState();
}

class _TarefasWidgetState extends State<TarefasWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<String>> _tarefas = {
    DateTime(2025, 1, 5): ["Comprar farinha", "Verificar estoque de pães"],
    DateTime(2025, 1, 6): ["Ligar para fornecedor"],
  };

  List<String> _getTarefasForDay(DateTime day) {
    return _tarefas[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: _focusedDay,
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarFormat: CalendarFormat.month,
          availableGestures: AvailableGestures.all,
        ),

        const SizedBox(height: 16),

        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.brown.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.brown.shade200),
            ),
            child: _selectedDay == null
                ? const Center(
              child: Text(
                "Selecione um dia no calendário",
                style: TextStyle(color: Colors.grey),
              ),
            )
                : ListView(
              children: _getTarefasForDay(_selectedDay!).isEmpty
                  ? [
                const Text(
                  "Nenhuma tarefa para este dia.",
                  style: TextStyle(fontSize: 16),
                )
              ]
                  : _getTarefasForDay(_selectedDay!).map((tarefa) {
                return Card(
                  child: ListTile(
                    title: Text(tarefa),
                    trailing: const Icon(Icons.check_circle_outline),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
