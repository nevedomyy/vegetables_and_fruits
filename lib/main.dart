import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget{
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> with TickerProviderStateMixin{
  static List<Widget> _list = List(24);
  static List<Color> _colors = List(24);
  static List<String> _text = List(24);
  static List<Image> _images = List(24);

  @override
  void initState(){
    for (var i=0; i<24; i++){
      _images[i] = Image.asset('assets/$i.png', fit: BoxFit.scaleDown);
    }
    _colors = [
      Color.fromRGBO(248, 64, 15, 1.0),
      Color.fromRGBO(252, 202, 15, 1.0),
      Color.fromRGBO(81, 88, 129, 1.0),
      Color.fromRGBO(223, 155, 4, 1.0),
      Color.fromRGBO(245, 185, 2, 1.0),
      Color.fromRGBO(52, 59, 60, 1.0),
      Color.fromRGBO(220, 36, 30, 1.0),
      Color.fromRGBO(88, 58, 84, 1.0),
      Color.fromRGBO(120, 166, 6, 1.0),
      Color.fromRGBO(247, 152, 77, 1.0),
      Color.fromRGBO(233, 122, 36, 1.0),
      Color.fromRGBO(209, 32, 24, 1.0),
      Color.fromRGBO(70, 106, 1, 1.0),
      Color.fromRGBO(225, 4, 2, 1.0),
      Color.fromRGBO(187, 27, 41, 1.0),
      Color.fromRGBO(92, 62, 73, 1.0),
      Color.fromRGBO(254, 121, 5, 1.0),
      Color.fromRGBO(76, 150, 52, 1.0),
      Color.fromRGBO(157, 42, 44, 1.0),
      Color.fromRGBO(247, 67, 8, 1.0),
      Color.fromRGBO(200, 142, 109, 1.0),
      Color.fromRGBO(54, 15, 18, 1.0),
      Color.fromRGBO(97, 153, 58, 1.0),
      Color.fromRGBO(160, 191, 32, 1.0),
    ];
    _text = [
      'Арбуз',
      'Банан',
      'Виноград',
      'Груша',
      'Дыня',
      'Ежевика',
      'Земляника',
      'Инжир',
      'Капуста',
      'Лук',
      'Морковь',
      'Нектарин',
      'Огурец',
      'Помидор',
      'Редис',
      'Слива',
      'Тыква',
      'Укроп',
      'Фасоль',
      'Хурма',
      'Чеснок',
      'Шелковица',
      'Щавель',
      'Яблоко'
    ];
    super.initState();
  }

  List _items(BuildContext context){
    for (var i=0; i<24; i++){
      _list[i] = (SizedBox(
          child: GestureDetector(
            child: Center(
              child: Hero(
                tag: _text[i],
                child: AnimatedSize(
                    vsync: this,
                    duration: Duration(milliseconds: 70-i),
                    curve: Curves.elasticIn,
                    child: SizedBox(
                      child: _images[i],
                    )
                ),
              ),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_){
                return SecondPage(_images[i], _colors[i], _text[i]);
              }));
            },
          )
      ));
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Center(
              child: Text(
                'Фрукты и Овощи',
                style: TextStyle(fontSize: 35.0, fontFamily: 'Pacifico-Regular', color: Colors.green),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(60.0)
      ),
      body: Center(
        child: ScrollConfiguration(
          behavior: _Behavior(),
          child: GridView.count(
            shrinkWrap: true,
            padding: EdgeInsets.all(16.0),
            crossAxisSpacing: 0.0,
            crossAxisCount: 4,
            children: _items(context),
          ),
        ),
      ),
    );
  }
}

class _Behavior extends ScrollBehavior{
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class SecondPage extends StatefulWidget {
  Image _image;
  Color _color;
  String _text;
  SecondPage(this._image, this._color, this._text);
  @override
  _SecondPage createState() => _SecondPage(_image, _color, _text);
}

class _SecondPage extends State<SecondPage>{
  Image _image;
  Color _color;
  String _text;
  double _textOpacity = 0.0;

  _SecondPage(this._image, this._color, this._text);

  @override
  Widget build(BuildContext context) {
    _textOpacity = _textOpacity == 1.0 ? 0.0 : 1.0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Center(
              child: Opacity(
                opacity: _textOpacity,
                child: Text(
                  _text,
                  style: TextStyle(fontSize: 35.0, fontFamily: 'Pacifico-Regular', color: _color),
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(60.0)
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Center(
                  child: Hero(
                    tag: _text,
                    child: _image,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                    child: Opacity(
                      opacity: _textOpacity,
                      child: Text(
                        _text[0]+_text[0].toLowerCase(),
                        style: TextStyle(color: _color, fontSize: 80.0, fontFamily: 'Pacifico-Regular'),
                      ),
                    )
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: (){
              setState((){});
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}