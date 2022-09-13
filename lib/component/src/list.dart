import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BasicMaterialHeader extends MaterialHeader {
  BasicMaterialHeader({Color? color})
      : super(
            valueColor: AlwaysStoppedAnimation<Color>(
                color ?? GlobalConfig().currentColor),
            backgroundColor: UCS.transparent);
}

class BasicList extends ScrollList {
  BasicList({
    super.key,
    required super.itemBuilder,
    required super.itemCount,
    EasyRefreshController? refreshController,
    Widget? placeholder,
    Widget? header,
    VoidCallback? onRefresh,
    VoidCallback? onLoading,
    super.crossAxisFlex = false,
    super.controller,
    super.padding,
    super.mainAxisSpacing = 0,
    super.crossAxisSpacing = 0,
    super.crossAxisCount = 1,
    super.childAspectRatio = 1,
    super.maxCrossAxisExtent = 100,
    super.shrinkWrap = false,
    super.physics,
    super.scrollDirection = Axis.vertical,
  }) : super.builder(
            cacheExtent: deviceHeight / 2,
            header: header == null ? null : SliverToBoxAdapter(child: header),
            refreshConfig: (onRefresh != null || onLoading != null)
                ? RefreshConfig(
                    controller: refreshController,
                    header: GlobalConfig().config.pullDownHeader,
                    footer: GlobalConfig().config.pullUpFooter,
                    onLoading:
                        onLoading == null ? null : () async => onLoading.call(),
                    onRefresh:
                        onRefresh == null ? null : () async => onRefresh.call())
                : null,
            placeholder: placeholder ?? GlobalConfig().config.placeholder);

  BasicList.waterfall({
    super.key,
    required super.itemBuilder,
    required super.itemCount,
    EasyRefreshController? refreshController,
    Widget? placeholder,
    Widget? header,
    VoidCallback? onRefresh,
    VoidCallback? onLoading,
    super.controller,
    super.padding,
    super.mainAxisSpacing = 0,
    super.crossAxisSpacing = 0,
    super.crossAxisCount,
    super.maxCrossAxisExtent,
    super.shrinkWrap = false,
    super.physics,
    super.scrollDirection = Axis.vertical,
  }) : super.waterfall(
            cacheExtent: deviceHeight / 2,
            header: header == null ? null : SliverToBoxAdapter(child: header),
            refreshConfig: (onRefresh != null || onLoading != null)
                ? RefreshConfig(
                    controller: refreshController,
                    header: GlobalConfig().config.pullDownHeader,
                    footer: GlobalConfig().config.pullUpFooter,
                    onLoading:
                        onLoading == null ? null : () async => onLoading.call(),
                    onRefresh:
                        onRefresh == null ? null : () async => onRefresh.call())
                : null,
            placeholder: placeholder ?? GlobalConfig().config.placeholder);

  BasicList.separated({
    super.key,
    required super.itemBuilder,
    required super.separatorBuilder,
    required super.itemCount,
    EasyRefreshController? refreshController,
    Widget? placeholder,
    VoidCallback? onRefresh,
    VoidCallback? onLoading,
    Widget? header,
    super.controller,
    super.padding,
    super.shrinkWrap = false,
    super.physics,
    super.scrollDirection = Axis.vertical,
  }) : super.separated(
            cacheExtent: deviceHeight / 2,
            header: header == null ? null : SliverToBoxAdapter(child: header),
            refreshConfig: (onRefresh != null || onLoading != null)
                ? RefreshConfig(
                    controller: refreshController,
                    footer: GlobalConfig().config.pullUpFooter,
                    header: GlobalConfig().config.pullDownHeader,
                    onLoading:
                        onLoading == null ? null : () async => onLoading.call(),
                    onRefresh:
                        onRefresh == null ? null : () async => onRefresh.call())
                : null,
            placeholder: placeholder ?? GlobalConfig().config.placeholder);

  BasicList.countBuilder({
    super.key,
    required super.sliver,
    EasyRefreshController? refreshController,
    Widget? header,
    VoidCallback? onRefresh,
    VoidCallback? onLoading,
    super.physics,
    super.controller,
    super.padding,
    super.shrinkWrap = false,
    super.scrollDirection = Axis.vertical,
  }) : super(
            cacheExtent: deviceHeight / 2,
            header: header == null ? null : SliverToBoxAdapter(child: header),
            refreshConfig: (onRefresh != null || onLoading != null)
                ? RefreshConfig(
                    controller: refreshController,
                    footer: GlobalConfig().config.pullUpFooter,
                    header: GlobalConfig().config.pullDownHeader,
                    onLoading:
                        onLoading == null ? null : () async => onLoading.call(),
                    onRefresh:
                        onRefresh == null ? null : () async => onRefresh.call())
                : null);
}
