import 'package:gohomy/data/remote/response-request/service_sell/all_order_res.dart';
import 'package:gohomy/data/remote/response-request/service_sell/info_order_req.dart';
import 'package:gohomy/model/cart_item.dart';

import '../../remote/response-request/admin_manage/all_services_sell_response.dart';
import '../../remote/response-request/admin_manage/service_sell_res.dart';
import '../../remote/response-request/service_sell/all_address_order_res.dart';
import '../../remote/response-request/service_sell/all_category_res.dart';
import '../../remote/response-request/service_sell/cart_service_sell_res.dart';
import '../../remote/response-request/service_sell/order_res.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class ServiceSellRepository {
  Future<AllServiceSellRes?> getAllServiceSellUser({required int page,int? idCategory}) async {
    try {
      var res = await SahaServiceManager().service!.getAllServiceSellUser(page,idCategory);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ServiceSellRes?> getServiceSellUser({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getServiceSellUser(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CartServiceSellsRes?> addItemToCart(
      {required CartItem cartItem}) async {
    try {
      var res =
          await SahaServiceManager().service!.addItemToCart(cartItem.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CartServiceSellsRes?> updateItemToCart(
      {required CartItem cartItem}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateItemToCart(cartItem.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CartServiceSellsRes?> getCartInfo() async {
    try {
      var res = await SahaServiceManager().service!.getCartInfo();
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<OrderRes?> order({required InfoOrderReq infoOrderReq}) async {
    try {
      var res =
          await SahaServiceManager().service!.order(infoOrderReq.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllOrderRes?> getAllOrder(
      {required int page, String? search, required int orderStatus}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllOrder(page, search, orderStatus);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<OrderRes?> getOneOrder({required String orderCode}) async {
    try {
      var res = await SahaServiceManager().service!.getOneOrder(orderCode);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
   Future<AllCategoryRes?> getAllCategory({required int page}) async {
    try {
      var res = await SahaServiceManager().service!.getAllCategory(page);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
  Future<OrderRes?> updateStatusOrder({required String orderCode,required int status}) async {
    try {
      var res = await SahaServiceManager().service!.updateStatusOrder(orderCode,{
        "order_status": status
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
   Future<AllAddressOrderRes?> getAllAddressOrder({required int page}) async {
    try {
      var res = await SahaServiceManager().service!.getAllAddressOrder(page);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

    Future<OrderRes?> orderImmediate({required InfoOrderReq infoOrderReq}) async {
    try {
      var res = await SahaServiceManager().service!.orderImmediate(infoOrderReq.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
   Future<OrderRes?> reOrder({required String orderCode}) async {
    try {
      var res = await SahaServiceManager().service!.reOrder(orderCode);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
}
