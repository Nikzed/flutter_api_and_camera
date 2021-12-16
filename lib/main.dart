import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _phoneMask = MaskTextInputFormatter(
    mask: '(##) ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 420,
              decoration: const BoxDecoration(
                color: Color(0xffECF3F9),
                image: DecorationImage(
                  image: AssetImage('assets/background_car_washer.png'),
                  // fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Мийки',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          alignment: Alignment.center,
                          color: const Color(0xff00B7F1),
                          height: 40,
                          width: 50,
                          child: const Text(
                            '24',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Сплачуй на різних мийках самооблуговування одним додатком зі знижками',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // const SizedBox(height: 200),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 400),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Увійти / Зареєструватись',
                      style: TextStyle(
                          color: Color(0xff99879D),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          // padding: const EdgeInsets.only(left: 20),
                          color: const Color(0xffECF3F9),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 110,
                                // color: Colors.black,
                                child: CountryCodePicker(
                                  onChanged: print,
                                  initialSelection: '+380',
                                  favorite: const ['+380', '+7'],
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [_phoneMask],
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Введіть номер телефону',
                                    hintStyle: TextStyle(
                                      color: Color(0xff99879D),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Далі',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            elevation: MaterialStateProperty.all<double>(5),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xff06C975),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Виникли труднощі?',
                    style: TextStyle(
                      color: Color(0xff99879D),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      // letterSpacing: 0.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xff00B7F1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => {
                            _messengerKey.currentState?.showSnackBar(
                              const SnackBar(
                                content: Text('Допомога ще у розробці'),
                              ),
                            ),
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: SizedBox(
                                    width: 50,
                                    child: SvgPicture.asset(
                                      'assets/headphones.svg',
                                    ),
                                  ),
                                ),
                                const TextSpan(text: 'Допомога'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 0,
                          child: Text(
                            '|',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.w100
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            _messengerKey.currentState?.showSnackBar(
                              const SnackBar(
                                content: Text('Питання теж ще у розробці..'),
                              ),
                            ),
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: SizedBox(
                                    width: 50,
                                    child: SvgPicture.asset(
                                      'assets/question.svg',
                                    ),
                                  ),
                                ),
                                const TextSpan(text: 'Питання'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
