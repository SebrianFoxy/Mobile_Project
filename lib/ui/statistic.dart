import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './navigation.dart';

class statistic extends StatefulWidget {
  const statistic({super.key});

  @override
  State<statistic> createState() => _statisticState();
}

class _statisticState extends State<statistic> {
  late Future<void> userStatistic;
  User? user;
  int? usersLevels;

  @override
  void initState(){
    super.initState();
    userStatistic = loadStatistic();
  }

  Future<void> loadStatistic() async{
    try{
      user = Supabase.instance.client.auth.currentUser;
      dynamic usrID = (await Supabase.instance.client
          .from('Users')
          .select('id')
          .eq('Email', user?.email))[0]['id'] as int;
      dynamic LevelsCmplted = ((await Supabase.instance.client
          .from('InfoFromLevels')
          .select('LevelsCompleted')
          .eq('UserId', usrID))[0]['LevelsCompleted']);
      setState(() {
        usersLevels = int.parse(LevelsCmplted.toString());
        usersLevels = usersLevels! - 1;
      });
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: userStatistic,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Произошла ошибка при загрузке данных'),
            );
          } else{
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.black,
                toolbarHeight: 80, // Установите желаемую высоту AppBar
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30), // Установите радиус закругления здесь
                  ),
                ),
                title: Text(
                  'Статистика',
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
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Количество пройденных уровней:',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.green,
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [0.0, usersLevels! * 0.01],
                              ),
                            ),
                          ),
                          Text(
                            usersLevels.toString(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            bottomNavigationBar: navigation(),
            );     
          }
        }
    
  );
  }
}