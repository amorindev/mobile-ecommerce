import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flu_go_jwt/screens/auth/phone_screen.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_textfield.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/address/bloc/address_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/order/bloc/order_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/order/core/resp.dart';
import 'package:flu_go_jwt/services/ecomm/stores/bloc/store_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/stores/core/core.dart';
import 'package:flu_go_jwt/services/phone/bloc/phone_bloc.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> with TickerProviderStateMixin {
  // ! De momento está estático pero que pasaría si los tabs viene del backend
  // ? no se si agrgar final
  // de momento no uo el controlador
  late TabController _tabController;
  late final TextEditingController _locationReference;
  late final TextEditingController _dateController;

  // * vamos a tomar los datos segun el tap donde se encuentra el usuario
  // * validar
  // * store tag
  StoreResponse? store;

  // * para ambos métodos
  String? phoneId;
  String? addressId;

  String? reference;
  String? storeId;

  int? selectedIndexStore;
  // * deliverytag ver si va necesitar alguna variable

  // para validar y modificar la order del bloc
  int selectedIndexTab = 0; // o null
  String? selectedNameTab = "delivery";

  @override
  void initState() {
    super.initState();
    _locationReference = TextEditingController();
    _dateController = TextEditingController();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    // * Cargamos el primer tab
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthStateSignedIn) {
      final accessToken = authState.authResponse!.session!.accessToken;
      BlocProvider.of<AddressBloc>(context).add(AddressEventGetAll(
        accessToken: accessToken,
      ));
      BlocProvider.of<StoreBloc>(context).add(StoreEventGetAll(
        accessToken: accessToken,
      ));
      BlocProvider.of<PhoneBloc>(context).add(PhoneEventGetAll(
        accessToken: accessToken,
      ));
    }
  }

  // ? como seleccionar varios fechas de momento sencillo
  /* Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  } */

  void _handleTabChange() {
    // * loideal seria cargar primeo solo el primer tab desde el initstate y los siguientes progresivamente de momento todo desde el inistate
    // ver gpt
    if (_tabController.indexIsChanging) {
      return;
    }

    int index = _tabController.index;
    selectedIndexTab = index;
    //debugPrint("Index tab: $index");
    switch (index) {
      case 0:
        selectedNameTab = "delivery";
      case 1:
        selectedNameTab = "pickup";
    }
    //print(index);
    //print(selectedNameTab);
    // * Primero ver como se realizarán las validaciones
    // Aquí puedes realizar validaciones
    /* switch (index) {
        case 0:
          print('Tab 0 seleccionado: validación A');
          break;
        case 1:
          print('Tab 1 seleccionado: validación B');
          break;
        case 2:
          print('Tab 2 seleccionado: validación C');
          break;
      } */

    //if (_tabController.index == 1) {}
  }

  @override
  void dispose() {
    _tabController.dispose();
    _locationReference.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ! por quno un Scaffold dentro un DefaultTabController por que al reves
    // ! despues vemos como personalirlo aun mas sin appbar
    // ! podria ser una columna dentro el TabBar TabbarVire ver como hacer espacio
    // ! wu va a tener si va a necesitar de TabBarcontroller
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Shipping",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: AppColors.brandColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
      ),
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: const [
                  // * ver que alternaticvas hay de envio y recojo en shopify

                  /* Column(
                    children: [
                      //Icon(Icons.directions_bus),
                      Icon(Icons.directions_car),
                      Text("Shipping")
                    ],
                  ), */
                  Column(
                    children: [
                      Icon(Icons.delivery_dining),
                      Text("Delivery"),
                    ],
                  ),
                  Column(
                    children: [Icon(Icons.local_convenience_store_rounded), Text("Store Pickup")],
                  ),
                  // usar Column o el tab tiene su child
                  //Tab(text: '1'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // * verificar que e`l boton no tape el ultimo contenido
                    // * lo mismo para los demas
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.horizontalMediumPadding,
                        vertical: AppSizes.verticalP,
                      ),
                      child: ListView(
                        children: [
                          const Text(
                            "Email:",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthStateSignedIn) {
                                /* return ListTile(
                                  title: Text(
                                    state.authResponse!.user.email,
                                  ),
                                  leading: const Icon(
                                    Icons.email,
                                  ),
                                ); */
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: AppColors.blackColor),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.email),
                                      const SizedBox(width: 15.0),
                                      Text(
                                        state.authResponse!.user.email,
                                        style: const TextStyle(fontSize: 16.0),
                                      )
                                    ],
                                  ),
                                );
                              }
                              // o redireccionar a signin
                              return Text("no email"); // ve rcomo manejarlso
                            },
                          ),
                          const Text(
                            "Address:",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),

                          const SizedBox(height: 10.0),
                          BlocBuilder<AddressBloc, AddressState>(
                            builder: (context, state) {
                              if (state is AddressStateLoaded) {
                                if (state.addresses == null) {
                                  return const Text("No hay direcciones");
                                }
                                addressId = state.addresses![0].id;
                                //!buscar el addres por defecto si no existe escoger el primer elemento

                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12.0),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                        border: Border.all(width: 1),
                                      ),
                                      child: Row(
                                        // ! en ves de esto podria ser un expanded
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // ! facilmente se puede hacer con row ver cual es mejor
                                              CustomTextRich(
                                                text: "Label: ",
                                                value: state.addresses![0].label,
                                              ),
                                              CustomTextRich(
                                                text: "Address: ",
                                                value: state.addresses![0].addressLine,
                                              ),
                                              CustomTextRich(
                                                text: "State: ",
                                                value: state.addresses![0].state,
                                              ),

                                              CustomTextRich(
                                                text: "Country: ",
                                                value: state.addresses![0].country,
                                              ),

                                              CustomTextRich(
                                                text: "City: ",
                                                value: state.addresses![0].city,
                                              ),
                                              CustomTextRich(
                                                text: "Postal code: ",
                                                value: state.addresses![0].postalCode,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const SizedBox(
                                                height: 90.0,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      left: BorderSide(
                                                        color: Colors.black,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10.0),
                                              InkWell(
                                                onTap: () {},
                                                child: const Text(
                                                  "Change",
                                                  style: TextStyle(
                                                    color: AppColors.blueColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox(
                                height: 10.0,
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          const SizedBox(height: 15),

                          const Text(
                            "Phone number:",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                          BlocBuilder<PhoneBloc, PhoneState>(
                            builder: (context, state) {
                              if (state is PhoneStateLoaded) {
                                if (state.phones == null) {
                                  // ! null significa que no se llamo todavía ala api o hebo un erorr al trar el
                                  // ! ver como combinar por que tambien manjamos errores
                                  // ! de momento traere denuvo mejor desde initstate demomento
                                  /*  final authState =
                                      context.read<AuthBloc>().state;
                                  if (authState is AuthStateSignedIn) {
                                    final accessToken =
                                        authState.authResponse!.accessToken!;
                                    
                                    context
                                        .read<PhoneBloc>()
                                        .add(PhoneEventGetAll(
                                          accessToken: accessToken,
                                        ));
                                  } */

                                  return const Text(
                                    "an error ocuerrod or au no llamé a la api",
                                  );
                                }
                                if (state.phones == []) {
                                  return const Text("No hay telefono");
                                }
                                if (state.phones!.isEmpty) {
                                  return const Text("No hay teléfono");
                                }
                                phoneId = state.phones![0].id;
                                return CustomPhoneCard2(
                                  phone: state.phones![0],
                                );
                              }
                              return const SizedBox(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            "Reference:",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),

                          CustomTextField(
                            controller: _locationReference,
                            hintText: 'Aparment, suite, in front of, etc',
                            obscureText: false,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 15.0),
                          /* const Text(
                            "Select date:",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ), */
                          /* const SizedBox(height: 10.0), */
                          // ! select 5 fechas? o 3 si no reembolso ver si debe ser configurado
                          // ! por el dueño de la empresa
                          /* CustomDateTimePicker(
                            controller: _dateController,
                            onTap: () => _selectDate(),
                          ), */
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.horizontalMediumPadding,
                        vertical: AppSizes.verticalP,
                      ),
                      child: ListView(
                        children: [
                          const Text(
                            "Email:",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthStateSignedIn) {
                                /* return ListTile(
                                  title: Text(
                                    state.authResponse!.user.email,
                                  ),
                                  leading: const Icon(
                                    Icons.email,
                                  ),
                                ); */
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.email),
                                      const SizedBox(width: 15.0),
                                      Text(
                                        state.authResponse!.user.email,
                                        style: const TextStyle(fontSize: 16.0),
                                      )
                                    ],
                                  ),
                                );
                              }
                              // o redireccionar a signin
                              return Text("no email"); // ve rcomo manejarlso
                            },
                          ),
                          const SizedBox(height: 5.0),
                          const Text(
                            "Address:",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          BlocBuilder<AddressBloc, AddressState>(
                            builder: (context, state) {
                              if (state is AddressStateLoaded) {
                                if (state.addresses == null) {
                                  return const Text("No hay direcciones");
                                }
                                //!buscar el addres por defecto si no existe escoger el primer elemento
                                addressId = state.addresses![0].id;
                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                        border: Border.all(width: 1),
                                      ),
                                      child: Row(
                                        // ! en ves de esto podria ser un expanded
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // ! facilmente se puede hacer con row ver cual es mejor
                                              CustomTextRich(
                                                text: "Label: ",
                                                value: state.addresses![0].label,
                                              ),
                                              CustomTextRich(
                                                text: "Address: ",
                                                value: state.addresses![0].addressLine,
                                              ),
                                              CustomTextRich(
                                                text: "State: ",
                                                value: state.addresses![0].state,
                                              ),
                                              CustomTextRich(
                                                text: "Country: ",
                                                value: state.addresses![0].country,
                                              ),
                                              CustomTextRich(
                                                text: "City: ",
                                                value: state.addresses![0].city,
                                              ),
                                              CustomTextRich(
                                                text: "Postal code: ",
                                                value: state.addresses![0].postalCode,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const SizedBox(
                                                height: 90.0,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      left: BorderSide(
                                                        color: Colors.black,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10.0),
                                              InkWell(
                                                onTap: () {},
                                                child: const Text(
                                                  "Change",
                                                  style: TextStyle(
                                                    color: AppColors.blueColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Phone number:",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                          BlocBuilder<PhoneBloc, PhoneState>(
                            builder: (context, state) {
                              if (state is PhoneStateLoaded) {
                                if (state.phones == null) {
                                  // ! null significa que no se llamo todavía ala api o hebo un erorr al trar el
                                  // ! ver como combinar por que tambien manjamos errores
                                  // ! de momento traere denuvo mejor desde initstate demomento
                                  /*  final authState =
                                      context.read<AuthBloc>().state;
                                  if (authState is AuthStateSignedIn) {
                                    final accessToken =
                                        authState.authResponse!.accessToken!;
                                    
                                    context
                                        .read<PhoneBloc>()
                                        .add(PhoneEventGetAll(
                                          accessToken: accessToken,
                                        ));
                                  } */

                                  return const Text("an error ocuerrod or au no llamé a la api");
                                }
                                if (state.phones == []) {
                                  return const Text("No hay telefono");
                                }
                                if (state.phones!.isEmpty) {
                                  return const Text("No hay telefono");
                                }
                                phoneId = state.phones![0].id;

                                return CustomPhoneCard2(phone: state.phones![0]);
                              }
                              return const SizedBox(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            "Stores:",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                          BlocBuilder<StoreBloc, StoreState>(
                            builder: (context, state) {
                              if (state is StoresStateLoaded) {
                                if (state.stores == null) {
                                  return const Center(
                                    child: Text("No hay tiendas disponibles"),
                                  );
                                }
                                /* return Expanded(
                                  child: ListView.builder(
                                    itemCount: state.stores!.length,
                                    itemBuilder: (context, index) {
                                      final store = state.stores![index];
                                      final isSelected = selectedIndex == index;
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            // ! mejor separar la lista en otro eidget por que refrescará todo
                                            // ! la pantalla
                                            selectedIndex = index;
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 15.0),
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              color: isSelected
                                                  ? AppColors.grey2Color
                                                  : AppColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: AppColors.blackColor,
                                              )),
                                          child: Column(
                                            children: [
                                              Text(store.name),
                                              Text(store.address),
                                              Text(store.description),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ); */

                                return Column(
                                  children: List.generate(
                                    state.stores!.length,
                                    (index) {
                                      final store = state.stores![index];
                                      final isSelected = selectedIndexStore == index;
                                      return Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 15.0,
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: isSelected ? AppColors.grey2Color : AppColors.whiteColor,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(store.name),
                                                InkWell(
                                                  onTap: () {
                                                    final position = LatLng(
                                                      store.address.latitude,
                                                      store.address.longitude,
                                                    );
                                                    GoRouter.of(context).push(
                                                      AppRoutes.shippingMapsRoute,
                                                      extra: position,
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.pin_drop,
                                                    color: AppColors.linkColor,
                                                    size: 35.0,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 10.0),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  // ! mejor separar la lista en otro eidget por que refrescará todo
                                                  // ! la pantalla
                                                  selectedIndexStore = index;
                                                  storeId = store.id;
                                                });
                                              },
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Text(store.address.addressLine),
                                                    Text(store.description),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ],
                      ),
                    )

                    /* ListView(
                    padding: const EdgeInsets.only(
                      top: 5.0,
                      left: AppSizes.horizontalPadding,
                      right: AppSizes.horizontalPadding,
                    ),
                    children: [
                      CustomTextField(
                        controller: _nameController,
                        hintText: 'Product Name',
                        obscureText: false,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 5),
                      CustomTextField(
                        controller: _descController,
                        hintText: 'Product Description',
                        obscureText: false,
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ), */
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  //debugPrint(selectedNameTab);
                  if (selectedNameTab == null) {
                    await showErrorDialog(context, "an error ocurred");
                    return;
                  }
                  //debugPrint(phoneId);
                  //debugPrint(addressId);

                  // * Por que comparten el mismo botton
                  if (phoneId == null) {
                    await showErrorDialog(context, "Debe agregar un numero desde su perfil");
                    return;
                  }
                  if (addressId == null) {
                   await showErrorDialog(context, "Debe agregar una direccion desde su perfil");
                    return;
                  }

                  Delivery? delivery;
                  Pickup? pickup;

                  // ! revisar que no sea nulo selectedNameTab
                  if (selectedNameTab == null) {
                    if (reference == null) {
                      await showErrorDialog(context, "an error ocurred");
                      return;
                    }
                  }
                  reference = _locationReference.text;
                  if (selectedNameTab == "delivery") {
                    if (reference == null) {
                      await showErrorDialog(context, "Digita un referencia.");
                      return;
                    }
                    delivery = Delivery(
                      id: null,
                      orderId: null,
                      phoneId: phoneId!,
                      addressId: addressId!,
                      reference: reference!,
                    );
                  } else if (selectedNameTab == "pickup") {
                    if (storeId == null) {
                      await showErrorDialog(context, "Seleccione una tienda.");
                      return;
                    }
                    pickup = Pickup(
                      id: null,
                      orderId: null,
                      phoneId: phoneId!,
                      addressId: addressId!,
                      storeId: storeId!,
                    );
                  }

                  context.read<OrderBloc>().add(OrderEventSetShippingInfo(
                        deliveryType: selectedNameTab!,
                        pickup: pickup,
                        delivery: delivery,
                      ));

                  GoRouter.of(context).push(AppRoutes.paymentRoute);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalMediumPadding,
                  ),
                  height: 60.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.redColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Center(
                    child: Text(
                      "Continue to pay",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextRich extends StatelessWidget {
  final String text;
  final String value;
  const CustomTextRich({
    super.key,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
          SizedBox(
              width: size * 0.42,
              child: Text(value,
                  style: const TextStyle(
                    fontSize: 16.0,
                    overflow: TextOverflow.ellipsis,
                  )))
        ],
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ! por quno un Scaffold dentro un DefaultTabController por que al reves
    // ! despues vemos como personalirlo aun mas sin appbar
    // ! podria ser una columna dentro el TabBar TabbarVire ver como hacer espacio
    // ! wu va a tener si va a necesitar de TabBarcontroller
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(tabs: [
          Column(
            children: [
              //Icon(Icons.directions_bus),
              Icon(Icons.directions_car),
              Text("Shipping")
            ],
          ),
          Column(
            children: [
              Icon(Icons.delivery_dining),
              Text("Delivery"),
            ],
          ),
          Column(
            children: [
              Icon(Icons.local_convenience_store_rounded),
              Text("Store Pickup")
            ],
          ),
          // usar Column o el tab tiene su child
          //Tab(text: '1'),
        ]),
        body: TabBarView(
          children: [
            Text("1"),
            Text("2"),
            Text("3"),
            /* ListView(
              padding: const EdgeInsets.only(
                top: 5.0,
                left: AppSizes.horizontalPadding,
                right: AppSizes.horizontalPadding,
              ),
              children: [
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Product Name',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: _descController,
                  hintText: 'Product Description',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                ),
              ],
            ), */
          ],
        ),
      ),
    );
  }
}

 */
