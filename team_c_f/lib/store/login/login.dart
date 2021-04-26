import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';

part 'login.g.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

class Login = LoginBase with _$Login;

abstract class LoginBase with Store {
  LoginBase() {
    googleLogin();
  }

  @observable
  bool login = false;

  @observable
  String userName = 'No user';

  @action
  void changeName(String text) {
    userName = text.trim();
  }

  @observable
  ObservableFuture<bool> loginStatus = ObservableFuture<bool>.value(false);

  @action
  void changeLoginStatus(dynamic status) {
    loginStatus = status;
  }

  @computed
  bool get updatedLoginStatus => loginStatus.value!;

  @action
  Future<bool> googleLogin() async {
    GoogleSignInAccount gUser = await getGoogleUser();
    GoogleSignInAuthentication googAuth = await gUser.authentication;
    User? user;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googAuth.idToken,
      accessToken: googAuth.accessToken,
    );
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    user = userCredential.user;

    if (user?.uid != null) {
      loginStatus = ObservableFuture.value(true);
    } else {
      loginStatus = ObservableFuture.value(false);
    }
    return Future.value(true);
  }

  @action
  Future<bool> logoutAccount() async {
    _googleSignIn.signOut();
    _auth.signOut();
    loginStatus = ObservableFuture.value(false);
    return await Future.value(true);
  }

  Future getGoogleUser() async {
    GoogleSignInAccount? googleUser = _googleSignIn.currentUser;
    if (googleUser == null) {
      googleUser = await _googleSignIn.signInSilently();
    }
    if (googleUser == null) {
      googleUser = await _googleSignIn.signIn();
    }
    return googleUser;
  }
}
