import 'package:advanced_ecommerce_app/bloc/registrationCubit/registration_state.dart';
import 'package:advanced_ecommerce_app/data/models/user_model.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RegistrationCubit extends Cubit<RegistrationState>{


  RegistrationCubit():super(InitialState());
  static get(context)=>BlocProvider.of(context);
  late String verificationId;
  FirebaseAuth auth=FirebaseAuth.instance;
  var firestoreCollection = FirebaseFirestore.instance.collection("Users");
  var signupConfirmPasswordController = TextEditingController();
  var signupPasswordController = TextEditingController();
  var signupEmailController = TextEditingController();
  var signupPhoneController = TextEditingController();
  var signupNameController = TextEditingController();
   final signupFormKey = GlobalKey<FormState>();
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();
   final loginFormKey = GlobalKey<FormState>();
  bool signUpObscureText=false;
  bool signUpConfirmObscureText=false;
  bool loginObscureText=false;

  String? signUpNameValidation( name){
    if(name.isEmpty || name.toString().length<2)
    {
     return "The name shouldn't be less than 2 character";
    }else {
      return null;
    }
  }
  String? phoneValidation(phone){
    if(phone.isEmpty || phone.toString().length<11 || phone[0]!="0" || phone[1]!="1")
    {
     return "please enter a valid phone";
    }else {
      return null;
    }
  }
  String? passwordValidation(password){
    if(password.isEmpty || password.toString().length<6 )
    {
     return "The password shouldn't be less than 2 character";
    }else {
      return null;
    }
  }
  String? emailValidation(email){
    if(email.isEmpty || !email.toString().contains("@") ||!email.toString().contains(".com") )
    {
     return "please enter a valid email";
    }else {
      return null;
    }
  }
  String? confirmPasswordValidation(password){
    if(password != signupPasswordController.text )
    {
     return "The password doesn't match";
    }else {
      return null;
    }
  }

  void changeSignUpObscureText(){
    signUpObscureText =!signUpObscureText;
    emit(ChangeSignUpObscureText());
  }
  void changeSignUpConfirmObscureText(){
    signUpConfirmObscureText =!signUpConfirmObscureText;
    emit(ChangeSignUpConfirmObscureText());
  }
  void changeLoginObscureText(){
    loginObscureText =!loginObscureText;
    emit(ChangeLoginObscureText());
  }

 Future<void> updateUserData(MyUser user )async{
 //await  firebaseServices.userRegister(user);
 await FirebaseAuth.instance.currentUser!.updateEmail(user.email);
 await FirebaseAuth.instance.currentUser!.updateDisplayName(user.name);
 await FirebaseAuth.instance.currentUser!.updatePassword(user.password);
 emit(UserDataUpdated());
 }
 //done
 Future<void> submitPhoneNumber(phoneNumber)async{
    emit(LoadingSubmitPhoneNumberState());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 30),
      verificationCompleted: (_){},
      verificationFailed: (error){print('verificationFailed : ${error.toString()}');},
      codeSent: (String verificationId, int? resendToken){this.verificationId = verificationId;},
      codeAutoRetrievalTimeout: (_){},
    ).then((value) {
      emit(PhoneNumberSubmittedState());
      //  print("submitPhoneNumber : "+ verificationId.toString());
    }
    );
 }
//done
 Future<void> submitOTP(String otpCode)async{
   PhoneAuthCredential credential = PhoneAuthProvider.credential(
       verificationId: verificationId, smsCode: otpCode);
   await signInWithPhone(credential);
 }
//done
 Future<void> signInWithPhone(credential)async {
    //await auth.currentUser?.updatePhoneNumber(credential).catchError((e)=>print("updateCurrentUserWithPhone : " +e.toString()));
    await auth.signInWithCredential(credential).then((value) {
      emit(OTPSubmitted());
    }).catchError((e)=>print("updateCurrentUserWithPhone : " +e.toString()));
    /* await auth.verifyPhoneNumber(
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
  */
  }

 Future<void> deleteCurrentUser()async{
   await auth.currentUser!.delete();
 }

 Future<void> logIn(MyUser user)async{
   await auth.signInWithEmailAndPassword(email: user.email, password: user.password);
 }

 Future<void> logOut()async{
   await auth.signOut();
 }

 User getCurrentUser(){
   return FirebaseAuth.instance.currentUser!;
 }

}