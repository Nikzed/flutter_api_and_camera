import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 370,
              decoration: const BoxDecoration(
                color: Color(0xffECF3F9),
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 350),
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
                        child: Obx(
                          () => Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xffECF3F9),
                              border: _controller.validate.value
                                  ? Border.all(color: Colors.red)
                                  : null,
                              borderRadius: BorderRadius.circular(20),
                            ),
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
                                    controller:
                                        _controller.phoneController.value,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      _controller.phoneMask.value
                                    ],
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
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: ElevatedButton(
                          onPressed: () async {
                            _controller.onButtonPressed();
                          },
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
                            Get.snackbar(
                              'Увага!',
                              'Допомога ще у розробці',
                              snackPosition: SnackPosition.BOTTOM,
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
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            Get.snackbar(
                              'Увага!',
                              'Питання теж ще у розробці..',
                              snackPosition: SnackPosition.BOTTOM,
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

  @override
  void dispose() {
    _controller.phoneController.value.dispose();
    super.dispose();
  }
}
