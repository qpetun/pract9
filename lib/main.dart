import 'dart:math'; // Импортируем пакет для работы с математическими функциями
import 'package:flutter/material.dart'; // Импортируем основной пакет Flutter
import 'package:cached_network_image/cached_network_image.dart'; // Импортируем пакет для загрузки изображений из сети
import 'package:get_it/get_it.dart'; // Импортируем пакет GetIt для DI контейнера

// Модель данных приложения
class AppModel {
  final String title;
  AppModel({required this.title});
}

// InheritedWidget для передачи модели данных
class AppModelProvider extends InheritedWidget {
  final AppModel model;

  AppModelProvider({required this.model, required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static AppModel of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AppModelProvider>())!.model;
  }
}

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AppModel>(AppModel(title: 'Navigation Пример'));
}

// Функция для асинхронной загрузки изображения по ссылке с имитацией задержки
Future<Widget?> _getImage(String imageUrl) async {
  // Имитация задержки загрузки картинки из интернета
  await Future.delayed(Duration(seconds: 3));

  // Возвращаем виджет с картинкой из интернета
  return Image.network(imageUrl, width: 320, height: 200, fit:BoxFit.fill);
}

// Основная функция для запуска приложения Flutter
void main() {
  setup(); // Настраиваем GetIt
  runApp(MyApp()); // Запускаем виджет MyApp
}

// Виджет приложения
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = getIt<AppModel>(); // Получаем модель из GetIt

    return AppModelProvider(
      model: appModel,
      child: MaterialApp(
        title: appModel.title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blueAccent,
              textStyle: TextStyle(fontSize: 18),
            ),
          ),
        ),
        initialRoute: '/', // Устанавливаем начальный маршрут
        routes: {
          '/': (context) => HomeScreen(), // Определяем маршрут для главного экрана
          '/screen1': (context) => Screen1(), // Определяем маршрут для экрана 1
          '/screen2': (context) => Screen2(), // Определяем маршрут для экрана 2
          '/screen3': (context) => Screen3(), // Определяем маршрут для экрана 3
          '/screen4': (context) => Screen4(), // Определяем маршрут для экрана 4
          '/screen5': (context) => Screen5(), // Определяем маршрут для экрана 5
        },

      ),
    );
  }
}

// Виджет главного экрана
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = AppModelProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appModel.title),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/screen1'); // Переходим на экран 1
              },
              child: Text('Страница 1'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/screen2'); // Переходим на экран 2
              },
              child: Text('Страница 2'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/screen3'); // Переходим на экран 3
              },
              child: Text('Страница 3'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/screen4'); // Переходим на экран 4
              },
              child: Text('Страница 4'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/screen5'); // Переходим на экран 5
              },
              child: Text('Страница 5'),
            ),
          ],
        ),
      ),
    );
  }
}

// Виджет для экрана 1
class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = AppModelProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appModel.title),
        backgroundColor: Colors.yellow,
      ),
      backgroundColor: Colors.yellowAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/image1.jpg', width: 320,height: 200,fit:BoxFit.fill), // Отображаем локальное изображение
            SizedBox(height: 20),
            FutureBuilder(
              future: _getImage('https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'), // Загружаем изображение из сети с задержкой
              builder: (context, AsyncSnapshot<Widget?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Ошибка загрузки данных');
                } else {
                  return Container(
                    child: snapshot.data,
                  );
                }
              },
            ),
            SizedBox(height: 20),
            CachedNetworkImage(
              imageUrl: 'https://images.unsplash.com/photo-1494905998402-395d579af36f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Загружаем изображение из сети с использованием CachedNetworkImage
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 320,
              height: 200,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Возвращаемся на предыдущий экран
              },
              child: Text('Назад'),
            ),
          ],
        ),

      ),
    );
  }
}

// Виджет для экрана 2
class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = AppModelProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appModel.title),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/image1.jpg',width: 320,height: 200,fit:BoxFit.fill),
            SizedBox(height: 20),
            FutureBuilder(
              future: _getImage('https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              builder: (context, AsyncSnapshot<Widget?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Ошибка загрузки данных');
                } else {
                  return Container(
                    child: snapshot.data,
                  );
                }
              },
            ),
            SizedBox(height: 20),
            CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1493238792000-8113da705763?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 320,
                height: 200,
                fit:BoxFit.fill
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}

// Виджет для экрана 3
class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = AppModelProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appModel.title),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/image1.jpg',width: 320,height: 200,fit:BoxFit.fill),
            SizedBox(height: 20),
            FutureBuilder(
              future: _getImage('https://images.unsplash.com/photo-1482062364825-616fd23b8fc1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              builder: (context, AsyncSnapshot<Widget?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Ошибка загрузки данных');
                } else {
                  return Container(
                    child: snapshot.data,
                  );
                }
              },
            ),
            SizedBox(height: 20),
            CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1441742917377-57f78ee0e582?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 320,
                height: 200,
                fit:BoxFit.fill
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}

// Виджет для экрана 4
class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = AppModelProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appModel.title),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.purpleAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/image1.jpg',width: 320,height: 200,fit:BoxFit.fill),
            SizedBox(height: 20),
            FutureBuilder(
              future: _getImage('https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              builder: (context, AsyncSnapshot<Widget?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Ошибка загрузки данных');
                } else {
                  return Container(
                    child: snapshot.data,
                  );
                }
              },
            ),
            SizedBox(height: 20),
            CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1528738060457-5d94d6d67c47?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 320,
                height: 200,
                fit:BoxFit.fill
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}

// Виджет для экрана 5
class Screen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = AppModelProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appModel.title),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/image1.jpg',width: 320,height: 200,fit:BoxFit.fill),
            SizedBox(height: 20),
            FutureBuilder(
              future: _getImage('https://images.unsplash.com/photo-1549888834-31ff6963e1c4?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              builder: (context, AsyncSnapshot<Widget?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Ошибка загрузки данных');
                } else {
                  return Container(
                    child: snapshot.data,
                  );
                }
              },
            ),
            SizedBox(height: 20),
            CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1485182708500-e8f1f318ba72?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 320,
                height: 200,
                fit:BoxFit.fill
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}
