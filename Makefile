run:
	@echo "working..."


.PHONY: generar icon con flutter_launcher_icons
.PHONY: si es la primera ves flutter clean && flutter pub get
.PHONY: de momento uno por uno
.PHONY: dart run flutter_launcher_icons -f flu_launcher_icons/ probar
app-icon:
	@dart run flutter_launcher_icons -f flu_launcher_icons/flutter_launcher_icons-dev.yml


.PHONY: como obtener el sha a partir de una key
.PHONY: como crear la key 
.PHONY: como crear el apk






