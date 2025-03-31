part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

// con el usuario actual
class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

class AuthEventTest extends AuthEvent {
  const AuthEventTest();
}
// * cuando lanzmos un verion nueva de la app y necesitamos otros datos, despues de login
// * crear una pantalla pra solicitar daatos

// * mejor que retorne el usurio sign in porque de la pntall register
// * se va ir defrente a verify email y se necesita el email
class AuthEventSignIn extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;
  const AuthEventSignIn({
    required this.email,
    required this.password,
    required this.rememberMe,
  });
}

// * ver por que email es opcional o esta conbinando forgot conchange password
// * uanque no reciben parámetros diferentes
// me parece que es para la navegacion
class AuthEventForgotPassword extends AuthEvent {
  // por que el usario puede intentar ingresar con un correo valido
  // y lo que da error es la contraseña
  final String? email;
  const AuthEventForgotPassword({this.email});
}

// cuando el usuario sabe su anterior contraseñan NewPasssword o changePassaword
class AurhEventChangePassword {}

class AuthEventSignUp extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const AuthEventSignUp({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class AuthEventShouldSignUp extends AuthEvent {
  // * ahora podemos volver a la pantalla anterior
  // * PushRemoveUntil seria  AuthEventShouldSignUp(previusPage: null)
  // * pero como sabemos si se toco el boton de retroceder?
  final AuthState? previusPage;
  const AuthEventShouldSignUp({required this.previusPage});
}

// ? mejor crear eventos solo para navegacion?
// ! Recuerda que sign out puede tener otras responsabiidades
// ! no solo navegar a login
// ! mejor es crear otro como AuthEventShouldSignUp,
// ? sirve para register volver a sign in o crear otro AuthEventShouldSignIn
// * recuerda que vamos usar dentro de listener GoRouter.push
// * si usamos este evento en register y signup
// * escucharia la pagina se cerrar session(que no se muestra cuando estas en register)
// * y escucharia la pagina de sign up para volver a sign in page
// * o AuthEventSignOut es como identificamos a cada evento con la página
// con el usuario actual
class AuthEventSignOut extends AuthEvent {
  const AuthEventSignOut();
}

// * Cuando el usuario hace okey al show dialog sedebe establecer en AuhtSiedOut con el error en null?
// *

// estamos considerando para navegar por ejemplo a la pantalla principal
// que AuthStateSignIn sin loading ni error para que navegue con gorouter
// pero tambien puedes agregar como sera un evento por vacambio de pantalla
// agragr un bolean si se cambio de pantalla esto solo si causa interferencua ya sea en el blocu otro

// ? Ademas si creamos un AuthEventConCada navegacion
// ? podemos enviarle parámetros
// * y usar bloc builder
// ode dejar al router?
//
// * el tema si separo por cada navegacion un evento como le aviso al bloc cuando ya llego para que cambie de estado
// * en la pantalla a navegar en el listener con una condifucion if (state is AuthNavigateHome)
// * cambiar e estado a AuthStateSignedIn
//
// si es asi no se podrá crear AuthBloc o AuthPRovider listener pantalla

// * entonces significa que bandad usa signout por que e usuario ya inicio session en register?
// * por eso digo que remove token del backend (aunqyue no es necesario mejor usar cronjob) y
// * remover de local storage no debe ser cortante
//
// * quiere decir en el punto de very email el usuario esta con inicio de session
// y puedes haer signout

// guiate de proceso de facebook de su authenticacion
// esa es la forma cambia  tu contraseña de facebook u otroa cuenta

// definir eventos solo para la navegacion pasar parámetros y parámetros opcionales
// y retroceder con backbutton

class GoToHomeScreen extends AuthEvent {}

// ver los nulos
class GoToProductDetail extends AuthEvent {
  // debería ser el objeto producto
  final String? product;
  // si es pushReplacement previus page is null
  final AuthState? previusPage;
  const GoToProductDetail({required this.previusPage, required this.product});
}

// * NOs quedamos en go_router u otro con bloc ambos como el doc de bloc
// * para no complicano

class AuthEventBranchIoEventSuscribe extends AuthEvent {
  const AuthEventBranchIoEventSuscribe();
}

class AuthEventBranchIoEventCancellAllSuscriptions extends AuthEvent {
  const AuthEventBranchIoEventCancellAllSuscriptions();
}

class AuthEventNewTokenReceived extends AuthEvent {
  final String token;
  const AuthEventNewTokenReceived({required this.token});
}
class CancelarSuscripcion extends AuthEvent{
  const CancelarSuscripcion();
}