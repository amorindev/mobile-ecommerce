<!-- * El gran dile usar el user en el bloc en el estate global o en el signed in -->
<!-- * no hay problema si es opcional usamos ! por que deberi aestar registrado -->
<!-- * es muy engorroso tener el access token desde la ui ver o no se -->


on<AuthEventBranchIoEventSuscribe>((event, emit) async {
      //emit(const AuthStateBranchIoStateDeepLinkToken(
      //token: "my-token", isLoading: false));
      _branchIoSuscription = _srv.branchIoStream.listen(
        (data) async {
          if (data.isNotEmpty) {
            //"--------------------------------".log();
            //data.toString().log();
            //"--------------------------------".log();
            "BranchioService -  data is not empty".log();
            // if (data != null && data.containsKey('token'))
            if (data.containsKey('token')) {
              String? token = data['token'];
              if (token != null) {
                "BranchioService -  token is not empty this is a token".log();
                token.log();
                "----------------------------------".log();
                //emit(
                //AuthStateBranchIoStateDeepLinkToken(
                //token: token,
                //isLoading: false,
                //),
                //);
                add(AuthEventNewTokenReceived(token: token));
              }
            }
            //* no usa flutter_config pero mira su  build.gradle, en medium de conf branchio
            // * falta saber como usar env desde AndroidManifest para branshio

            // * despues de obtener el token lo enviámos al backend
            // *llamar a otro evento desde el mismo bloc despues del listen o desde la pantalla verify

            //if (data.containsKey("+clicked_branch_link") &&
            //data["+clicked_branch_link"] == true) {
            //String? deepLinkUrl = data["~referring_link"];
            //print("Deep Link URL: $deepLinkUrl");
            // Aquí puedes navegar a una pantalla específica con los datos del deep link
            //}
          } else {
            "BranchioService -  data is empty".log();
          }
        },
        onError: (error) {
          ("Branchio err $error").log();
          // ? emitir estado?
          // si quieres mostrar el error
          //add(AuthEventError(error.toString()));
        },
      );
    });