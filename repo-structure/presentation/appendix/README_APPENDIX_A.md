# Appendix A: Summary Analytics — Lichess vs. FIDE Rating Patterns
_Last updated: October 2025_  
_Author: Tina Huynh_

## Overview

**Objective:** This document aims to provide a comprehensive comparative analysis of rating distributions, win-rate patterns, and player activity behaviors between the Lichess online platform and the FIDE over-the-board (OTB) rating system. The objective is to identify systemic disparities, calibration differences, and behavioral trends that influence how player skill is represented, measured, and developed across these two competitive ecosystems.

**Document:** `appendix_a.rmd`
**Outputs:** `appendix_a.pdf`, `appendix_a.html`, `appendix_a.tex`  
**Analysis Type:** Descriptive statistics and comparative analytics

---

## Data Sources

### Primary Data
- **File:** `../../data/player_summary.csv`
- **Records:** 6 rating tier groups
- **Dimensions:** 20+ variables per tier
- **Coverage:** Under 1600 to 2600+ rating range

### Supplementary Data
- **File:** `../../data/lichess_clean.csv`
- **Records:** 527 individual users
- **Purpose:** User-level detail validation

### Data Structure
| Variable                   | Type    | Description                | Example     |
| -------------------------- | ------- | -------------------------- | ----------- |
| `rating_group`             | Factor  | Tier classification        | "1600–1999" |
| `lichess_avg_rating`       | Numeric | Mean Lichess rating        | 1815.5      |
| `fide_avg_rating_standard` | Numeric | Mean FIDE classical rating | 1805.5      |
| `lichess_avg_win_rate`     | Numeric | Win percentage             | 0.553       |
| `rating_gap_standard`      | Numeric | Lichess - FIDE difference  | 10.0        |
| `lichess_players`          | Integer | Sample size (Lichess)      | 60          |
| `fide_players`             | Integer | Sample size (FIDE)         | 285         |

---

## Analysis Sections

### Section A.1: Data Import and Preparation

**Purpose:** Load and validate tier-level summary data

**Code Operations:**
```r
library(tidyverse)
library(scales)

player_summary <- read_csv("../../data/player_summary.csv")
glimpse(player_summary)
summary(player_summary)
```

**Data Validation:**
- ✓ All 6 rating tiers are present
- ✓ There are no missing values in key columns
- ✓ The rating ranges align with the definitions of each tier
- ✓ The player counts add up correctly

**Output:** Preview of the data structure displaying 6 observations across more than 20 variables.

---

### Section A.2: Descriptive Overview

**Purpose:** Summary statistics table comparing platforms by tier

**Key Metrics:**
- Average ratings (Lichess vs. FIDE)
- Win rates per tier
- Player counts (sample sizes)
- Rating gaps (Lichess - FIDE)
- Average rating change per game

**Table Output:**
| Rating Group | FIDE Avg | Lichess Avg | Win Rate | Rating Change | Gap | Lichess N | FIDE N |
| ------------ | -------- | ----------- | -------- | ------------- | --- | --------- | ------ |
| Under 1600   | 1,378    | 1,425       | 55.1%    | +8.2          | +47 | 105       | 285    |
| 1600–1999    | 1,806    | 1,816       | 55.3%    | +9.1          | +10 | 60        | 285    |
| 2000–2399    | 2,195    | 2,212       | 54.8%    | +7.4          | +17 | 152       | 190    |
| 2400–2599    | 2,489    | 2,510       | 53.2%    | +5.9          | +21 | 158       | 95     |
| 2600+        | 2,721    | 2,758       | 51.8%    | +3.2          | +37 | 52        | 95     |

**Interpretation:**

1. **Rating Inflation Pattern:**
   - The most pronounced discrepancy in ratings occurs within the Under 1600 category, where players experience an average increase of 47 points. This suggests a significant phenomenon of rating inflation, particularly affecting beginners on Lichess, likely due to a higher influx of novice players and a consequent imbalance in skill assessment.
   - Conversely, the 1600–1999 range displays the smallest gap of just 10 points, indicating a more accurate and aligned rating system among mid-tier players. This suggests that ratings in this range reflect a more stable competitive landscape.
   - In the higher echelons of play, particularly for players rated 2600 and above, there is a notable resurgence in rating divergence, with an increase of 37 points. This reflects the challenges elite players face, as they tend to encounter increasingly specialized competition that can skew average ratings upward.

2. **Win Rate Trends:**
   - As players ascend the skill hierarchy, their win rates exhibit a gradual decline—from an average of 55.1% for lower-rated players to 51.8% for those in mid to high tiers. This trend underscores the increasing difficulty of the competition that higher-rated players encounter.
   - The win rate nearing 50% for those rated at 2600 and above suggests a highly competitive environment where matches are more evenly balanced, facilitating matches where both players have nearly equal chances of winning, reflecting effective matchmaking systems at elite levels.

3. **Activity Levels:**
   - Lichess demonstrates a stronger user activity at the lower tiers, with 105 active users compared to just 285 from the FIDE database. This disparity indicates a vibrant community of beginners engaging on the platform, contributing to the rating inflation phenomenon previously noted.
   - In contrast, the expert level (1600–1999) is predominantly influenced by FIDE-rated players, with a striking comparison of 285 active users from FIDE versus a mere 60 on Lichess in this range, indicating the significant presence and engagement of players who are more formally recognized within the chess community.
   - Among elite players (2600+), both platforms show similar engagement levels, with 52 active Lichess users compared to 95 from FIDE. This indicates that, while elite players are fewer in number, their engagement remains substantial on both platforms, highlighting a dedicated community of top-tier chess enthusiasts.

---

### Section A.3: Rating Comparison Visualization

**Chart:** Side-by-side grouped bar chart

**Visual Elements:**
- X-axis: Rating tiers (6 groups)
- Y-axis: Average rating (800–3000 range)
- Bars: FIDE (blue) vs. Lichess (orange)
- Labels: Exact rating values on top of each bar

**Data Interpretation:**

**Pattern 1: Parallel Progression**
- Both Lichess and FIDE platforms exhibit a strikingly similar upward trend across their respective rating tiers, suggesting a strong alignment in their assessment of player skills.
- This observation implies that the underlying metrics and criteria used in their rating systems are likely evaluating comparable dimensions of player ability and performance.
- The Pearson correlation coefficient of r = 0.998 indicates an almost perfect linear relationship between the two systems, showcasing that as ratings increase on one platform, they correspondingly increase on the other.

**Pattern 2: Consistent Rating Offset**
- Throughout all tiers, Lichess tends to allocate consistently higher ratings compared to FIDE, reflecting a systematic divergence in how player performance is recognized across the two platforms.
- The average rating difference between Lichess and FIDE spans from +10 points at the lower tiers to as much as +47 points at the lower skill levels, demonstrating a significant range in disparity.
- It's important to note that this discrepancy is not constant across all skill levels; rather, it varies significantly, indicating that the assessment criteria may intersect differently at varying tiers of expertise.

**Pattern 3: Divergence at the Extremes**
- Among players rated below 1600, the difference between Lichess and FIDE ratings peaks at +47 points, marking the highest observed gap and reflecting a pronounced inflation of online ratings at this entry-level range.
- For players whose ratings fall between 1600 and 1999, the gap diminishes to a mere +10 points, representing the smallest variation and suggesting a more consistent alignment in rating perception at these higher, yet still transitional, skill levels.
- Conversely, within the elite tier of players rated 2600 and above, the disparity is measured at +37 points, indicating a moderate variation that may reflect differences in competition and performance assessment at the highest echelons of chess.

**Importance of the Analysis:**
- This analysis underlines the critical need for adjustments when comparing Lichess ratings to those of FIDE, given the intrinsic differences in tier structures and rating methodologies.
- The phenomenon of rating inflation in online platforms, while prevalent, manifests with varying degrees of intensity across different skill levels, complicating direct comparisons.
- To achieve a more accurate and meaningful conversion between the two systems, it is advisable to implement piecewise conversion formulas rather than relying on a simplistic linear approach, acknowledging the nuances present in each tier's rating dynamics.

**Visual Analysis:**  
The nearly parallel bars indicated in the data suggest that the disparity between ratings is additive rather than multiplicative. A straightforward adjustment, such as deducting 20 points from the Lichess rating, would yield a more accurate reflection for mid-tier ratings in comparison to those at the extremes.

---

### Section A.4: Win Rate and Game Volume Analysis

#### Win Rate Distribution

**Chart:** Column chart with percentage labels

**Key Findings:**

1. **Inverse Skill-Win Rate Relationship:**
   - **Win Rates by Rating:**
     - Players rated under 1600 have a win rate of approximately 55.1%.
     - Conversely, players rated 2600 and above exhibit a win rate of about 51.8%.
   - **Detailed Explanation:** The phenomenon where lower-rated players achieve a higher win rate can be attributed to the more diverse skill levels they encounter in their matches. This broad range of competition results in more pronounced victories or defeats, as these players often face opponents whose skills can dramatically vary, thus leading to more definitive match outcomes.

2. **Statistical Baseline:**
   - **Expected Win Rate in Random Matchmaking:** The anticipated win rate in a completely random matchmaking scenario sits at a baseline of 50%.
   - **Observations:** The data reveals that all player tiers exceed this baseline win rate, which signals a positive selection bias within the sample studied. It implies that the Lichess user base participating in this analysis may be more engaged and potentially more skilled than the average player, skewing the results upwards in terms of win rates across all tiers.

3. **Variance Pattern:**
   - **Clustering of Win Rates:** The win rates across different skill tiers show a remarkable tight clustering within a narrow range of 51.8% to 55.3%. 
   - **Analysis of Spread:** This variance of only 3.3 percentage points across all tiers indicates that the matchmaking system in place for ELO ratings is functioning effectively. It suggests that players, regardless of their skill level, are being paired in a manner that ensures competitive balance and fair matchups, thereby fostering an overall consistent win rate distribution.

**Practical Implications:**  
- Relying solely on win rate as a measure of skill can be misleading, as it does not account for various factors that influence game outcomes.  
- To gain a more comprehensive understanding of a player's ability, it is essential to consider their rating tier in conjunction with their win rate. This allows for a more contextual analysis of performance.  
- Win rate is particularly valuable for comparing players within the same rating tier, as it provides insight into relative performance under similar competitive conditions. However, comparisons across different tiers can yield skewed interpretations of skill levels.

#### Game Volume Analysis

**Chart:** Line plot with points

**Observed Patterns:**

1. **Activity by Tier:**
   - **Under 1600 Rated Players:** Approximately 14 games are played on average within this tier, showcasing a high level of engagement among players who are often still developing their skills and tactics. The frequency of games indicates a strong investment in practice and improvement.
   - **1600–1999 Rated Players:** This tier exhibits the highest activity, with approximately 15 games played on average. This peak in activity suggests a competitive environment where players are actively seeking to refine their strategies and achieve higher ratings.
   - **2000–2399 Rated Players:** Players in this range participate in about 12 games on average, demonstrating moderate engagement. This suggests that while these players are competitive, they may also be more selective about the games they choose to play, possibly focusing on strategic preparation.
   - **2400 and Above:** In this elite tier, the average number of games played ranges from 8 to 10, reflecting a lower volume of activity. This decline in game participation may indicate a shift in focus towards in-depth analysis and preparation for fewer, high-stakes matches.

2. **Engagement Drop-off:**
   - Notably, there exists a significant 35% decrease in activity as players transition from the mid-tier (1600-1999) to the elite tier (2400 and above). This finding suggests that the demands on players’ time and resources increase at higher levels of competition, where game durations may be longer and preparation more extensive.
   - **Hypothesis:** The substantial decrease in the number of games played at the elite level may stem from time constraints faced by players who engage in more profound analysis and strategic preparation for each game. Elite players appear to prioritize the quality of their games over sheer quantity, opting for fewer matches that provide greater learning and competitive value.

3. **Correlation with Volatility:**
   - An interesting correlation emerges between game volume and rating volatility. A higher volume of games played is associated with lower volatility in player ratings.
   - **Under 1600 Rated Players:** In this tier, players tend to have a high number of games coupled with high volatility in their ratings. This phenomenon often signals that these players are in a learning phase, experimenting with different strategies and making rapid improvements.
   - **Between 2000 and 2399 Rated Players:** Here, the moderate number of games played is associated with lower volatility in ratings. This stability suggests a more consistent skill level among players, highlighting that as players gain experience, their performance becomes more reliable and predictable.

**Data Quality Note:**
Game counts reflect only the sample period of October 2025 and do not represent lifetime totals. Seasonal and temporal variations are not included in this data.

---

### Section A.5: Statistical Summary Metrics

**Aggregate Table Output:**

| Mean Gap | SD Gap | Median Win Rate | Total Lichess | Total FIDE | Rating-WinRate Corr |
| -------- | ------ | --------------- | ------------- | ---------- | ------------------- |
| +22.7    | 15.4   | 54.3%           | 527           | 950        | -0.842              |

**Statistical Interpretation:**

1. **Mean Rating Differential: +22.7 Points**
   - On average, Lichess ratings exceed FIDE ratings by 22.7 points.
   - This observation confirms a systematic positive bias in online ratings.
   - This result is consistent with prior research suggesting that the inflation of Lichess ratings ranges from 20 to 50 points.

2. **Standard Deviation of the Differential: 15.4 Points**
   - The variation of the rating gap is significant across different skill levels, with a standard deviation of 15.4 points.
   - The coefficient of variation is calculated as 15.4/22.7, yielding a value of 68%.
   - A single conversion constant is inadequate; therefore, tier-specific adjustments are essential.

3. **Median Win Rate: 54.3%**
   - This win rate exceeds the theoretical baseline of 50%.
   - It indicates a sample selection bias, as active participants are overrepresented in the data.
   - This finding aligns with the concept of "survivor bias" observed in studies related to chess ratings.

4. **Sample Sizes:**
   - The Lichess sample comprises 527 users, representing a smaller and more concentrated dataset.
   - In contrast, the FIDE sample includes 950 players, constituting a larger and more representative group.
   - The ratio of the Lichess sample size to that of FIDE is approximately 1:1.8, indicating that the FIDE sample is nearly twice as extensive.

5. **Rating-Win Rate Correlation: r = -0.842**
   - There exists a strong negative correlation, which is an unexpected outcome.
   - Higher-rated players tend to exhibit lower win rates.
   - This phenomenon can be attributed to the presence of stronger opponents at elevated skill tiers.
   - The Elo rating system functions as intended, maintaining a 50% win rate in equilibrium.

**Rating Gap Distribution Chart Overview:**
This chart features a richly colored purple bar graph designed to clearly illustrate the rating gap across various tiers of gameplay on Lichess. Among its notable characteristics are:
- **Positive Values:** These values signify an inflation in player ratings, indicating that players in certain tiers are experiencing higher ratings than might be deemed proportionate to their skills.
- **Reference Line:** A prominent red dashed line positioned at y=0 acts as an essential reference point, visually delineating the threshold for rating parity. This line indicates the point at which player ratings are balanced, allowing for an immediate understanding of positive and negative gaps.
- **Tier Labels:** Each tier is clearly marked with labels denoting the specific rating gap values, providing an instant reference for interpreting the data across the diverse levels of competition.

**Key Insights from the Chart:**
The distribution of the rating gap reveals a distinct U-shaped pattern, illustrating the variances in player ratings effectively:
- **Low Tier Analysis:** At the low tier, a significant gap of +47 is observed, suggesting a notable inflation in ratings for less experienced players. This gap indicates that beginners may be rated significantly higher than their performance would typically warrant.
- **Mid Tier Observation:** The mid tier reflects a minimal gap of +10, suggesting a more balanced rating environment where players' ratings closely align with their actual skill levels. This indicates a more competitive and fair playing field in this tier.
- **High Tier Findings:** The high tier reveals a moderate gap of +37, highlighting that even among more experienced players, there is still notable inflation in ratings, albeit less pronounced than in the low tier. This indicates ongoing disparities even at advanced levels of play, signifying potential complexities in rating evaluations.

**Analysis of the U-Shape:**
1. **Low Tier (+47):** Beginners tend to experience quick improvement online; however, their ratings often do not accurately reflect their true skills.
2. **Mid Tier (+10):** In this tier, ratings become more stable, showing little inflation.
3. **High Tier (+37):** Elite players who primarily compete online may be younger and thus face less formal competition compared to their counterparts in the FIDE system.

---

### Section A.6: Correlation Analysis

**Visualization:** Scatter plot matrix (4×4 grid) using `GGally::ggpairs()`

**Variables Analyzed:**
1. Lichess Average Rating
2. Win Rate
3. Rating Gap (Lichess - FIDE)
4. Sample Size (Lichess Players)

**Correlation Matrix Results:**

| Pair                   | Correlation | Strength    | Direction | Interpretation                                |
| ---------------------- | ----------- | ----------- | --------- | --------------------------------------------- |
| Rating × Win Rate      | **-0.842**  | Very Strong | Negative  | Higher skill → harder opponents → lower win % |
| Rating × Gap           | **+0.524**  | Moderate    | Positive  | Higher tiers → larger Lichess inflation       |
| Rating × Sample Size   | **-0.156**  | Weak        | Negative  | Fewer users at extreme tiers                  |
| Win Rate × Gap         | **-0.632**  | Moderate    | Negative  | Larger gap → lower observed win rates         |
| Win Rate × Sample Size | **+0.287**  | Weak        | Positive  | More users → more varied outcomes             |
| Gap × Sample Size      | **-0.419**  | Moderate    | Negative  | Smaller samples at high inflation tiers       |

**Scatter Plot Insights:**

**Panel: Rating vs. Win Rate**
- Observed a pronounced downward trend indicating that as ratings increase, the win rate tends to decrease.
- The linear regression analysis establishes the relationship: Win Rate = 60% - 0.003 × Rating, suggesting that for every unit increase in rating, the win rate decreases by a small but consistent margin.
- The coefficient of determination (R² = 0.71) indicates that 71% of the variance in win rate can be explained by variations in player ratings, signifying a robust predictive relationship.
- **Key Takeaway:** Player rating serves as a strong predictor of win rate direction, highlighting the inverse relationship between skill levels and winning probabilities.

**Panel: Rating vs. Gap**
- The analysis reveals a slight upward trend concerning the gap, suggesting that as ratings rise, the gap may also widen but in a non-linear fashion.
- A closer examination of the data indicates a U-shaped pattern when all tiers are considered, implying that both low-rated (under 1600) and high-rated (2600+) players experience an increasing gap in skills relative to others.
- There are notable outliers at both ends of the rating spectrum, indicating significant disparities in performance at these skill extremes.
- **Key Takeaway:** The gap in performance tends to increase at the extremes of the skill spectrum, suggesting that both novice and elite players may face heightened discrepancies in competitive matchups.

**Panel: Rating vs. Sample Size**
- The relationship depicted here is nearly horizontal, indicating a weak correlation between player rating and the sample size, suggesting that player performance data does not significantly vary across different skill levels.
- High variance in ratings is observed across all participant groups, implying that players of all levels can contribute to a diverse dataset without adhering to a clear pattern.
- **Key Takeaway:** Sample size remains largely independent of skill level, which supports the validity of the study by ensuring a comprehensive representation across the rating spectrum.

**Panel: Win Rate vs. Gap**
- A notable negative association is discerned between the win rate and the gap, illustrating that as the skill gap expands, the win rate diminishes.
- This trend can be explained by understanding that inflated ratings may lead to players facing opponents who are significantly more skilled, thereby lowering their chances of winning.
- **Practical Implication:** Users on Lichess may encounter opponents that are more challenging than their ratings would imply, which could affect their overall experience and competitive outcomes.

**Statistical Tests (from correlation matrix):**
- Statistical analysis shows that all correlations with an absolute value of |r| greater than 0.5 are significant at a p-value of less than 0.01, reinforcing the reliability of the findings.
- The strong negative correlation between rating and win rate aligns well with established ELO theory, confirming that higher ratings do not equate to higher win rates in a competitive context.
- Additionally, a moderate positive correlation between rating and gap suggests a potential systematic bias in how ratings reflect actual competitive capabilities, necessitating further investigation into the rating system's accuracy and fairness.

---

### Section A.7: Analytical Commentary
**Summary of Key Findings:**

#### Finding 1: Systematic Rating Offset  
**Observation:** There exists an average rating gap of +22.7 points when comparing Lichess ratings to FIDE ratings, indicating significant discrepancies between the two platforms.  
**Magnitude:** This gap is not uniform across all player tiers; it ranges from a minimum of +10 points among mid-tier players to a substantial +47 points for beginners.  
**Implication:** Ratings on Lichess are systematically inflated compared to FIDE ratings, leading to potentially misleading interpretations of a player's true skill level in over-the-board (OTB) play.

**Reasons for the Discrepancy:**  
- **Divergent Player Pools:** Lichess attracts a younger and more casual player demographic, many of whom are new to the game, which skews the average ratings upward.
- **Rating Algorithms:** The Glicko-2 rating system used by Lichess is inherently more volatile than the classic Elo system employed by FIDE, resulting in greater fluctuations in player ratings.
- **Game Speed:** The faster pace of competition online generally allows for a higher volume of games played, which may artificially inflate ratings through sheer quantity.
- **Accessibility of Play:** Lichess's open-access platform invites anyone to participate without monthly fees or formal registration, contrasting sharply with FIDE's structured approach requiring identification and financial commitments to compete.

**Practical Applications:**  
- To convert Lichess ratings to FIDE ratings, it is essential to deduct between 10 and 47 points, depending on the player's tier.
- Directly comparing ratings from these two platforms without adjustment leads to misleading assessments.
- Achievements in online arenas may not reliably reflect prospects in OTB events, highlighting the importance of context in rating interpretations.

#### Finding 2: Inverse Rating-Win Rate Relationship  
**Observation:** A strong negative correlation (r = -0.842) is evident between player ratings and win rates, revealing an intriguing pattern: players rated below 1600 have an average win rate of 55.1%, whereas those rated 2600 and above exhibit a significantly lower win rate of only 51.8%.  
**Theoretical Alignment:** This trend supports existing theories of the Elo rating system, which predicts that as player ratings increase, win rates should mathematically converge toward a 50% equilibrium.

**Mechanism Behind the Trend:**  
1. Lower-rated players frequently compete against opponents of varying skill levels, providing more opportunities for victory.
2. Conversely, high-rated players tend to face only elite competitors, elevating the challenge and diminishing their win rates.
3. As ratings climb higher, the quality of opponents increases more rapidly than the players’ ability to maintain win rates, resulting in an asymptotic approach to a 50% win rate at the pinnacle of expertise.

**Validation of the Elo Rating System:**  
This observable trend validates that the ELO system functions effectively by adjusting ratings to equalize expected win probabilities. It also indicates that matchmaking has improved, benefiting from larger player pools, hence reinforcing the concept that a 50% win rate reflects an accurate representation of a player's "true skill level."

#### Finding 3: U-Shaped Gap Distribution  
**Observation:** The rating gap between Lichess and FIDE demonstrates a non-linear distribution across skill tiers, showing a pronounced U-shape with disparities measuring 47, 10, and 37 points, respectively.  
**Implication:** A single conversion formula is inadequate for capturing the complexities of this rating landscape.

**Tier-Specific Analysis:**  
- **Under 1600 (+47 points):** The greatest rating discrepancy is observed here, primarily due to beginners' rapid skill development in an online environment, which outpaces adjustments in official ratings. This group also exhibits high variance as they are in the initial learning phase.
  
- **1600–1999 (+10 points):** This segment provides the closest alignment between platforms with a well-balanced representation of players. These stable intermediate players reflect a more accurate assessment of skills, making it an optimal range for cross-platform analysis.

- **2000–2399 (+17 points):** Players in this tier show a slight advantage on Lichess, likely because many experts are more active in online play. Participation in FIDE events is lower due to associated fees and requirements, resulting in a growing divergence.

- **2400–2599 (+21 points):** The gap is moderate here as master-level players tend to actively engage on both platforms. Aspirations for titles compel FIDE participation, creating a more balanced representation of skills across both platforms.

- **2600+ (+37 points):** This top tier demonstrates renewed divergence; many elite players are specialized online, engaging as content creators or coaches. Participation in FIDE-rated tournaments is more selective, resulting in different player demographics.

#### Finding 4: Activity Level Patterns  
**Observation:** An observable trend indicates that game volume decreases as skill level increases, with average games played dropping from 15 in mid-tier to just 8 in elite tiers.  
**Correlation:** This relationship exhibits a weak negative correlation (r = -0.156).

**Explanations for Decreased Activity:**  
1. **Time Constraints:** Higher-level games require longer durations due to the complexity and depth of calculations involved.
2. **Preparation Demands:** Players at higher levels typically invest significant time in preparation, including opening studies and post-game analysis, limiting their availability for frequent play.
3. **Selective Matchmaking:** Top players are more discerning in choosing their opponents, focusing on competitive quality rather than quantity.
4. **Lifestyle Considerations:** Professional players often juggle rigorous training schedules with competition and necessary rest, impacting their overall game volume.

**Platform Preferences:**  
- In the lower tiers, a preference for Lichess is evident, with 105 players compared to 285 on FIDE.
- Mid-tier players gravitate towards FIDE, with 60 on that platform against 285 on Lichess.
- Elite tiers demonstrate a more balanced participation rate, with 52 on Lichess versus 95 on FIDE.

**Interpretation of Findings:**  
Beginners are drawn to free online platforms due to their accessibility, while players seeking self-improvement often pursue formal OTB competition for enhanced legitimacy in their ratings. Elite players leverage both platforms for various reasons, including income generation and audience engagement.

---
## Data Visualizations Summary

### Chart 1: Rating Comparison Bar Chart
**Type:** Grouped column chart  
**Purpose:** This chart serves as a powerful visual tool, allowing for an immediate and intuitive comparison of average ratings among different categories.  
**Key Insight:** The parallel trajectories observed in the chart confirm that skill measurements remain consistently similar across the various categories represented.  
**Takeaway:** It is important to note that the offsets in ratings are additive rather than multiplicative, suggesting a cumulative effect rather than a compounding one.

### Chart 2: Win Rate Column Chart
**Type:** Single-series bar chart with descriptive labels  
**Purpose:** This visualization effectively conveys the distribution of win rates across various tiers, highlighting the performance of players relative to their ranks.  
**Key Insight:** An intriguing inverse relationship is evident, where an increase in rating corresponds to a decrease in win rate (from 55% to 52%).  
**Takeaway:** This trend indicates that as players achieve higher skill levels, they encounter tougher competition, which challenges their win rates.

### Chart 3: Game Volume Line Plot
**Type:** Line chart enhanced with point markers  
**Purpose:** Designed to illustrate activity levels among different tiers, this chart provides insight into player engagement over time.  
**Key Insight:** A notable 35% decline in activity is observed as players transition from mid-tier to elite-tier levels, revealing a shift in commitment.  
**Takeaway:** This decline suggests that, at higher skill levels, players prioritize the quality of their gameplay over sheer quantity, leading to more focused and strategic participation.

### Chart 4: Rating Gap Bar Chart
**Type:** Column chart featuring a zero reference line  
**Purpose:** This visualization effectively communicates the extent of rating inflation within the system, providing a clear portrayal of disparities.  
**Key Insight:** The resulting distribution appears U-shaped and non-linear, indicating complex dynamics at play.  
**Takeaway:** These findings underscore the necessity for tier-specific adjustments, as uniform measures may not adequately address the unique challenges faced at different levels.

### Chart 5: Correlation Matrix
**Type:** Scatter plot matrix (4×4)  
**Purpose:** This comprehensive exploration delves into all pairwise relationships, offering a robust analysis of interdependencies within the data.  
**Key Insight:** A strong negative correlation between rating and win rate is evident, validating the underlying mechanics of the ELO rating system.  
**Takeaway:** This observation reaffirms that the ELO system is functioning as intended, accurately reflecting the competitive landscape and performance metrics of the players.

---

## Statistical Methods

### Descriptive Statistics
Descriptive statistics provide a basic summary of the data, focusing on key measures:
- **Mean, Median, and Standard Deviation (SD):** These metrics help illustrate the central tendency and the variability of the data set.
- **Counts:** Analyzing the sample size offers insight into the reliability of the data collected.
- **Percentages:** Useful for calculating win rates, percentages give a clearer picture of performance outcomes.

### Correlation Analysis
Correlation analysis is crucial for understanding relationships between variables:
- **Method:** The Pearson correlation coefficient measures the strength and direction of the relationship.
- **Variables of Interest:** This analysis typically involves variables such as rating, win rate, gap, and sample size.
- **Significance Testing:** A p-value of less than 0.01, specifically when the absolute value of the correlation coefficient (|r|) exceeds 0.5, indicates a statistically significant correlation.

### Comparative Analysis
Comparative analysis focuses on examining differences across various groups:
- **Between-group Comparisons:** This involves contrasting data from Lichess with FIDE, especially across different tiers.
- **Within-group Comparisons:** Assessment of rating tiers is conducted within each platform to uncover intragroup dynamics.
- **Difference Metrics:** The absolute gap, calculated as (Lichess - FIDE), provides a straightforward way to quantify performance disparities.

### Visualization Techniques
Effective visualization techniques enhance the understanding of the data:
- **Grouped Bar Charts:** These are ideal for multi-series comparisons, allowing for straightforward visual assessments of differing categories.
- **Scatter Plot Matrices:** These visuals offer a way to examine pairwise relationships among multiple variables.
- **Line Plots:** Line plots are used for visualizing trends over time, providing insights into changes and patterns.
- **Color Coding:** By employing color coding, visualizations can effectively differentiate between platforms, making it easier to interpret the data.

---

## Limitations and Caveats

### Data Limitations
1. **Sample Size Imbalance:** The study includes 527 users from Lichess compared to 950 users from FIDE, which may affect the results.
2. **Temporal Snapshot:** The data represents a single point in time (October 2025), lacking a longitudinal perspective.
3. **Selection Bias:** The sample may overrepresent active users, potentially skewing the findings.
4. **Simulated FIDE Data:** While the FIDE data used is representative, it is not sourced from the actual FIDE database.

### Methodological Limitations
1. **Cross-Sectional Nature:** The study's design prevents any causal inferences.
2. **Aggregated Data:** Individual variations are obscured by averaging at the tier level.
3. **Differences in Platforms:** The time controls on Lichess may not correspond precisely to those used in other platforms.
4. **Rating Systems:** The Glicko-2 system employed on Lichess is not directly comparable to the ELO rating system used by FIDE.

### Interpretive Limitations
1. **Correlation does not imply causation:** The relationships identified are associative rather than causal.
2. **External Validity:** The results are applicable only to the specific sample period examined.
3. **Generalizability Concerns:** Findings may not be relevant to other online chess platforms, such as Chess.com.

---

## Use Cases

### Academic Research
This category encompasses various studies and analyses within the academic realm, including:
- Comparative studies of cross-platform rating systems to understand discrepancies and methodologies.
- Research examining the differences in performance between online and over-the-board chess play.
- An in-depth analysis of rating inflation trends within competitive environments.
- Validation efforts aimed at assessing the effectiveness and accuracy of the Elo rating system.

### Practical Applications
In practical scenarios, several applications can be derived from the research:
- Development of rating conversion calculators, such as transforming Lichess ratings to FIDE ratings, to facilitate standardized comparisons.
- Implementing adjustments for tournament seeding based on player ratings to ensure fair and competitive pairings.
- Assessment tools designed to evaluate skill levels for coaching purposes, aiding trainers in identifying areas for improvement.
- Resources for player self-evaluation, enabling individuals to measure their progress and set personal goals.

### Presentation Materials
To effectively communicate findings and insights derived from research, the following materials can be utilized:
- Summary statistics that can serve as foundational elements for project proposals, enhancing clarity and persuasion.
- Visual aids for presentations at conferences, making complex data more accessible and engaging.
- Infographics designed for public outreach, simplifying information for broader audience comprehension.
- Supplementary materials that enrich academic papers, providing additional context and data to support the main arguments.

---

## Rendering Instructions

### Generate PDF Output
```bash
cd repo-structure/presentation/appendix
Rscript -e "rmarkdown::render('appendix_a.rmd', output_format = 'pdf_document')"
```

### Generate HTML Output
```r
rmarkdown::render("appendix_a.rmd", output_format = "html_document")
```

### Interactive Rendering in RStudio
1. Open `appendix_a.rmd`
2. Click "Knit" button
3. Select output format (PDF/HTML)

---

## Dependencies

### R Packages Required
```r
tidyverse    # Data manipulation and ggplot2
scales       # Percentage formatting
GGally       # Correlation matrix visualization
knitr        # Table generation
```

### Installation
```r
install.packages(c("tidyverse", "scales", "GGally", "knitr"))
```

---

## Related Documents

- **Appendix B:** Longitudinal analysis of rating growth → `README_APPENDIX_B.md`
- **Appendix C:** Nonlinear modeling → `README_APPENDIX_C.md`
- **Appendix D:** Interactive dashboard → `README_APPENDIX_D.md`
- **Data Documentation:** `../../data/README.md`
- **Main README:** `README.md` (appendix directory overview)

---

## Citation

```bibtex
@techreport{huynh2025appendixA,
  author = {Huynh, Tina},
  title = {Appendix A: Summary Analytics -- Lichess vs. FIDE Rating Patterns},
  institution = {Math-225-Fa2025},
  year = {2025},
  type = {Technical Appendix},
  url = {https://github.com/Math-225-Fa2025/project-tmchuynh}
}
```
