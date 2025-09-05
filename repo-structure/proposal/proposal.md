# Project proposal

Team name

``` r
library(tidyverse)
library(broom)
```

## 1. Introduction

#### Motivation:

Poverty, health, environmental quality, and happiness are interconnected in ways that matter deeply for global well-being.
Yet these relationships are often studied in isolation.
This project aims to explore how these dimensions interact at the global level.

#### **Goal:**

Combine three major datasets — the World Bank Development Indicators, the Global Health Observatory (WHO), and the World Happiness Report — to investigate how income, environment, and health outcomes interact to shape happiness across countries.

### Research Questions:

-   How strong is the relationship between national income and life expectancy?
-   Do countries with higher renewable energy adoption show better health outcomes?
-   Are wealthier countries always happier, or do health and environmental factors explain additional variation?
-   Which factors (income, environment, or health outcomes) are the strongest predictors of happiness?
-   Do countries with similar GDP but different environmental quality show different levels of happiness?
-   Can a multiple regression model predict happiness score from GDP per capita, life expectancy, social support, and environmental quality? Which variable is most important?

## 2. Data

Data Wrangling:

-   Join datasets by country and year (aligning around 2015–2020 for data availability).
-   Clean variable names, handle missing values, standardize units if needed.

Exploratory Analysis:

-   Summary statistics (mean, median, range) for each key variable by continent.
-   Visualizations: scatterplots, boxplots, density plots, correlation heatmaps.

Comparative Grouping:

-   Divide countries into quartiles of happiness scores.
-   Compare average GDP per capita, life expectancy, and air pollution exposure across groups.

Modeling (optional, if time/skill level allows):

-   Multiple regression predicting happiness score \~ GDP per capita + life expectancy + air quality + social support.
-   Evaluate which predictors are strongest.

## 3. Data analysis plan

### Data Preparation

-   Merge datasets by country (and by year where possible, e.g., 2015–2020).
-   Clean variable names, check units, and handle missing values.
-   Create derived indicators (e.g., GDP quartiles, air quality quartiles).

### Core Research Questions with Methods

How strong is the relationship between national income and life expectancy?

-   Scatterplot: GDP per capita (x) vs. Life expectancy (y), color by continent.
-   Correlation coefficient to quantify strength.
-   Facet by continent for regional variation.

Do countries with higher renewable energy adoption show better health outcomes?

-   Scatterplot: % renewable energy (x) vs. Life expectancy (y).
-   Grouped bar plots: average life expectancy by renewable energy quartile.
-   Regression line to visualize trend.

Are wealthier countries always happier, or do health and environmental factors explain additional variation?

-   Scatterplot: GDP per capita (x) vs. Happiness score (y), bubble size = life expectancy, color = continent.
-   Residual plot: happiness vs. GDP, then plot residuals against air pollution.
-   Boxplots: happiness across GDP quartiles.

Which factors (income, environment, or health outcomes) are the strongest predictors of happiness?

-   Correlation heatmap of happiness vs. GDP, life expectancy, air quality.
-   Multiple regression: Happiness \~ GDP + Life expectancy + Air quality.
-   Coefficient plot to compare effect sizes.

Do countries with similar GDP but different environmental quality show different levels of happiness?

-   Scatterplot: GDP per capita (x) vs. Happiness score (y), color = air pollution.
-   Highlight clusters of countries with similar GDP but divergent happiness.
-   Faceted plots: GDP vs. Happiness by air quality quartile.

Can a multiple regression model predict happiness score from GDP per capita, life expectancy, social support, and environmental quality?
Which variable is most important?

-   Regression model with multiple predictors.
-   Coefficient plot with standardized betas.
-   Partial regression plots for each predictor.

## 4. Expected Results

-   Strong positive relationship between GDP and life expectancy, with diminishing returns at higher incomes.
-   Higher renewable energy shares loosely associated with better health outcomes.
-   Happiness correlates with wealth but also reflects health, social support, and environment.
-   Environmental quality helps explain differences in happiness among countries with similar GDP.
-   Regression will likely show GDP and social support as strongest predictors, but life expectancy and environment remain meaningful contributors.
