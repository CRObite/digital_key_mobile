
import 'package:json_annotation/json_annotation.dart';

part 'metrics.g.dart';

@JsonSerializable()
class Metrics{
  int? id;
  double? impressions;
  double? conversions;
  double? clicks;
  double? cost;
  double? topImpressionShare;
  double? budgetLostTopImpressionShare;
  double? budgetLostImpressionShare;
  double? exactMatchImpressionShare;
  double? impressionShare;
  double? rankLostTopImpressionShare;
  double? rankLostImpressionShare;
  double? overallTopImpressionShare;
  double? valuePerConversion;
  double? conversionRate;
  double? videoViews;
  double? viewThroughConversions;
  double? interactionConversionRate;
  double? conversionValue;
  double? costPerConversion;
  double? crossDeviceConversions;
  double? ctr;
  double? attributedConversions;
  double? attributedConversionValue;
  double? attributedConversionValuePerCost;
  double? engagements;
  double? measurableImpressions;
  double? measurabilityRate;
  double? measurableCost;
  double? measurableImpressionShare;
  double? allConversionsValue;
  double? averageCost;
  double? averageCpc;
  double? averageCpm;
  double? averagePageViews;
  double? averageTimeOnSite;
  double? bounceRate;
  double? forwards;
  double? saves;
  double? secondaryClicks;
  double? interactionRate;
  double? interactions;
  double? invalidClickRate;
  double? invalidClicks;
  double? newVisitorRate;
  double? phoneCalls;
  double? phoneImpressions;
  double? targetCpa;
  double? newCustomerLifetimeValue;
  double? allNewCustomerLifetimeValue;
  double? orders;
  double? averageOrderValue;
  double? costOfGoodsSold;
  double? grossProfit;
  double? revenue;
  double? unitsSold;
  double? crossSellCostOfGoodsSold;
  double? crossSellGrossProfit;
  double? leadCostOfGoodsSold;
  double? crossDeviceConversionValue;
  String? displayName;

  Metrics(
      this.id,
      this.impressions,
      this.conversions,
      this.clicks,
      this.cost,
      this.topImpressionShare,
      this.budgetLostTopImpressionShare,
      this.budgetLostImpressionShare,
      this.exactMatchImpressionShare,
      this.impressionShare,
      this.rankLostTopImpressionShare,
      this.rankLostImpressionShare,
      this.overallTopImpressionShare,
      this.valuePerConversion,
      this.conversionRate,
      this.videoViews,
      this.viewThroughConversions,
      this.interactionConversionRate,
      this.conversionValue,
      this.costPerConversion,
      this.crossDeviceConversions,
      this.ctr,
      this.attributedConversions,
      this.attributedConversionValue,
      this.attributedConversionValuePerCost,
      this.engagements,
      this.measurableImpressions,
      this.measurabilityRate,
      this.measurableCost,
      this.measurableImpressionShare,
      this.allConversionsValue,
      this.averageCost,
      this.averageCpc,
      this.averageCpm,
      this.averagePageViews,
      this.averageTimeOnSite,
      this.bounceRate,
      this.forwards,
      this.saves,
      this.secondaryClicks,
      this.interactionRate,
      this.interactions,
      this.invalidClickRate,
      this.invalidClicks,
      this.newVisitorRate,
      this.phoneCalls,
      this.phoneImpressions,
      this.targetCpa,
      this.newCustomerLifetimeValue,
      this.allNewCustomerLifetimeValue,
      this.orders,
      this.averageOrderValue,
      this.costOfGoodsSold,
      this.grossProfit,
      this.revenue,
      this.unitsSold,
      this.crossSellCostOfGoodsSold,
      this.crossSellGrossProfit,
      this.leadCostOfGoodsSold,
      this.crossDeviceConversionValue,
      this.displayName);

  factory Metrics.fromJson(Map<String, dynamic> json) => _$MetricsFromJson(json);
  Map<String, dynamic> toJson() => _$MetricsToJson(this);
}