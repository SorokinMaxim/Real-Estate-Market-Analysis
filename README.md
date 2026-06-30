# Real Estate Market Dashboard — Power BI

## Introduction

This dashboard was created to explore and analyze residential real estate sales in Ames, Iowa, using a real-world housing dataset. The project allowed me to work through the full data analytics routine: from running a structured SQL-based exploratory data analysis to building a two-page interactive Power BI dashboard with drill-through navigation.

## Abbreviations & Field Reference

This section explains the coded fields and abbreviations used throughout the analysis and dashboard, drawn from the dataset's data dictionary.

**Zoning (MSZoning):** 
- A = Agriculture; 
-  C = Commercial; 
- FV = Floating Village Residential; 
- I = Industrial; 
- RH = Residential High Density; 
- RL = Residential Low Density; 
- RP = Residential Low Density Park; 
- RM = Residential Medium Density.

**Lot Shape (LotShape):** 
- Reg = Regular; 
- IR1 = Slightly Irregular; 
- IR2 = Moderately Irregular; 
- IR3 = Irregular.

**Land Contour (LandContour):** 
- Lvl = Near Flat/Level; 
- Bnk = Banked (quick rise from street to building); 
- HLS = Hillside (significant side-to-side slope); 
- Low = Depression.

**Quality & Condition Ratings (ExterQual, ExterCond, KitchenQual, BsmtQual, HeatingQC, GarageQual, GarageCond, PoolQC):** 
- Ex = Excellent; 
- Gd = Good; 
- TA = Average/Typical; 
- Fa = Fair; 
- Po = Poor; 
- NA = Not Applicable / feature not present.

**Neighborhood codes:** 
- NridgHt = Northridge Heights; 
- NoRidge = Northridge; 
- StoneBr = Stone Brook; 
- CollgCr = College Creek; 
- Blmngtn = Bloomington Heights; 
- NAmes = North Ames; 
- NWAmes = Northwest Ames; 
- OldTown = Old Town; 
- SWISU = South & West of Iowa State University; 
- SawyerW = Sawyer West; 
- ClearCr = Clear Creek; 
- MeadowV = Meadow Village; 
- IDOTRR = Iowa DOT and Rail Road; 
- BrkSide = Brookside; 
- Crawfor = Crawford; 
- Mitchel = Mitchell; 
- Gilbert = Gilbert; 
- Sawyer = Sawyer; Timber = Timberland; 
- Veenker = Veenker.

**Other key fields:** 
- OverallQual / OverallCond = overall material/finish and condition rated 1 (Very Poor) to 10 (Very Excellent); 
- LivArea = above-grade living area in sqft; TotalBsmtSF = total basement square footage; 
- FullBath / HalfBath = full and half bathrooms above grade; YearBuilt = original construction year; 
- YearRemodAdd = remodel year (equals YearBuilt if no remodel occurred); 
- CentralAir = Y/N indicator for central air conditioning; 
- SalePrice = the final transaction price, used as the primary target metric throughout this analysis.

## Skills Showcased

-   **SQL-based Exploratory Data Analysis:** Wrote 27 SQL queries across seven analytical sections to investigate price drivers, covering data quality checks, neighborhood and zoning comparisons, size/space analysis, quality and condition scoring, room and amenity counts, age/renovation trends, and outlier detection.
-   **Data Quality & Outlier Detection:** Identified top-end price outliers and flagged underpriced large homes (high living area, low price per sqft) to separate genuine market signal from anomalies before modeling visuals.
-   **Data Modeling:** Structured the cleaned dataset for Power BI, enabling neighborhood-level filtering and drill-through to a dedicated per-neighborhood detail page.
-   **Core Charts:** Used bar, scatter, line, and stacked/treemap-style visuals to answer specific analytical questions rather than just display data.
-   **KPI Cards:** Median Sale Price, Median Sale Price per Sqft, Total Houses, and Median Living Area.
-   **Dashboard Design:** Designed a clean, light-blue rounded-card theme across a Main Page and a Drill-Through Page for neighborhood-level deep dives.

## Interactive Reporting

-   **Slicers:** Neighborhood dropdown filters all visuals on the Main Page at once.
-   **Drill-Through:** Clicking "Drill Through Neighborhood" navigates to a dedicated page showing detailed price drivers for that specific neighborhood (e.g., Timber).
-   **Cross-filtering:** Visuals on each page respond together to the active neighborhood selection.

## Dashboard Overview

**Page 1 — Main Page** 

Screenshot placeholder

Answers core market questions:

-   **How big is the market? —** KPI cards show 1,460 total types of houses, a median sale price of $163K, $120 median price per sqft, and 1,464 sqft median living area.
-   **Which neighborhoods command the highest prices? —** Bar chart ranks neighborhoods by median sale price, led by NridgHt and NoRidge near $300K+.
-   **How do price and living area relate? —** Scatter plot of median price vs. living area shows a generally positive relationship, with NoRidge and StoneBr combining high price and high size, while OldTown and SWISU cluster at the lower end of both metrics.
-   **How has price evolved by year built? —** Line chart of median sale price by year built shows a long-run upward trend with sharp spikes for select newer-built homes, including a peak around $394K.
-   **What does the housing stock look like? —** Zoning breakdown shows Residential Low Density (RL) dominates at 79% of listings, followed by Residential Medium Density (RM) at 15%; land contour is overwhelmingly Level (Lvl) at 90%.

**Page 2 — Drill-Through Page (Neighborhood Detail)**

Screenshot placeholder

Drilling into a neighborhood reveals what actually drives price within that market:

-   **What amenities configuration gives the best price? —** Bar chart crossing bedroom and bathroom counts shows 4 bedrooms / 3 bathrooms reaching the highest price band.
-   **What quality and condition score give the best price? —** Quality score 9 combined with a mid-range condition score produces the top price band, confirming quality outweighs condition.
-   **How has sale price changed over time? —** Line chart by build-era shows prices peaking for homes built 1960–1979 within this neighborhood before dipping and recovering for the newest builds.
-   **How does garage capacity and fireplace count impact price? —** Larger garage capacity paired with more fireplaces consistently pushes sale price higher.
-   **How do kitchen/exterior quality and renovation status affect price? —** Donut charts show "Good" kitchen/exterior quality dominates the neighborhood (60%+), and renovated homes sell for roughly $46K more on average than never-renovated ones in this view.

## EDA Overview

The exploratory analysis was carried out in SQL across seven structured sections before any visuals were built.

## 1. Data Exploration and Quality Check ##

**1.1 Total row count** — The dataset contains 1,460 property sale records, confirming the full sample size available for analysis.

**1.2 Price overview** — Sale prices range from $34,900 to $755,000 with an average of $180,921, alongside average living area (1,515 sqft), lot area (10,517 sqft), and basement size (1,057 sqft), establishing a baseline for the rest of the analysis.

**1.3 Sale price distribution** — The market is heavily concentrated in the $100K–$200K band (over 900 of 1,460 listings), with very few homes selling above $400K, indicating a right-skewed, mid-market-dominated dataset.

## 2. Neighbourhood and Zoning Analysis ##

**2.1 Full neighborhood summary** — NoRidge, NridgHt, and StoneBr post the highest average prices and quality scores, while CollgCr and Blmngtn show high listing volume at more moderate price points, pointing to a clear premium-vs-volume split across neighborhoods.

**2.2 Price by zoning type** — Floating Village Residential (FV) commands the highest average price per sqft ($136), narrowly ahead of Residential Low Density (RL), while Commercial-zoned (C) parcels sell far lower, confirming zoning is a meaningful price driver.

**2.3 Price gap between most and least expensive neighborhood** — The most expensive neighborhood sells for 240% more than the least expensive one, a $236,719 gap, showing location alone can more than triple a home's value.

## 3. Size and Space Analysis ##

**3.1 Does total living area drive prices?** — Average price rises steadily with size, from $112,985 under 1,000 sqft to $388,631 over 3,000 sqft, but price per sqft actually declines as homes get larger, suggesting diminishing marginal returns on extra space.

**3.2 Does basement size add value?** — Homes with no basement average $105,653 while those with an extra-large basement (1,500+ sqft) average $284,759, making basement size one of the strongest size-related price signals in the dataset.

**3.3 Avg price by total rooms above ground** — Price climbs almost linearly with room count up to 11 rooms ($318,022 average), reinforcing that more above-grade rooms reliably track with higher value.

**3.4 Price by lot shape and contour** — Irregular lot shapes on hillside contours (e.g., IR2/HLS) post the highest average prices, while regular lots on banked contours (Reg/Bnk) sit at the bottom, showing lot geometry has a real but secondary effect on price.

## 4. Quality & Condition Analysis ##

**4.1 Avg price by overall quality score** — Price scales almost directly with quality score, from $50,150 at score 1 to $438,588 at score 10, making overall quality the single strongest price driver identified in this analysis.

**4.2 Avg price by overall condition score** — Condition score shows a much weaker and less consistent relationship with price than quality, with score 9 oddly outperforming score 8, suggesting condition matters but isn't a clean linear driver.

**4.3 Which matters more Quality or Condition?** — Top-quality homes (score 8–10) average $305,036 versus $169,777 for top-condition homes, confirming quality is the dominant lever and condition plays a secondary role.

**4.4 Price by kitchen quality** — Excellent kitchens average $328,555 versus $105,565 for fair kitchens, a roughly 3x gap, making kitchen quality one of the clearest single-feature price signals.

**4.5 Price by exterior quality** — Excellent exteriors average $367,361 versus $87,985 for fair exteriors, an even wider gap than kitchen quality, highlighting curb appeal as a major value driver.

**4.6 Does kitchen and exterior combination lead to a bigger price?** — Homes with excellent ratings on both kitchen and exterior average $384,854, the highest combination in the dataset, showing the two features compound rather than substitute for each other.

## 5. Bedrooms, Bathrooms & Features ##

**5.1 Avg price by bedrooms above grade** — Price doesn't increase monotonically with bedroom count; 4-bedroom homes average more than 5- or 6-bedroom homes, suggesting bedroom count alone is a weaker driver once homes get unusually large.

**5.2 Avg price by bathroom count** — Homes with 4 total bathrooms (3 full + 1 half) average $417,266, by far the highest band, showing bathroom count is a strong price signal, especially combinations including a half bath.

**5.3 Fireplaces — does having one add value?** — Homes with 2+ fireplaces average $241,064 versus $141,331 for none, a roughly 70% premium, confirming fireplaces are a meaningful amenity driver.

**5.4 Central Air comparison** — Homes with central air average $186,187 versus $105,264 without, a gap of nearly $81K, making central air one of the most decisive binary price factors in the dataset.

**5.5 Garage size vs price** — The highest-priced individual sales consistently pair with larger garage areas (800+ sqft), reinforcing garage capacity as a value-adding feature rather than a coincidental correlation.

## 6. Age & Renovation Analysis ##

**6.1 Renovated vs never-renovated comparison** — Surprisingly, never-renovated homes average slightly higher prices ($182,584) than renovated ones ($179,096) at the aggregate level, indicating renovation status alone isn't a reliable price predictor without controlling for original build quality.

**6.2 Avg price and quality by decade built** — Both price and quality score trend upward by decade built overall, but a small cluster of homes built in the 1890s shows unusually high average price ($216,317), likely reflecting a handful of well-preserved historic properties rather than a broad trend.

**6.3 Newer vs older homes comparison** — Homes built after 2000 average $242,439 versus $135,253 for homes built before 1960, nearly double, confirming build era is one of the clearest macro price drivers alongside quality.

## 7. Outlier Detection ##

**7.1 Price outliers** — The ten highest-priced sales are concentrated almost entirely in NoRidge, NridgHt, and StoneBr, all RL-zoned with quality scores of 8–10, confirming the top of the market is driven by a small, consistent set of premium neighborhoods.

**7.2 Too big or unrealistic area for homes** — A handful of very large homes (4,300–5,600 sqft) in Edwards and NoRidge sell at sharply different price-per-sqft ratios ($28–$175), flagging genuine data outliers that warrant exclusion or special handling in any predictive model.

**7.3 Underpriced large homes** — Dozens of large homes (1,800–3,500+ sqft) carry unusually low price per sqft, heavily concentrated in OldTown, NAmes, and SWISU, suggesting these older, lower-condition neighborhoods systematically undervalue square footage relative to premium areas.

## Key Findings

-   **Overall quality score is the single strongest price driver** in the dataset, with average price climbing from $50K at the lowest quality rating to $438K at the highest.
-   **Location creates the widest price gap of any factor measured:** the priciest neighborhood sells for 240% more than the cheapest, a difference of nearly $237K.
-   **Kitchen and exterior quality compound:** homes excellent in both average $384,854, the highest price combination found in the analysis.
-   **Central air adds a $81K average premium**, and homes with 2+ fireplaces sell for roughly 70% more than homes with none.
-   **Renovation status alone does not reliably predict price** — never-renovated homes in this dataset actually average slightly higher than renovated ones, meaning original build quality outweighs remodel history.
-   **Older, lower-condition neighborhoods (OldTown, NAmes, SWISU) systematically show large homes selling at a discounted price per sqft**, marking them as the dataset's clearest pocket of underpriced inventory.

## Conclusion

This project demonstrates my ability to move from raw tabular housing data to a structured SQL-driven EDA and, ultimately, a polished interactive Power BI dashboard with drill-through navigation. It's well suited for anyone interested in real estate valuation, the relative weight of structural vs. cosmetic home features, or general data storytelling about what actually drives residential sale prices in a mid-sized U.S. housing market.
