part of 'app_cubit.dart';

abstract class AppStateA {}

class AppInitial extends AppStateA {}

//for getting products
class ProductsLoadingState extends AppStateA {}

class ProductsDoneState extends AppStateA {}

class ProductsErrorState extends AppStateA {}


// for login
class LoginLoadingState extends AppStateA {}

class LoginDoneState extends AppStateA {}

class LoginErrorState extends AppStateA {
  final String error;

  LoginErrorState(this.error);
}

// for sign up
class SignupLoadingState extends AppStateA {}

class SignupDoneState extends AppStateA {}

class SignupErrorState extends AppStateA {
  final String error;

  SignupErrorState(this.error);
}

// for sign out
class SignOutLoadingState extends AppStateA {}

class SignOutDoneState extends AppStateA {}

class SignOutErrorState extends AppStateA {
  final String error;

  SignOutErrorState(this.error);
}


//for password visibility
class PasswordVisible extends AppStateA {}

class PasswordObscured extends AppStateA {}


//for getting user data
class UserDataLoadingState extends AppStateA {}

class UserDataDoneState extends AppStateA {}

class UserDataErrorState extends AppStateA {
  final String error;

  UserDataErrorState(this.error);
}

//for uploading image
class UploadImageLoadingState extends AppStateA {}

class UploadImageDoneState extends AppStateA {}

class UploadImageErrorState extends AppStateA {
  final String error;

  UploadImageErrorState(this.error);
}

//for navigation bar
class NewPage extends AppStateA {}

//for sum
class GetSum extends AppStateA {}

//for picking profile photo
class PickProfilePhotoState extends AppStateA {}
