
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

abstract class Controller <T extends StatefulWidget> extends State<T>{

  final TextEditingController usernameController=TextEditingController();
  final FocusNode usernameFocusNode=FocusNode();
  final TextEditingController passwordController=TextEditingController();
  final FocusNode passwordFocusNode=FocusNode();

  late StateMachineController riveController;
  SMIInput<bool>? isCheck;
  SMIInput<double>? lookInput;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? isSuccess;
  SMIInput<bool>? isFail;



  @override
  void initState() {
    super.initState();

    passwordFocusNode.addListener(() {
      handsUp(true);
    });

    usernameFocusNode.addListener(() {
      handsUp(false);
      Future.delayed(const Duration(milliseconds: 300), (){
        look();
      });
    });

    usernameController.addListener(() {
      lookLength(usernameController.text.length);
    },);

  }


  void onInit(Artboard artboard) async{
    riveController = StateMachineController.fromArtboard(artboard, 'State Machine 1')!;
    artboard.addController(riveController);
    isCheck = riveController.findInput<bool>('Check');
    lookInput = riveController.findInput('Look');
    isHandsUp = riveController.findInput<bool>('hands_up');
    isSuccess = riveController.findInput<bool>('success');
    isFail = riveController.findInput<bool>('fail');
  }


  void handsUp(bool val){
    isHandsUp!.change(val);
  }
  void look(){
    isCheck!.change(!(isCheck?.value??false));
  }
  void lookLength(int length){
    lookInput?.change(length.toDouble());
  }


  @override
  void setState(fn) {
    if(mounted) super.setState(fn);
  }


  void onLoginPressed(bool isSuccess){
    handsUp(false);
    if(!isSuccess){
      loginFailure();
    }
    else{
      loginSuccess();
    }
  }

  void loginSuccess(){
    isSuccess!.change(!(isSuccess?.value??false));
  }

  void loginFailure(){
    isFail!.change(!(isFail?.value??false));
  }

}