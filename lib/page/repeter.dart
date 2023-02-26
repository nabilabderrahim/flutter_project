import 'package:flutter/material.dart';

import 'auto.dart';

int year = DateTime.now().year;
List<UserYea> Lyear = [];
List<int> Lyeart = [];
bool selectAllYea = false;
List<int> LyearC = [];
List<int> PersoYear = [];
tabyear() {
  for (int j = 0; j < 11; j++) {
    Lyear.add(UserYea((year + j).toString()));
    LyearC.add(year + j);
  }
}

Persoyea() {
  for (int y = 0; y < Lyeart.length; y++) {
    PersoYear.add(int.parse(Lyear[Lyeart[y]].name));
  }
  print('mouchhh' + PersoYear.toString());
}

List<UserMi> minu = [
  UserMi(':00'),
  UserMi(':01'),
  UserMi(':02'),
  UserMi(':03'),
  UserMi(':04'),
  UserMi(':05'),
  UserMi(':06'),
  UserMi(':07'),
  UserMi(':08'),
  UserMi(':09'),
  UserMi(':10'),
  UserMi(':11'),
  UserMi(':12'),
  UserMi(':13'),
  UserMi(':14'),
  UserMi(':15'),
  UserMi(':16'),
  UserMi(':17'),
  UserMi(':18'),
  UserMi(':19'),
  UserMi(':20'),
  UserMi(':21'),
  UserMi(':22'),
  UserMi(':23'),
  UserMi(':24'),
  UserMi(':25'),
  UserMi(':26'),
  UserMi(':27'),
  UserMi(':28'),
  UserMi(':29'),
  UserMi(':30'),
  UserMi(':31'),
  UserMi(':32'),
  UserMi(':33'),
  UserMi(':34'),
  UserMi(':35'),
  UserMi(':36'),
  UserMi(':37'),
  UserMi(':38'),
  UserMi(':39'),
  UserMi(':40'),
  UserMi(':41'),
  UserMi(':42'),
  UserMi(':43'),
  UserMi(':44'),
  UserMi(':45'),
  UserMi(':46'),
  UserMi(':47'),
  UserMi(':48'),
  UserMi(':49'),
  UserMi(':50'),
  UserMi(':51'),
  UserMi(':52'),
  UserMi(':53'),
  UserMi(':54'),
  UserMi(':55'),
  UserMi(':56'),
  UserMi(':57'),
  UserMi(':58'),
  UserMi(':59'),
];

List<User> data = [
  User('Su'),
  User(' Mo'),
  User('Tu'),
  User('We'),
  User('Th'),
  User('Fr'),
  User('Sa'),
];
List<UserW> corcess = [
  UserW('01'),
  UserW('02'),
  UserW('03'),
  UserW('04'),
  UserW('05'),
  UserW('06'),
  UserW('07'),
  UserW('08'),
  UserW('09'),
  UserW('10'),
  UserW('11'),
  UserW('12'),
  UserW('13'),
  UserW('14'),
  UserW('15'),
  UserW('16'),
  UserW('17'),
  UserW('18'),
  UserW('19'),
  UserW('20'),
  UserW('21'),
  UserW('22'),
  UserW('23'),
  UserW('24'),
  UserW('25'),
  UserW('26'),
  UserW('27'),
  UserW('28'),
  UserW('29'),
  UserW('30'),
  UserW('31'),
];
List<UserH> dataH = [
  UserH('00h'),
  UserH('01h'),
  UserH('02h'),
  UserH('03h'),
  UserH('04h'),
  UserH('05h'),
  UserH('06h'),
  UserH('07h'),
  UserH('08h'),
  UserH('09h'),
  UserH('10h'),
  UserH('11h'),
  UserH('12h'),
  UserH('13h'),
  UserH('14h'),
  UserH('15h'),
  UserH('16h'),
  UserH('17h'),
  UserH('18h'),
  UserH('19h'),
  UserH('20h'),
  UserH('21h'),
  UserH('22h'),
  UserH('23h'),
];
List<UserM> dataM = [
  UserM('Ja'),
  UserM('Fé'),
  UserM('Ma'),
  UserM('Av'),
  UserM('Mai'),
  UserM('Ju'),
  UserM('Jui'),
  UserM('Aou'),
  UserM('Sep'),
  UserM('Oct'),
  UserM('Nov'),
  UserM('Déc'),
];
List<int> WdayC = [0, 1, 2, 3, 4, 5, 6];

List<int> dayC = [
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31
];
List<int> monthC = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
List<int> hourC = [
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23
];
List<int> minuC = [
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31,
  32,
  33,
  34,
  35,
  36,
  37,
  38,
  39,
  40,
  41,
  42,
  43,
  44,
  45,
  46,
  47,
  48,
  49,
  50,
  51,
  52,
  53,
  54,
  55,
  56,
  57,
  58,
  59
];
bool selectAllMi = false;
bool selectAllH = false;
bool selectAll = false;
bool selectAllD = false;
bool selectAllM = false;
List<int> minut = [];
List<int> days = [];
List<int> hour = [];
List<int> Wday = [];
List<int> months = [];

class Repeter extends StatefulWidget {
  const Repeter({Key? key}) : super(key: key);

  @override
  State<Repeter> createState() => _RepeterState();
}

class _RepeterState extends State<Repeter> {
  @override
  void initState() {
    tabyear();
    PersoYear.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Repeter'),
        ),
        body: ListView(scrollDirection: Axis.vertical, children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Color.fromRGBO(130, 196, 252, 1.0),
                child: SafeArea(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text('All Minutes'),
                        Checkbox(
                            value: selectAllMi,
                            onChanged: (bool? value) {
                              setState(() {
                                if (!selectAllMi) {
                                  minut.clear();
                                  print('hello');
                                }
                                if (selectAllMi) {
                                  minut.clear();
                                  print('mmm');
                                }
                                selectAllMi = value!;

                                minut.clear();
                                minu.forEach((element) {
                                  element.selected = value;
                                  if (element.selected == true) minut = minuC;
                                });
                              });
                            }),
                      ],
                    ),
                    SafeArea(
                      child: SafeArea(
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: minu.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 50,
                                    childAspectRatio: 1 / 1,
                                    crossAxisSpacing: 100,
                                    mainAxisSpacing: 100),
                            itemBuilder: (context, index) {
                              return GridTile(
                                  child: Container(
                                      color: Colors.blue[200],
                                      alignment: Alignment.center,
                                      child: prepareListMi(index)));
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Color.fromRGBO(144, 202, 249, 1.0),
                child: SafeArea(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text('All Hours'),
                        Checkbox(
                            value: selectAllH,
                            onChanged: (bool? value) {
                              setState(() {
                                if (!selectAllH) {
                                  hour.clear();
                                  print('hello');
                                }
                                if (selectAllH) {
                                  hour.clear();
                                  print('mmm');
                                }
                                selectAllH = value!;

                                hour.clear();
                                dataH.forEach((element) {
                                  element.selected = value;
                                  if (element.selected == true) hour = hourC;
                                });
                              });
                            }),
                      ],
                    ),
                    SafeArea(
                      child: SafeArea(
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: dataH.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 50,
                                    childAspectRatio: 1 / 1,
                                    crossAxisSpacing: 50,
                                    mainAxisSpacing: 50),
                            itemBuilder: (context, index) {
                              return GridTile(
                                  child: Container(
                                      color: Colors.blue[200],
                                      alignment: Alignment.center,
                                      child: prepareListH(index)));
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Color.fromRGBO(144, 202, 249, 1.0),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text('All WeekDays'),
                        Checkbox(
                            value: selectAllD,
                            onChanged: (bool? value) {
                              setState(() {
                                if (!selectAllD) {
                                  print('helloD');
                                }
                                if (selectAllD) {
                                  print('mmmD');
                                }
                                selectAllD = value!;
                                Wday.clear();
                                data.forEach((element) {
                                  element.selected = value;
                                  if (element.selected == true) Wday = WdayC;
                                });
                              });
                            }),
                      ],
                    ),
                    SafeArea(
                        child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (ctx, index) {
                          return GridTile(
                              child: Container(
                                  color: Colors.blue[200],
                                  alignment: Alignment.center,
                                  child: prepareListD(index)));
                        },
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 50,
                                childAspectRatio: 1 / 1,
                                crossAxisSpacing: 50,
                                mainAxisSpacing: 50),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Color.fromRGBO(144, 202, 249, 1.0),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text('All Days'),
                        Checkbox(
                            value: selectAll,
                            onChanged: (bool? value) {
                              setState(() {
                                selectAll = value!;
                                days.clear();
                                corcess.forEach((element) {
                                  element.selected = value;
                                  if (element.selected == true) days = dayC;
                                });
                              });
                            }),
                      ],
                    ),
                    SafeArea(
                        child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return GridTile(
                              child: Container(
                                  color: Colors.blue[200],
                                  alignment: Alignment.center,
                                  child: prepareList(index)));
                        },
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 50,
                                childAspectRatio: 1 / 1,
                                crossAxisSpacing: 50,
                                mainAxisSpacing: 50),
                        itemCount: corcess.length,
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Color.fromRGBO(144, 202, 249, 1.0),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text('All monthss'),
                        Checkbox(
                            value: selectAllM,
                            onChanged: (bool? value) {
                              setState(() {
                                selectAllM = value!;
                                months.clear();
                                dataM.forEach((element) {
                                  element.selected = value;
                                  if (element.selected == true) months = monthC;
                                });
                              });
                            }),
                      ],
                    ),
                    SafeArea(
                        child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return GridTile(
                              child: Container(
                                  color: Colors.blue[200],
                                  alignment: Alignment.center,
                                  child: prepareListM(index)));
                        },
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 50,
                                childAspectRatio: 1 / 1,
                                crossAxisSpacing: 50,
                                mainAxisSpacing: 50),
                        itemCount: dataM.length,
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Color.fromRGBO(144, 202, 249, 1.0),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text('All Years'),
                        Checkbox(
                            value: selectAllYea,
                            onChanged: (bool? value) {
                              setState(() {
                                selectAllYea = value!;
                                Lyeart.clear();
                                Lyear.forEach((element) {
                                  element.selected = value;
                                  if (element.selected == true) Lyeart = LyearC;
                                });
                              });
                            }),
                      ],
                    ),
                    SafeArea(
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Lyear.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 50,
                                  childAspectRatio: 1 / 1,
                                  crossAxisSpacing: 100,
                                  mainAxisSpacing: 100),
                          itemBuilder: (context, index) {
                            return GridTile(
                                child: Container(
                                    color: Colors.blue[200],
                                    alignment: Alignment.center,
                                    child: prepareListYear(index)));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                print(minut);
                print(hour);
                print(Wday);
                print(days);
                print(months);
                personnel[0] = hour;
                personnel[1] = Wday;
                personnel[2] = days;
                personnel[3] = months;
                personnel[4] = minut;
                personnel[5] = Lyeart;
                print(personnel);
                Persoyea();
                Navigator.pushNamed(context, '/Automatique',
                    arguments: {repeter, personnel, PersoYear});
              },
              child: Text('Enregistrer'))
        ]));
  }

  Widget prepareListMi(int k) {
    return Card(
      child: Hero(
        tag: minu[k],
        child: Material(
          child: InkWell(
            onTap: () {},
            child: Container(
              color: Color.fromRGBO(130, 196, 252, 1.0),
              height: 100,
              child: Stack(
                children: [
                  Center(
                      child: Text(
                    minu[k].name,
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  )),
                  Positioned(
                      child: Checkbox(
                    value: minu[k].selected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (!value!) selectAllMi = false;
                        minu[k].selected = value;
                        if (minu[k].selected == true) minut.add(k);
                        if (minu[k].selected == false) minut.remove(k);
                      });
                    },
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget prepareListH(int k) {
    return Card(
      child: Hero(
        tag: dataH[k],
        child: Material(
          child: InkWell(
            onTap: () {},
            child: Container(
              color: Color.fromRGBO(130, 196, 252, 1.0),
              height: 1000,
              child: Stack(
                children: [
                  Center(
                      child: Text(
                    dataH[k].name,
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  )),
                  Positioned(
                      child: Checkbox(
                    value: dataH[k].selected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (!value!) selectAllH = false;
                        dataH[k].selected = value;
                        if (dataH[k].selected == true) hour.add(k);
                        if (dataH[k].selected == false) hour.remove(k);
                      });
                    },
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget prepareListD(int k) {
    return Card(
      child: Hero(
        tag: data[k],
        child: Material(
          child: InkWell(
            onTap: () {},
            child: Container(
              color: Color.fromRGBO(130, 196, 252, 1.0),
              height: 1000,
              child: Stack(
                children: [
                  Center(
                      child: Text(
                    data[k].name,
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  )),
                  Positioned(
                      child: Checkbox(
                    value: data[k].selected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (!value!) selectAllD = false;
                        data[k].selected = value;
                        if (data[k].selected == true) Wday.add(k);
                        if (data[k].selected == false) Wday.remove(k);
                        /*
                                  element.selected = value;
                                  val.add(element.name.toString());
                                  day.replaceRange(0, day.length, val);*/
                      });
                    },
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget prepareList(int k) {
    return Card(
      child: Hero(
        tag: "text$k",
        child: Material(
          child: InkWell(
            onTap: () {},
            child: Container(
              color: Color.fromRGBO(130, 196, 252, 1.0),
              height: 1000,
              child: Stack(
                children: [
                  Center(
                      child: Text(
                    corcess[k].name,
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  )),
                  Positioned(
                      child: Checkbox(
                    value: corcess[k].selected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (!value!) selectAll = false;
                        {
                          corcess[k].selected = value;
                          if (corcess[k].selected == true) days.add(k + 1);
                          if (corcess[k].selected == false) days.remove(k + 1);
                        }
                      });
                    },
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget prepareListM(int k) {
    return Card(
      child: Hero(
        tag: dataM[k],
        child: Material(
          child: InkWell(
            onTap: () {},
            child: Container(
              color: Color.fromRGBO(130, 196, 252, 1.0),
              height: 100,
              child: Stack(
                children: [
                  Center(
                      child: Text(
                    dataM[k].name,
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  )),
                  Positioned(
                      child: Checkbox(
                    value: dataM[k].selected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (!value!) selectAllM = false;
                        dataM[k].selected = value;
                        if (dataM[k].selected == true) months.add(k + 1);
                        if (dataM[k].selected == false) months.remove(k + 1);
                      });
                    },
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget prepareListYear(int k) {
    return Card(
      child: Hero(
        tag: Lyear[k],
        child: Material(
          child: InkWell(
            onTap: () {},
            child: Container(
              color: Color.fromRGBO(130, 196, 252, 1.0),
              height: 100,
              child: Stack(
                children: [
                  Center(
                      child: Text(
                    Lyear[k].name,
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  )),
                  Positioned(
                      child: Checkbox(
                    value: Lyear[k].selected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (!value!) selectAllYea = false;
                        Lyear[k].selected = value;
                        if (Lyear[k].selected == true) Lyeart.add(k);
                        if (Lyear[k].selected == false) Lyeart.remove(k);
                      });
                    },
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class User {
  User(this.name, {this.selected = false});

  String name;
  bool selected;
}

class UserM {
  UserM(this.name, {this.selected = false});

  String name;
  bool selected;
}

class UserH {
  UserH(this.name, {this.selected = false});

  String name;
  bool selected;
}

class UserW {
  UserW(this.name, {this.selected = false});

  String name;
  bool selected;
}

class UserMi {
  UserMi(this.name, {this.selected = false});

  String name;
  bool selected;
}

class UserYea {
  UserYea(this.name, {this.selected = false});

  String name;
  bool selected;
}

clearR() {
  repeter.clear();
}
