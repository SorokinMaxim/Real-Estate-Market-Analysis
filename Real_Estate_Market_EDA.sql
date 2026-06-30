USE RealEstateEDA;

-- 1. DATA EXPLORATION AND QUALITY CHECK

-- 1.1 Total row count
select count(*) as total_rows from housing;

-- 1.2 Price Overview
select 
	min(SalePrice) as min_price,
	max(SalePrice) as max_price,
	round(avg(cast(SalePrice as float)), 0) as avg_price,
	round(avg(cast(GrLivArea as float)), 0) as avg_living_area_sqft,
	round(avg(cast(LotArea as float)), 0) as avg_lot_area_sqft,
	round(avg(cast(TotalBsmtSF as float)), 0) as avg_basement_sqft
from housing;

-- 1.3 Sale price distribution
select 
  case
    when SalePrice < 100000 then 'Under $100k'
	when SalePrice < 150000 then '$100k - $150k'
	when SalePrice < 200000 then '$150k - $200k'
	when SalePrice < 250000 then '$200k - $250k'
	when SalePrice < 300000 then '$250k - $300k'
	when SalePrice < 400000 then '$300k - $400k'
  else 'Over $400k'
end as price_range,
count(*) as listing
from housing
group by 
 case
    when SalePrice < 100000 then 'Under $100k'
	when SalePrice < 150000 then '$100k - $150k'
	when SalePrice < 200000 then '$150k - $200k'
	when SalePrice < 250000 then '$200k - $250k'
	when SalePrice < 300000 then '$250k - $300k'
	when SalePrice < 400000 then '$300k - $400k'
  else 'Over $400k'
 end
order by min(SalePrice);

-- 2. DATA EXPLORATION AND QUALITY CHECK
-- 2.1 Full neighborhood summary
select
 Neighborhood,
 count(*) as listings,
 round(avg(cast(SalePrice as float)), 0) as avg_price,
 round(avg(cast(SalePrice as float) / GrLivArea), 0) as avg_price_per_sqft,
 min(SalePrice) as min_price,
 max(SalePrice) as max_price,
 round(avg(cast(GrLivArea as float)), 0) as avg_living_area_sqft,
 round(avg(cast(LotArea as float)), 0) as avg_lot_area_sqft,
 round(avg(cast(OverallQual as float)), 1) as avg_quality_score
from housing
group by Neighborhood
order by avg_price desc;

-- 2.2 Price by zoning type
select
 MSZoning,
 count(*) as listing,
 round(avg(cast(SalePrice as float)), 0) as avg_price,
 round(avg(cast(SalePrice as float) / GrLivArea), 0) as avg_price_per_sqft
from housing
group by MSZoning
order by avg_price desc;

-- 2.3 Price gap between most and least expensive neighborhood
select 
 round(max(avg_price) - min(avg_price), 0) as price_gap,
 round((max(avg_price) - min(avg_price)) * 100.0 / min(avg_price), 1) as percent_diff
from (
 select Neighborhood, avg(cast(SalePrice as float)) as avg_price
 from housing
 group by Neighborhood
) as neighborhood_avgs;

-- 3. SIZE AND SPACE ANALYSIS
-- 3.1 Does total living area drive prices?
select
 case
  when GrLivArea < 1000 then 'Under 1,000 sqft'
  when GrLivArea < 1500 then 'Under 1,000 - 1,500 sqft'
  when GrLivArea < 2000 then 'Under 1,500 - 2,000 sqft'
  when GrLivArea < 2500 then 'Under 2,000 - 2,500 sqft'
  when GrLivArea < 3000 then 'Under 2,500 - 3,000 sqft'
  else 'Over 3,000 sqft'
 end as size_range,
 count(*) as listing,
 round(avg(cast(SalePrice as float)), 0) as avg_prices,
 round(avg(cast(SalePrice as float) / GrLivArea), 0) as avg_price_per_sqft
from housing
group by
 case
  when GrLivArea < 1000 then 'Under 1000 sqft'
  when GrLivArea < 1500 then 'Under 1000 - 1500 sqft'
  when GrLivArea < 2000 then 'Under 1500 - 2000 sqft'
  when GrLivArea < 2500 then 'Under 2000 - 2500 sqft'
  when GrLivArea < 3000 then 'Under 2500 - 3000 sqft'
  else 'Over 3000 sqft'
 end
order by min(GrLivArea);

-- 3.2 Does basement size add value?
select
 case
  when TotalBsmtSF = 0 then 'No basement'
  when TotalBsmtSF < 500 then 'Small (under 500 sqft)'
  when TotalBsmtSF < 1000 then 'Medium (500 - 1000 sqft)'
  when TotalBsmtSF < 1500 then 'Large (1000 - 1500 sqft)'
  else 'Extra Large (1500+ sqft)'
 end as basement_size,
 count(*) as listings,
 round(avg(cast(SalePrice as float)), 0) as avg_basement_price
from housing
group by 
case
  when TotalBsmtSF = 0 then 'No basement'
  when TotalBsmtSF < 500 then 'Small (under 500 sqft)'
  when TotalBsmtSF < 1000 then 'Medium (500 - 1000 sqft)'
  when TotalBsmtSF < 1500 then 'Large (1000 - 1500 sqft)'
 else 'Extra Large (1500+ sqft)'
end
order by min(TotalBsmtSF);

-- 3.3 Avg price by total rooms above ground
select
 TotRmsAbvGrd as total_rooms,
 count(*) as rooms_count,
 round(avg(cast(SalePrice as float)),0) as avg_room_price
from housing
group by TotRmsAbvGrd
order by avg_room_price desc;

-- 3.4 Lot shape and contour vs price
select
 LotShape,
 LandContour,
 count(*) as lot_count,
 round(avg(cast(SalePrice as float)),0) as avg_lot_price,
 round(avg(cast(SalePrice as float)),0) as avg_lot_area
from housing
group by LotShape, LandContour
order by avg_lot_price desc;

-- 4. QUALITY & CONDITION ANALYSIS
-- 4.1 Avg price by overall quality score (1-10)
select
 OverallQual as quality_score,
 count(*) as score_count,
 round(avg(cast(SalePrice as float)),0) as avg_price,
 round(avg(cast(SalePrice as float) / GrLivArea),0) as avg_price_per_sqft
from housing
group by OverallQual
order by avg_price desc;

-- 4.2 Average Price by overall condition score (1-10)
select
 OverallCond as condition_score,
 count(*) as score_count,
 round(avg(cast(SalePrice as float)),0) as avg_price
from housing
group by OverallCond
order by avg_price desc;

-- 4.3 Quality vs Condition — which matters more?
select
 'Top Quality (8-10)' as category,
 count(*) as category_count,
 round(avg(cast(SalePrice as float)), 0) as avg_price
from housing where OverallQual >= 8
union all
select
 'Top Condition (8-10)',
 count(*),
 round(avg(cast(SalePrice as float)), 0)
from housing where OverallCond >= 8
union all
select
 'Average Quality (5)',
 count(*),
 round(avg(cast(SalePrice as float)), 0)
from housing where OverallQual = 5;

-- 4.4 Kitchen quality vs price
select 
 KitchenQual as kitchen_type,
 count(*) as type_count,
 round(avg(cast(SalePrice as float)), 0) as avg_price
from housing
group by KitchenQual
order by avg_price desc;

-- 4.5 Exterior quality vs price
select 
 ExterQual as exterior_type,
 count(*) as type_count,
 round(avg(cast(SalePrice as float)), 0) as avg_price
from housing
group by ExterQual
order by avg_price desc;

-- 4.6 Does kitchen and exterior combination leads to a bigger price?
select
  KitchenQual as kitchen_type,
  ExterQual as exterior_type,
  count(*) as type_count,
  round(avg(cast(SalePrice as float)), 0) as avg_price
from housing
group by KitchenQual, ExterQual
order by avg_price desc;

-- 5: BEDROOMS, BATHROOMS & FEATURES
-- 5.1 Avg price by bedrooms above grade
select
 BedroomAbvGr as bedrooms,
 count(*) as bedrooms_count,
 round(avg(cast(SalePrice as float)) ,0) as avg_price,
 round(avg(cast(GrLivArea as float)) ,0) as avg_size_sqft
from housing
group by BedroomAbvGr
order by avg_price desc;

-- 5.2 Avg price by bathrooms (full + half combined)
select
 FullBath,
 HalfBath,
 FullBath + Halfbath as total_bathrooms,
 count(*) as bathrooms_count,
 round(avg(cast(SalePrice as float)), 0) as avg_price
from housing
group by FullBath, HalfBath
order by avg_price desc;

-- 5.3 Does having Fireplaces add value?
select
 case
  when Fireplaces = 0 then 'No Fireplace'
  when Fireplaces = 1 then '1 Fireplace'
  else '2+ Fireplaces'
end as fireplaces_available,
count(*) fireplaces_count,
round(avg(cast(SalePrice as float)), 0) as avg_price
from housing
group by
 case
   when Fireplaces = 0 then 'No Fireplace'
   when Fireplaces = 1 then '1 Fireplace'
   else '2+ Fireplaces'
 end
order by avg_price desc;

-- 5.4 Houses with Central Air and no Central Air comparison 
select
 CentralAir as is_central_air, 
 count(*) as central_air_count,
 round(avg(cast(SalePrice as float)), 0) AS avg_price
from housing
group by CentralAir
order by avg_price desc;

-- 5.5 Does bigger garage area add value?
select top 10
 GarageArea as garage_area,
 count(*) as garage_area_count,
 round(avg(cast(SalePrice as float)), 0) AS avg_price,
 round(avg(cast(GarageArea as float)), 0) AS avg_garage_sqft
from housing
where GarageArea > 0
group by GarageArea
order by avg_price desc;

-- 6: AGE & RENOVATION ANALYSIS
-- 6.1 Renovated and never renovated price comparison
select
 case
  when YearRemodAdd = YearBuilt then 'Never Renovated'
  else 'Renovated'
 end as renovation_status,
 count(*) as renovation_status_count,
 round(avg(cast(SalePrice as float)), 0) AS avg_price
from housing
group by
 case
  when YearRemodAdd = YearBuilt then 'Never Renovated'
  else 'Renovated'
 end;

-- 6.2 Avg price and quality by decade built
select
 (YearBuilt / 10) * 10 as decade_built,
 count(*) as house_count,
 round(avg(cast(SalePrice as float)), 0) AS avg_price,
 round(avg(cast(GrLivArea as float)), 0) AS avg_size_sqft,
 round(avg(cast(OverallQual as float)), 1) AS avg_quality
from housing
group by (YearBuilt / 10) * 10 
order by decade_built desc;

-- 6.3 Newer vs older homes comparison
select
 case
  when YearBuilt >= 2000 then 'Built after 2000'
  when YearBuilt >= 1980 then 'Built between 1980-1999'
  when YearBuilt >= 1960 then 'Built between 1960-1979'
  else 'Built before 1960'
 end as time_period,
 count(*) as count,
 round(avg(cast(SalePrice as float)), 0) AS avg_price,
 round(avg(cast(OverallCond as float)), 0) AS avg_condition
from housing
group by
 case
  when YearBuilt >= 2000 then 'Built after 2000'
  when YearBuilt >= 1980 then 'Built between 1980-1999'
  when YearBuilt >= 1960 then 'Built between 1960-1979'
  else 'Built before 1960'
 end
order by min(YearBuilt) desc;

-- 7: OUTLIER DETECTION
-- 7.1 Price outliers
select top 20
 Id,
 Neighborhood,
 MSZoning,
 YearBuilt,
 GrLivArea                     AS living_area_sqft,
 OverallQual                   AS quality_score,
 SalePrice,
 round(cast(SalePrice as float) / GrLivArea, 0) as price_per_sqft
from housing
where SalePrice > (select avg(SalePrice) * 2 from housing)
order by SalePrice desc;

-- 7.2 Too big or unrealistic area for homes
select
 Id,
 Neighborhood,
 GrLivArea                     AS living_area_sqft,
 SalePrice,
 OverallQual,
 round(cast(SalePrice as float) / GrLivArea, 0) as price_per_sqft
from housing
where GrLivArea > 4000
order by GrLivArea desc;

-- 7.3 Underpriced large homes
select
 Id,
 Neighborhood,
 GrLivArea                     AS living_area_sqft,
 SalePrice,
 OverallCond,
 round(cast(SalePrice as float) / GrLivArea, 0) as price_per_sqft
from housing
where GrLivArea > 1800
 and cast(SalePrice as float) / GrLivArea < 110
order by price_per_sqft asc;

-- 8: EXPORT QUERIES FOR POWER BI
select
  Id,
  Neighborhood as neighborhood,
  MSZoning as zoning,
  GrLivArea as living_area_sqft,
  TotalBsmtSF as basement_sqft,
  LotArea as lot_area_sqft,
  LotShape as lot_shape,
  LandContour as land_contour,
  BedroomAbvGr as bedrooms_above_ground,
  FullBath as full_bath,
  HalfBath as half_bath,
  FullBath + HalfBath as total_bathrooms,
  TotRmsAbvGrd as total_rooms,
  OverallQual as quality_score,
  OverallCond as condition_score,
  KitchenQual as kitchen_quality,
  ExterQual as exterior_quality,
  YearBuilt as year_build,
  YearRemodAdd as year_remodeled,
  GarageCars as garage_capacity,
  GarageArea as garage_sqft,
  Fireplaces as fireplaces,
  CentralAir as central_air,
  SalePrice as sale_price,
  round(cast(SalePrice as float) / nullif([GrLivArea], 0), 0) as price_per_sqft,
  case
    when YearRemodAdd = YearBuilt then 'Never Renovated'
    else 'Renovated'
  end                                                         as renovation_status,
  (YearBuilt / 10) * 10                                       as decade_built,
  case
    when YearBuilt >= 2000 then 'Built 2000+'
    when YearBuilt >= 1980 then 'Built 1980-1999'
    when YearBuilt >= 1960 then 'Built 1960-1979'
    else 'Built before 1960'
  end                                                         as time_period,
  case
    when SalePrice > (select avg([SalePrice]) * 2 from housing) then 'Outlier'
    else 'Normal'
  end                                                         as price_flag
from housing
where [GrLivArea] > 0
order by Id asc;