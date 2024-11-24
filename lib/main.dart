import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa provider para usar ChangeNotifier
import 'dart:math'; // Para generar números aleatorios

void main() {
  runApp(
    // Proveer el estado de la aplicación a todos los widgets
    ChangeNotifierProvider(
      create: (_) => MyAppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generador de Palabras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // Lista de palabras propias para generar pares de palabras
  final List<String> _words = [
    'Flutter', 'Dart', 'Android', 'iOS', 'Mobile', 'App', 'Code', 'Developer', 'Programming', 'Design',
    'Web', 'Tech', 'GitHub', 'API', 'Cloud', 'JavaScript', 'Python', 'CSharp', 'Java', 'Swift', 'Ruby'
  ];

  late String _firstWord;
  late String _secondWord;

  MyAppState() {
    _generateRandomPair();
  }

  // Getter para obtener el par de palabras actual
  String get firstWord => _firstWord;
  String get secondWord => _secondWord;

  // Método para generar un nuevo par de palabras aleatorias
  void _generateRandomPair() {
    final random = Random();
    _firstWord = _words[random.nextInt(_words.length)];
    _secondWord = _words[random.nextInt(_words.length)];
    notifyListeners(); // Notifica a los widgets que están escuchando para que se reconstruyan
  }

  // Método para cambiar al siguiente par de palabras
  void getNext() {
    _generateRandomPair();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>(); // Ahora watch funciona correctamente

    return Scaffold(
      appBar: AppBar(
        title: Text('Generador de Palabras'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(firstWord: appState.firstWord, secondWord: appState.secondWord), // Pasa las palabras a BigCard
          Text('${appState.firstWord} ${appState.secondWord}'),
          ElevatedButton(
            onPressed: () {
              appState.getNext(); // Llama a getNext cuando se presiona el botón
            },
            child: Text('Siguiente'),
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  final String firstWord;
  final String secondWord;

  const BigCard({
    super.key,
    required this.firstWord, // Acepta la primera palabra
    required this.secondWord, // Acepta la segunda palabra
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          '$firstWord $secondWord', // Muestra el par de palabras
          style: style,
        ),
      ),
    );
  }
}
