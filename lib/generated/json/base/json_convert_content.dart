// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:coupon_app/domain/entities/slider_banner_entity.dart';
import 'package:coupon_app/generated/json/slider_banner_entity_helper.dart';
import 'package:coupon_app/domain/entities/user_entity.dart';
import 'package:coupon_app/generated/json/user_entity_helper.dart';
import 'package:coupon_app/domain/entities/coupons/category_detail_entity.dart';
import 'package:coupon_app/generated/json/category_detail_entity_helper.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:coupon_app/generated/json/product_entity_helper.dart';
import 'package:coupon_app/domain/entities/category_entity.dart';
import 'package:coupon_app/generated/json/category_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
			case SliderBannerEntity:
				return sliderBannerEntityFromJson(data as SliderBannerEntity, json) as T;
			case UserEntity:
				return userEntityFromJson(data as UserEntity, json) as T;
			case CategoryDetailEntity:
				return categoryDetailEntityFromJson(data as CategoryDetailEntity, json) as T;
			case CategoryDetailCategory:
				return categoryDetailCategoryFromJson(data as CategoryDetailCategory, json) as T;
			case ProductEntity:
				return productEntityFromJson(data as ProductEntity, json) as T;
			case CategoryEntity:
				return categoryEntityFromJson(data as CategoryEntity, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case SliderBannerEntity:
				return sliderBannerEntityToJson(data as SliderBannerEntity);
			case UserEntity:
				return userEntityToJson(data as UserEntity);
			case CategoryDetailEntity:
				return categoryDetailEntityToJson(data as CategoryDetailEntity);
			case CategoryDetailCategory:
				return categoryDetailCategoryToJson(data as CategoryDetailCategory);
			case ProductEntity:
				return productEntityToJson(data as ProductEntity);
			case CategoryEntity:
				return categoryEntityToJson(data as CategoryEntity);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (SliderBannerEntity).toString()){
			return SliderBannerEntity().fromJson(json);
		}	else if(type == (UserEntity).toString()){
			return UserEntity().fromJson(json);
		}	else if(type == (CategoryDetailEntity).toString()){
			return CategoryDetailEntity().fromJson(json);
		}	else if(type == (CategoryDetailCategory).toString()){
			return CategoryDetailCategory().fromJson(json);
		}	else if(type == (ProductEntity).toString()){
			return ProductEntity().fromJson(json);
		}	else if(type == (CategoryEntity).toString()){
			return CategoryEntity().fromJson(json);
		}	
		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(List<SliderBannerEntity>() is M){
			return data.map<SliderBannerEntity>((e) => SliderBannerEntity().fromJson(e)).toList() as M;
		}	else if(List<UserEntity>() is M){
			return data.map<UserEntity>((e) => UserEntity().fromJson(e)).toList() as M;
		}	else if(List<CategoryDetailEntity>() is M){
			return data.map<CategoryDetailEntity>((e) => CategoryDetailEntity().fromJson(e)).toList() as M;
		}	else if(List<CategoryDetailCategory>() is M){
			return data.map<CategoryDetailCategory>((e) => CategoryDetailCategory().fromJson(e)).toList() as M;
		}	else if(List<ProductEntity>() is M){
			return data.map<ProductEntity>((e) => ProductEntity().fromJson(e)).toList() as M;
		}	else if(List<CategoryEntity>() is M){
			return data.map<CategoryEntity>((e) => CategoryEntity().fromJson(e)).toList() as M;
		}
		return null;
	}

  static M fromJsonAsT<M>(json) {
    if (json is List) {
      return _getListChildType<M>(json);
    } else {
      return _fromJsonSingle<M>(json) as M;
    }
  }
}