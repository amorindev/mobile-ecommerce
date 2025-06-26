
// TODO revisar comentarios y el respto pasarlo a others 
// TODO eliminar dependencias


<!-- ! no se debe enviar el userID des el body hacerlo desde el token  -->

// ! -------------------------------------------
// ? Cuando usar return ?, pr que siga con la ejecuion en el provider me parece o en ls funciones de la pantalla
// ? o lguna validcion o cundo ocurre un erorr return; en bloc y provider 
// ! -------------------------------------------

// * En que sediferencin el current user y push  notificactions
// * mobile y backend

// * En backend que retorne session y user peradado, igual a firebase? como manejarlo
// * creamos la se

// * ErrSignIn o SignInErr
// * ver providers y streams videos para el branchio lo mismo para bloc
// !verificar como se relacion el backend con google y dhared preferences


  // * pue ser si no se completo el sign out con exito elcron job ya lo elimina
  // * si no encuentra la sesion a eliminar solo retornamos que fue exitoso
  // * y no dejamos al usuario en estático
  // * y como combinar con shared preferences si no se elimina correctamente
  // * podemos update tokens por si no se elimina para que no cause error
  // * desconectar si la sessión ya no es válida - sino mantener con inicio de sesión
  // * si ocurre un error al eliminar el token me parece no necesario mantener al usuario loguado
  // * segun el tipo de error


Como separar google sign in de auth ddd o ko sacarloesta ahi por que soloautu lo usa ver file storage categorias tambien puede tener un carpeta ahora servicio de mail order tambien puede enviar un email para avisar al usuario de la compra que ddd pedne de otro ver post dd completo o de base dedatos para expo er en google tambien si en el handler poner crear los serccio por cada ddd y aplicar sibgleton para rwutilizar instancias


ver si agregra una capa mas nos permite reutilizacion como supabase o firebase
ver flujos mobile desktop y web ver para que se incluya el token en las request y eso
separar responsabilidades lo veo a mi bloc muy lleno

<!-- TODO ver si usar el token desde la ui pasandolo o injectarle a otro bloc -->

<!-- * si se actualiza el user o auth en el backend debes retornarlo  -->
<!-- * AuthStateEnableTwoFaSmsVerified -->

<!-- TODO importante que pasa que por ejemplo realiza su sign up y no retora nada salvamos -->
<!-- TODO  si retornaria la session ahi si ubiéramos tenido inconvenientes -->
<!-- TODO importante por que, si nosotros retornabamos le user, eluser en estado -->
<!-- TODO no verificado luego mostramos la panalla de verificar el suaurio ingresa el otp -->
<!-- TODO y verifico su correo salio el flujo todo correcto  pero mi user se  -->
<!-- TODO mantendría con estado de no verificado y no habbria problema seguiria con el flujo -->
<!-- TODO pero se mantiene con no verificado ahora lo mismo pasa para enableTwoFaSms -->
<!-- TODO que seria mejor retornar el auth el user en este caso o usa realtime sse o sockets -->
<!-- TODO para actualizar mi user -->

<!-- TODO existe tres formas de agregar mensajes de validaciones en el campo de texto -->
<!-- TODO en mensaje en el centro o un mensaje que emerge de la parte de abajo ver cual es -->
<!-- TODO mejor según el caso -->