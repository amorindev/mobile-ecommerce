# flu_go_jwt

A new Flutter project.

- ver el authchanges
- ver env en staggin prod
- google sign in dev y prod build.graddle
- gitignore con los envs
- cada funcion en una carpeta weincode
- al replicar que se debe cambiar .env el package name también?
- que se envia en el header y cuando crear un class, por ejem plo token, idtoken google desde el header

- ver los dos valores nulos
- ultima face diseño de requerimientos

ismounted problem

los return en el provider

como manejar el acces token es pública de gooogle signin

<!-- ! El gran dilema con flutter es e log de futter como corregir los log si son de error advertencia>
<!-- ! push notifications current user google apple para web también, desktop header de platform>
<!-- ! manejo de códigos documentar >
<!-- ! erorr de conección o mostrar alusuario>

<!-- *  Delte account flow>
1. el desarrollador puede usar el User e injectarle profiele y seguir la secuencia
2. el desarrollador usando un trigger de base de datos pu ede eliminar auth user que van juntos y profile
3. el desarrolador decide separar el profile entonces debehacer dos consultas eliminar auth y user y depes profile pero si una se cumple y el otro no (rompe con el princio de atomicidad)

<!-- ! como usar is mounted -->

FORGOT password necesita envio de token con correo JWT porpose reset password, el otro es fonfim email

ListView vs SingleChildScrollView vs Column

Ignorar los proto en dockerfile o separar los en otra carpeta, tanto como mobile and backend

<!-- ! ver en que situaciones sign up SignupRequest SignUpUserRequest crear objetos de momento simple -->
<!-- ! y como combinarlo con gRPC -->

<!-- * C:\Users\Fernando\.android\debug.keystore -->
<!-- * keytool -list -v -keystore C:\Users\Fernando\.android\debug.keystore -alias go-branch-io-test -->

<!-- * Mostrar los loading -->
<!-- ! Usa string en AndroidManifest sin el paquete -->
<!-- ! https://medium.com/flutter-community/flutter-deep-linking-using-branch-i-o-2e96c0de07fa -->
<!-- en el medium de branch io no lo hce revisa el github que esta al final -->

<!-- ? Crear project con vgv very good ventures? -->
<!-- ? los nulos en todo el sistema dependiendo del flujo -->

<!-- * with-password in the backend -->

probar run with out debugging para que nosalgan los logs

path_url_strategy_module para que este paquete?

Dos grandes factores
dos backends por que l cndidad de informacion y funcionldaes que se envia y retorna en un app
web y mobile es diferente puede tener l appp mobile diferentes funcionalidades

add google y apple pay service dons worry el usario se le avisa que se deve pagar a google tramite
o solo subirle el precio sin decir mejor la primera opcion

Recuerada inclinarnos a apple plicciones seguras
token y refresh tokens
el usario no ingresará si no ha verificaco su correo

<!-- *----------------------------------------------------------------------------- -->
<!-- * COmo combinar gorouter o ongenerate roite con bloc con BlocListener -->
<!-- * por ejemplo en la pantalla de inicio de session click login todo correcto -->
<!-- * si state is logguedin - verificar isloading y el error? -->
<!-- * entonces GoRouter.push -->
<!-- * en la página de register si es nedsverificarion  -->
<!-- * GoRouter.push iria despues del manejo de errores  -->

/_ if (state is Loading) {
showLoadingDialog(context);
return;
}
Navigator.of(context, rootNavigator: true).pop();
if (state is Failed) {
showErrorDialog(context);
}
if (state is Success) {
showSuccessDialog(context);
} _/

<!-- *----------------------------------------------------------------------------- -->
Pilares
open source cerrado, clasificamos grupos de desarroladores
les damos el diseño de sistema y apoyamos
experiencia de usuario fluida al enviar mi email tener un boton de ir a mi mail
seguridad necesito verificar mi email antes de ingresar
listo para actualizar a la nueva version necesitamos estos datos para mejorar tu experiencia de usaruio
cuando hay una nueva version en shorebird mostrar esta pantalla despues de login o mantenerla
una ves que se comppleto los datos se actualiza 
ver como actualizar condicionalmente


en que momento cerrar los box en el widget en el onpause?
generar todos  los iconos de diversos tamaños pagina generator



ver el tema de las tiendas si se debe pagar o no  seria mejor cobrar al susairo y mostrarle
que esta pagando por eso

el tema de is mounted es cuando hacemos llamadas asincronas y al momento des setstate verificar si esat montado
tambien ver
if (state is WrongPasswordAuthException) {
  if (context.mounted) {
    await showErrorDialog(context, 'Wrong credentials');
  }
}

<!-- * Cuando el usaurio verifica su email retorna a la pantalla si no ocurrio un error ir  -->
<!-- * al home  si no mostramos el error,  -->
<!-- * el flujo es enviar el token al backend si es correcto se retorna la session -->
<!-- * asi el usuario no debe ir de nuevo a login -->
<!-- * si el usuario olvida su contraseña -->
<!-- * es mejor por que el usuario puede recuperar su contraseña de forma seguara -->


<!-- ! lo que puede estar afectando es los props de equatable en branchio que no refresaca -->

navega con bloc cuando no necesitas vover atras
si se puede agregando preiuspage y ver en conjunto como funciona
pero es mejor con go router 
si el usuario hace click en forgot password podrá volver
pero si lo haces mediante bloc  no podrás