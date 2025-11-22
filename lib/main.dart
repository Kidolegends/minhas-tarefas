import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'tarefas_widget.dart';

void main() {
  runApp(const MinhasTarefasApp());
}

class MinhasTarefasApp extends StatelessWidget {
  const MinhasTarefasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minhas Tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const LoginPage(),
    );
  }
}

// -------------------------------
// LOGIN & CADASTRO
// -------------------------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool cadastrar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          width: 330,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 8)
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.list_alt, size: 60, color: Colors.deepPurple),
              const SizedBox(height: 16),
              Text(
                cadastrar ? "Cadastrar" : "Entrar",
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 22),

              const TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              const TextField(
                decoration: InputDecoration(
                  labelText: "Senha",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 22),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  minimumSize: const Size(double.infinity, 45),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CalendarioPage()),
                  );
                },
                child: Text(cadastrar ? "Cadastrar" : "Entrar",
                  style: const TextStyle(color: Colors.white)
                ),
              ),

              const SizedBox(height: 12),

              GestureDetector(
                onTap: () {
                  setState(() => cadastrar = !cadastrar);
                },
                child: Text(
                  cadastrar
                      ? "Já tem conta? Entrar"
                      : "Não tem conta? Cadastre-se",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------
// TELA DE CALENDÁRIO
// -------------------------------
class CalendarioPage extends StatefulWidget {
  const CalendarioPage({super.key});

  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  DateTime diaSelecionado = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text("Calendário"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          TableCalendar(
            focusedDay: diaSelecionado,
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            selectedDayPredicate: (day) =>
            day.day == diaSelecionado.day &&
                day.month == diaSelecionado.month &&
                day.year == diaSelecionado.year,
            onDaySelected: (selectedDay, _) {
              setState(() {
                diaSelecionado = selectedDay;
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.deepPurple.shade200,
                shape: BoxShape.circle,
              ),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              minimumSize: const Size(200, 45),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TarefasWidget(data: diaSelecionado),
                ),
              );
            },
            child: const Text("Ver tarefas do dia",
                style: const TextStyle(color: Colors.white,)
            ),
          ),
        ],
      ),
    );
  }
}
