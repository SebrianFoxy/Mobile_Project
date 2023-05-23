import 'package:cognitivyskills/ui/startHome.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class profilemenu extends StatefulWidget {
  const profilemenu({super.key});

  @override
  State<profilemenu> createState() => _profilemenuState();
}

class _profilemenuState extends State<profilemenu> {
  late Future<void> userDataFuture;
  User? user;
  String? myEmail;
  String? myName;
  String _imagePath = 'assets/images/avatar_no.png';
  bool isFirstStart = true;

  @override
  void initState() {
    super.initState();
    userDataFuture = loadUserData();
  }
  Future _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _saveImageToAppDirectory(
        imageFile: File(pickedImage.path),
      ); // Сохранить изображение в директорию приложения
    }
  }

  Future<void> _saveImageToAppDirectory({required File imageFile}) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'selected_image.jpg';
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    setState(() {
      _imagePath = savedImage.path; // Обновить путь к изображению
      isFirstStart = false;
    });
  }

  Future<void> loadUserData() async {
    try {
      user = Supabase.instance.client.auth.currentUser;
      final response = await Supabase.instance.client
          .from('Users')
          .select('UserName')
          .eq('Email', user!.email) as List<dynamic>;

      if (user != null) {
        setState(() {
          myEmail = user!.email;
          myName = response[0]['UserName'] as String;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: userDataFuture,
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
              backgroundColor: Colors.pink[100],
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(200.0),
                child: AppBar(
                  flexibleSpace: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectImage();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: isFirstStart ? Image.asset(_imagePath).image: FileImage(File(_imagePath),),
                            radius: 70,
                          ),
                        ),
                        Text(
                          '$myName',
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
                      ],
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Color.fromARGB(255, 216, 39, 39),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(1000.0), // Закругление внизу слева
                      bottomRight: Radius.circular(1000.0), // Закругление внизу справа
                    ),
                  ),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                          mainAxisSize: MainAxisSize.min, // Added to limit the row width
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [ Text('Подписка', style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),),
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          ),
                      ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 59, 41, 223),
                        minimumSize: Size(300,55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Настройки', style: TextStyle(
                      fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(300,55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Центр помощи', style: TextStyle(
                      fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(300,55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Условие использования',style: TextStyle(
                      fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(300,55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Вы вышли с аккаунта')),
                        );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => startHome()),
                          (route) => false,
                        );
                        await signOutWithEmailAndPassword();
                      },
                      child: Text('Выход',style: TextStyle(
                      fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: Size(300,55),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ));
          }
        },
      );
    }
  }
    
