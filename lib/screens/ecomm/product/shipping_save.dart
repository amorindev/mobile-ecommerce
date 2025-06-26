/* class PartialTabBart extends StatefulWidget {
  const PartialTabBart({super.key});

  @override
  State<PartialTabBart> createState() => _PartialTabBartState();
}

class _PartialTabBartState extends State<PartialTabBart>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [],
        ),
        SizedBox(
          height: 200,
          child: TabBarView(
            controller: _tabController,
            children: const [
              Center(
                child: Text('elegir direccion'),
              ),
              Center(
                child: Text('Elegir direccion'),
              ),
              Center(
                child: Text('test'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
 */

// * Cuando no es pantalla completa para el sign in
/* class PartialTabBart extends StatefulWidget {
  const PartialTabBart({super.key});

  @override
  State<PartialTabBart> createState() => _PartialTabBartState();
}

class _PartialTabBartState extends State<PartialTabBart>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
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
            // usar container o el tab tiene su child
            //Tab(text: '1'),
          ],
        ),
        SizedBox(
          height: 200,
          child: TabBarView(
            controller: _tabController,
            children: const [
              Center(
                child: Text('elegir direccion'),
              ),
              Center(
                child: Text('Elegir direccion'),
              ),
              Center(
                child: Text('test'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
 */