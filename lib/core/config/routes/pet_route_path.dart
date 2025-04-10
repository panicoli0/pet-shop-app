class PetRoutePath {
  final int? id;
  final bool isUnknown;
  final bool isCart;

  PetRoutePath.home()
      : id = null,
        isUnknown = false,
        isCart = false;

  PetRoutePath.details(this.id)
      : isUnknown = false,
        isCart = false;

  PetRoutePath.cart()
      : id = null,
        isUnknown = false,
        isCart = true;

  PetRoutePath.unknown()
      : id = null,
        isUnknown = true,
        isCart = false;

  bool get isHomePage => id == null && !isUnknown && !isCart;
  bool get isDetailsPage => id != null;
  bool get isCartPage => isCart;
}
