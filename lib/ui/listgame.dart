import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import './navigation.dart';

class ListGame extends StatefulWidget {
  const ListGame({super.key});

  @override
  _ListGameState createState() => _ListGameState();
}

class _ListGameState extends State<ListGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 224, 224),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 216, 39, 39),
        title: Text(
          'Список уровней',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontFamily: 'Nexa',
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 2,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Определяет количество кнопок в каждом ряду
          childAspectRatio: 1.0, // Определяет соотношение ширины и высоты каждой ячейки
        ),
        padding: EdgeInsets.all(16),
        itemCount: 18,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {

            },
            child: Container(
              width: 30, // Ширина контейнера кнопки
              height: 30, // Высота контейнера кнопки
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 81, 221, 144),
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.all(8),
              child: Center(
                child: Text(
                  '${index + 1}', // Нумерация кнопок
                  style: TextStyle(
                    fontSize: 28, // Размер текста кнопки
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: navigation(),
    );
  }
}

