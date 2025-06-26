
// ! comentario importante abajo
// ! comentario importante abajo
// ! comentario importante abajo
/* child1: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: variations.length,
        itemBuilder: (context, index) {
          final variation = variations[index];
          return SizedBox(
            height: 75.0,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  variation.name,
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: variation.values.length,
                    itemBuilder: (context, index) {
                      final value = variation.values[index];
                      if (variation.name == "COLOR") {
                        return GestureDetector(
                          // ! estose cinfunde con el Finalvalue
                          onTap: () => cSelected(value),
                          child: ShowColorVariation(
                            value: value,
                            isSelected: colorSelected == value,
                          ),
                        );
                      }
                      // ? de donde traerlo de las variation list de produc group?
                      // * para no hacer =="" datos quemados
                      if (variation.name == "SIZE") {
                        return GestureDetector(
                          onTap: () => sSelected(value),
                          child: ShowVariation(
                            value: value,
                            isSelected: sizeSelected == value,
                          ),
                        );
                      }
                      /* return ShowVariation(
                        
                        value: value,
                      ); */
                      return const SizedBox();
                    },
                  ),
                )
              ],
            ),
          );
        },
      ), */