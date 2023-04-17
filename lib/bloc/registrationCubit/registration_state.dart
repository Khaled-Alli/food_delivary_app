
abstract class RegistrationState{}
class InitialState extends RegistrationState{}
class ChangeSignUpConfirmObscureText extends RegistrationState{}
class ChangeSignUpObscureText extends RegistrationState{}
class ChangeLoginObscureText extends RegistrationState{}
class UserRegisterState extends RegistrationState{}
class LoadingSubmitPhoneNumberState extends RegistrationState{}
class PhoneNumberSubmittedState extends RegistrationState{}
class OTPSubmitted extends RegistrationState{}
class UserDataUpdated extends RegistrationState{}