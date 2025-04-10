import 'package:flutter/material.dart';
import 'package:pets_shop/core/config/routes/pet_route_path.dart';

class PetRouteInformationParser extends RouteInformationParser<PetRoutePath> {
  @override
  Future<PetRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = routeInformation.uri;

    // Handle '/'
    if (uri.pathSegments.isEmpty) {
      return PetRoutePath.home();
    }

    // Handle '/cart'
    if (uri.pathSegments.length == 1 && uri.pathSegments[0] == 'cart') {
      return PetRoutePath.cart();
    }

    // Handle '/pet/:id'
    if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'pet') {
      var id = int.tryParse(uri.pathSegments[1]);
      if (id == null) return PetRoutePath.unknown();
      return PetRoutePath.details(id);
    }

    // Handle unknown routes
    return PetRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(PetRoutePath configuration) {
    if (configuration.isUnknown) {
      return RouteInformation(uri: Uri.parse('/404'));
    }
    if (configuration.isHomePage) {
      return RouteInformation(uri: Uri.parse('/'));
    }
    if (configuration.isDetailsPage) {
      return RouteInformation(uri: Uri.parse('/pet/${configuration.id}'));
    }
    if (configuration.isCartPage) {
      return RouteInformation(uri: Uri.parse('/cart'));
    }
    return null;
  }
}
