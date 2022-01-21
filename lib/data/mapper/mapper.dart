// to convert the response into a non nullable object (model)

import 'package:flutter_advanced_course/app/extensions.dart';
import 'package:flutter_advanced_course/data/responses/responses.dart';

import '../../domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id?.orEmpty() ?? EMPTY,
        this?.name?.orEmpty() ?? EMPTY,
        this?.numOfNotifications?.orZero() ?? ZERO);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(this?.email?.orEmpty() ?? EMPTY,
        this?.phone?.orEmpty() ?? EMPTY, this?.link?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        this?.customer?.toDomain(), this?.contacts?.toDomain());
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  ForgotPassword toDomain() {
    return ForgotPassword(this?.support ?? EMPTY);
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      this?.id?.orZero() ?? ZERO,
      this?.title ?? EMPTY,
      this?.image ?? EMPTY,
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      this?.id?.orZero() ?? ZERO,
      this?.title ?? EMPTY,
      this?.image ?? EMPTY,
    );
  }
}

extension BannerMapper on BannerResponse? {
  BannerAd toDomain() {
    return BannerAd(
      this?.id?.orZero() ?? ZERO,
      this?.title ?? EMPTY,
      this?.image ?? EMPTY,
      this?.link ?? EMPTY,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> mappedServices =
        (this?.data?.services?.map((service) => service.toDomain()) ??
                Iterable.empty())
            .cast<Service>()
            .toList();

    List<Store> mappedStore =
        (this?.data?.services?.map((service) => service.toDomain()) ??
                Iterable.empty())
            .cast<Store>()
            .toList();

    List<BannerAd> mappedBanners =
        (this?.data?.services?.map((service) => service.toDomain()) ??
                Iterable.empty())
            .cast<BannerAd>()
            .toList();

    var data = HomeData(mappedServices, mappedStore, mappedBanners);

    return HomeObject(data);
  }
}
