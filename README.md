# Superstore Profitability Analysis

## Objective

Investigate why company profit margin declined from 13.33% in 2016 to 12.80% in 2017 using SQL analysis of the Superstore dataset.

## Dataset

The Superstore dataset contains sales transactions, profit, discounts, products, categories, regions, customers, and order dates from 2014–2017.

## Tools and Techniques

* MySQL
* Data Cleaning (converted date fields to MySQL date format, validated new date columns, renamed date columns to replace original fields, and verified dates could be used with functions such as YEAR() and MONTH())
* Aggregations and Grouping
* Common Table Expressions (CTEs)
* Conditional Aggregation using CASE
* Profit Margin Analysis

## Analysis Process

1. Analyzed company-level sales, profit, and profit margins by year.
2. Investigated category-level profitability trends.
3. Identified sub-categories with the largest profit margin declines.
4. Focused on the Binders sub-category due to its significant margin deterioration.
5. Tested whether increased discounting explained the decline.
6. Investigated product-level profitability changes between 2016 and 2017.

## Key Findings

### Company-Level Results

Company profit margin declined from **13.33% in 2016** to **12.80% in 2017**.

### Category-Level Results

| Category        | Margin 2016 | Margin 2017 | Change |
| --------------- | ----------: | ----------: | -----: |
| Furniture       |       3.24% |       1.30% | -1.94% |
| Office Supplies |      19.03% |      16.31% | -2.72% |
| Technology      |      17.57% |      18.64% | +1.07% |

Office Supplies experienced the largest category-level decline in profitability.

### Sub-Category Results

The largest sub-category margin declines between 2016 and 2017 were:

| Sub-Category | Margin 2016 | Margin 2017 |  Change |
| ------------ | ----------: | ----------: | ------: |
| Machines     |       5.20% |      -6.59% | -11.79% |
| Binders      |      20.60% |      10.74% |  -9.86% |
| Tables       |      -4.85% |     -13.37% |  -8.52% |
| Bookcases    |       0.81% |      -1.94% |  -2.75% |

Because Binders experienced one of the largest declines, it became the focus of further investigation.

### Binder Investigation

Average discounts remained stable over time:

| Year | Average Discount |
| ---- | ---------------: |
| 2014 |             0.38 |
| 2015 |             0.38 |
| 2016 |             0.36 |
| 2017 |             0.37 |

This suggests that increased discounting was unlikely to be the primary cause of the margin decline.

### Product-Level Results

Several major Binder products that were profitable in 2016 became heavily loss-making in 2017.

| Product                                                    | Margin 2016 | Margin 2017 |   Change |
| ---------------------------------------------------------- | ----------: | ----------: | -------: |
| Fellowes PB500 Electric Punch Plastic Comb Binding Machine |      44.44% |     -20.69% |  -65.13% |
| Ibico Hi-Tech Manual Binding System                        |      31.25% |     -32.00% |  -63.25% |
| GBC Ibimaster 500 Manual ProClick Binding System           |      23.08% |    -150.00% | -173.08% |
| Ibico EPK-21 Electric Binding System                       |      36.25% |    -155.00% | -191.25% |

The most notable example was the Fellowes PB500 Electric Punch Plastic Comb Binding Machine, which increased sales from **$2,287.78** in 2016 to **$7,371.74** in 2017 while its profit margin fell from **44.44%** to **-20.69%**.

## Conclusion

The decline in company profitability was partly driven by significant margin deterioration within the Binders sub-category. Analysis showed that average discounts remained stable between 2016 and 2017, indicating that increased discounting was unlikely to be the primary cause. Instead, several previously profitable Binder products became heavily loss-making in 2017, suggesting that product-level profitability deterioration was a major contributor to the decline.
