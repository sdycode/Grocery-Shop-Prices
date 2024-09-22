import 'package:groceryshopprices/lib.dart';
import 'package:groceryshopprices/methods/general/goToScreenFor000.dart';

class StartLoginPage extends StatefulWidget {
  const StartLoginPage({super.key});

  @override
  State<StartLoginPage> createState() => _StartLoginPageState();
}

class _StartLoginPageState extends State<StartLoginPage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool guestLoading = false;
  bool appleLoading = false;
  bool googleLoading = false;
  bool emailLoading = false;
  bool get _isLoading =>
      guestLoading || appleLoading || googleLoading || emailLoading;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: appBarWidget(context: context, text: "", enforceExit: false),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Skip login".elButnStyleBorderedButton(onTap: () {
              goToScreenFor000(
                  context,
                  ShopListPage(
                    allowBack: true,
                  ));
            }),
            "Continue with Google".elButnStyle(
                onTap: () async {
                  if (await noInternetAvailable()) {
                    showNoInternetDialog(context);
                    return;
                  }
                  if (_isLoading) {
                    return;
                  }
                  signInWithGoogle();
                },
                loading: googleLoading)
          ],
        ).applySymmetricPadding(),
      ),
    );
  }

  Future signInWithGoogle() async {
    setState(() {
      googleLoading = true;
    });
    const List<String> scopes = <String>[
      'email',
    ];

    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: scopes,
    );
    try {
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        final User? user = userCredential.user;

        if (user != null) {
          registerNewUserIfNeeded(user);

          setState(() {
            googleLoading = false;
          });
          goToReplaceWithTransitionToScreenFor000(
              context,
              ShopListPage(
                allowBack: false,
              ));
        } else {
          setState(() {
            googleLoading = false;
          });
        }
      } else {
        setState(() {
          googleLoading = false;
        });
      }

      printLog("google sign success");
    } catch (error) {
      triggerSnackbar("Some error occured");
      setState(() {
        googleLoading = false;
      });
      printLog("google err " + error.toString());
    }
  }
}
