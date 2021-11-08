import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:mse_yonsei/screens/setting_screen.dart';


class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

// ------------------ Custom config ------------------
class IntroScreenState extends State<IntroScreen> {

  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title:
        "개발자 소개",
        maxLineTitle: 2,
        styleTitle: TextStyle(
            color: Color(0xff7FFFD4),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'DonghyunKo'),
        description:"저는 그냥... 평범한 신소재공학과\n 재학중인 공대생입니다. \n 항상 에타에서나 카톡으로\n \"수강신청 언제부터냐?\",\n \"성적 발표는 언제냐?\"라는 \n질문들이 많이 올라와서 "
            "학교별로 일정을 \n정리해 주는 어플을 만들면 좋겠다는 \n생각을 하게 되었습니다.\n 그리하여 이 어플을 만들었고 \n프로그래밍은 취미삼아 하는 것이기 \n때문에 많이 미흡합니다.\n "
            "오류를 발견하시면 \n(설정-> Schedule 추가 및 오류개선 방법\n에 있는"
            "문의 방법으로 \n알려주시면 감사하겠습니다."
            " ",
        styleDescription: TextStyle(
            color: Color(0xff7FFFD4),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'DonghyunKo'),
        marginDescription:
        EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        centerWidget: Text("",
            style: TextStyle(color: Colors.white)),
        backgroundImage: "assets/images/developer.png",
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        onCenterItemPress: () {},
      ),
    );
    slides.add(
      new Slide(
        title: "학교목록",
        styleTitle: TextStyle(
            color: Color(0xff7FFFD4),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'DonghyunKo'),
        description:
        "학교목록 순서는 오직 ㄱㄴㄷ순으로\n 배열한 것이므로 학교 순위와는\n 관련 없음을 다시 한번 알려드립니다.\n 점차 학교목록을 늘려갈 예정입니다. ",
        styleDescription: TextStyle(
            color: Color(0xff7FFFD4),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'DonghyunKo'),
        backgroundImage: "assets/images/developer.png",
        directionColorBegin: Alignment.topRight,
        directionColorEnd: Alignment.bottomLeft,
      ),
    );
    slides.add(
      new Slide(
        title: "디자이너 모집",
        styleTitle: TextStyle(
            color: Color(0xff7FFFD4),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'DonghyunKo'),
        description:
        "저도 알아요...\n항상 미술시간에 꼴찌한\n저는 디자인에 답이 없습니다.\n\n  \"디자인이 이게뭐야..\"\n\"차라리 내가 한다\"라고\n생각드시는 분은 저에게\n언제든 말씀해주세요~\npay는 없고 대신 \n여기 한 페이지를 드리겠습니다..ㅎㅎ",
        //저도 알아요...\n항상 미술시간에 꼴찌한\n저는 디자인에 답이 없습니다.\n  \"디자인이 이게뭐야.. 차라리 내가 한다\"라고\n생각드시는 분은 저에게\n언제든 말씀해주세요~\npay는 없고 여기 한 페이지를 드리겠습니다..ㅎㅎ
        styleDescription: TextStyle(
            color: Color(0xff7FFFD4),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'DonghyunKo'),
        backgroundImage: "assets/images/developer.png",
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
      ),
    );
  }

  void onDonePress() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
    // Do what you want
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => HomeScreen()),
    // );
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffF3B4BA),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xffF3B4BA),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffF3B4BA),
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Color(0x33F3B4BA)),
      overlayColor: MaterialStateProperty.all<Color>(Color(0x33FFA8B0)),
    );
  }

  @override
  Widget build(BuildContext context) {

    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: this.renderNextBtn(),
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      doneButtonStyle: myButtonStyle(),

      // Dot indicator
      colorDot: Color(0x33FFA8B0),
      colorActiveDot: Color(0xffFFA8B0),
      sizeDot: 13.0,

      // Show or hide status bar
      hideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,

      // Scrollbar
      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }
}