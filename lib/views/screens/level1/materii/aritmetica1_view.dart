/// Flutter
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lima/views/components/exercise_card/exercise_card.dart';

class Aritmetica1View extends StatefulWidget {
  Aritmetica1View({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Aritmetica1ViewState();
}

class Aritmetica1ViewState extends State<Aritmetica1View> {
  Aritmetica1ViewState({Key? key});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: constraints.maxWidth / 4, 
                    height: constraints.maxHeight / 5,
                    child: ExerciseCard(
                        label: 'Adunare şi scădere',
                        icon: Iconsax.math,
                        onStart: () => print('adunare si scadere - start'),
                        onHelp: () => print('adunare si scadere - help')),
                  ),
                  SizedBox(width: constraints.maxWidth / 20),
                  Container(
                    width: constraints.maxWidth / 4, 
                    height: constraints.maxHeight / 5,
                    child: ExerciseCard(
                        label: 'Fracţii',
                        icon: Iconsax.math,
                        onStart: () => print('fractii - start'),
                        onHelp: () => print('fractii - help')),
                  ),
                ]),
            SizedBox(height: constraints.maxHeight / 25),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: constraints.maxWidth / 4, 
                    height: constraints.maxHeight / 5,
                    child: ExerciseCard(
                        label: 'Ordine de şiruri',
                        icon: Iconsax.arrow_3,
                        onStart: () => print('ordine de siruri - start'),
                        onHelp: () => print('ordine de siruri  - help')),
                  ),
                  SizedBox(width: constraints.maxWidth / 20),
                  Container(
                    width: constraints.maxWidth / 4, 
                    height: constraints.maxHeight / 5,
                    child: ExerciseCard(
                        label: 'Formarea numerelor',
                        icon: Iconsax.math,
                        onStart: () => print('formarea numerelor - start'),
                        onHelp: () => print('formarea numerelor - help')),
                  ),
                ])
          ])),
    );
  }
}
