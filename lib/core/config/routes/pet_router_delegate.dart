import 'package:flutter/material.dart';
import 'package:pets_shop/core/config/routes/pet_route_path.dart';
import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';
import 'package:pets_shop/presentation/pages/cart_page.dart';
import 'package:pets_shop/presentation/pages/pet_details_screen.dart';
import 'package:pets_shop/presentation/pages/pet_list_page.dart';
import 'package:pets_shop/presentation/pages/unknown_screen.dart';

class PetRouterDelegate extends RouterDelegate<PetRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PetRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  PetEntity? _selectedPet;
  bool _showCart = false;
  bool _show404 = false;

  PetRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  PetRoutePath get currentConfiguration {
    if (_show404) {
      return PetRoutePath.unknown();
    }
    if (_showCart) {
      return PetRoutePath.cart();
    }
    return _selectedPet == null
        ? PetRoutePath.home()
        : PetRoutePath.details(_selectedPet!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: const ValueKey('PetsListPage'),
          child: PetListPage(
            onPetSelected: _handlePetTapped,
            onCartTapped: _handleCartTapped,
          ),
        ),
        if (_show404)
          const MaterialPage(
            key: ValueKey('UnknownPage'),
            child: UnknownScreen(),
          )
        else if (_showCart)
          const MaterialPage(
            key: ValueKey('CartPage'),
            child: CartPage(),
          )
        else if (_selectedPet != null)
          MaterialPage(
            key: ValueKey('PetDetailsPage_${_selectedPet!.id}'),
            child: PetDetailsScreen(pet: _selectedPet!),
          )
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages
        _selectedPet = null;
        _showCart = false;
        _show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(PetRoutePath configuration) async {
    if (configuration.isUnknown) {
      _selectedPet = null;
      _showCart = false;
      _show404 = true;
      return;
    }

    if (configuration.isDetailsPage) {
      // Create a temporary pet object with just the ID
      _selectedPet = PetEntity(id: configuration.id!);

      // Then fetch the full details
      try {
        _selectedPet = await PetEntity.getFullPetDetails(configuration.id!);
      } catch (e) {
        _show404 = true;
      }
      _showCart = false;
    } else if (configuration.isCartPage) {
      _selectedPet = null;
      _showCart = true;
    } else {
      _selectedPet = null;
      _showCart = false;
    }

    _show404 = false;
  }

  void _handlePetTapped(PetEntity pet) {
    _selectedPet = pet;
    notifyListeners();
  }

  void _handleCartTapped() {
    _showCart = true;
    notifyListeners();
  }
}
