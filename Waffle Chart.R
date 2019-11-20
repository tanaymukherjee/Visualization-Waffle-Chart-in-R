# Tanay Mukherjee
# 20 Nov. 2019

# install waffle package
# install.packages("waffle") 
library(waffle)

# Trying it with the inbuilt iris package
(spec <- table(iris$Species))
waffle(spec)

# Defining the rows for waffles and other aesthetics
waffle(spec, rows = 3, legend_pos = "bottom")
waffle(spec, rows = 15, colors = c("lightgrey", "darkgrey", "red"))
waffle(spec, rows = 5, colors = c("lightgrey", "darkgrey", "red"))

# W can annotate what each square represents:
w1 <- waffle(spec / 10, rows = 5, xlab = "1 square = 10 flowers")
w1

# Combining waffle chart using iron function
# Iron 
iron(
  waffle(spec / 5, rows = 5, title = "iron() combines waffles"),
  w1
)

iron(
  waffle(spec, rows = 15, colors = c("lightgrey", "darkgrey", "red")),
  waffle(spec, rows = 5, colors = c("lightgrey", "darkgrey", "red"))
  
)



# More cutomisation on waffle chart

# install some customised package
install.packages("waffle", repos = "https://cinc.rud.is")
devtools::install_git("https://git.rud.is/hrbrmstr/waffle.git")
devtools::install_git("https://git.sr.ht/~hrbrmstr/waffle")
devtools::install_gitlab("hrbrmstr/waffle")
devtools::install_bitbucket("hrbrmstr/waffle")
devtools::install_github("hrbrmstr/waffle")

library(waffle)
library(magrittr)
library(hrbrthemes)
library(ggplot2)
library(dplyr)
library(waffle)

xdf <- data.frame(parts = factor(rep(month.abb[1:3], 3), levels=month.abb[1:3]),
  vals = c(10, 20, 30, 6, 14, 40, 30, 20, 10),
  col = rep(c("blue", "black", "red"), 3),
  fct = c(rep("Thing 1", 3), rep("Thing 2", 3),rep("Thing 3", 3)))

xdf %>%
  count(parts, wt = vals) %>%
  ggplot(aes(fill = parts, values = n)) +
  geom_waffle(n_rows = 20, size = 0.33, colour = "white", flip = TRUE) +
  scale_fill_manual(
    name = NULL,
    values = c("#a40000", "#c68958", "#ae6056"),
    labels = c("Fruit", "Sammich", "Pizza")
  ) +
  coord_equal() +
  theme_ipsum_rc(grid="") +
  theme_enhance_waffle()

# The following codes will work only when you have the pictograms installed on your system
# xdf %>%
#   count(parts, wt = vals) %>%
#   ggplot(aes(label = parts, values = n)) +
#   geom_pictogram(n_rows = 10, aes(colour = parts), flip = TRUE, make_proportional = TRUE) +
#   scale_color_manual(
#     name = NULL,
#     values = c("#a40000", "#c68958", "#ae6056"),
#     labels = c("Fruit", "Sammich", "Pizza")
#   ) +
#   scale_label_pictogram(
#     name = NULL,
#     values = c("apple-alt", "bread-slice", "pizza-slice"),
#     labels = c("Fruit", "Sammich", "Pizza")
#   ) +
#   coord_equal() +
#   theme_ipsum_rc(grid="") +
#   theme_enhance_waffle() +
#   theme(legend.key.height = unit(2.25, "line")) +
#   theme(legend.text = element_text(size = 10, hjust = 0, vjust = 0.75))
# 
# xdf %>%
#   count(parts, wt = vals) %>%
#   ggplot(aes(label = parts, values = n)) +
#   geom_pictogram(
#     n_rows = 20, size = 6, aes(colour = parts), flip = TRUE,
#     family = "FontAwesome5Brands-Regular"
#   ) +
#   scale_color_manual(
#     name = NULL,
#     values = c("#073f9c", "black", "#f34323"),
#     labels = c("BitBucket", "GitHub", "Other")
#   ) +
#   scale_label_pictogram(
#     name = NULL,
#     values = c("bitbucket", "github", "git-alt"),
#     labels = c("BitBucket", "GitHub", "Other")
#   ) +
#   coord_equal() +
#   theme_ipsum_rc(grid="") +
#   theme_enhance_waffle() +
#   theme(legend.text = element_text(hjust = 0, vjust = 1))


# Customised Waffles chart
# Waffles with bar chart
storms %>% 
  filter(year >= 2010) %>% 
  count(year, status) -> storms_df

ggplot(storms_df, aes(fill = status, values = n)) +
  geom_waffle(color = "white", size = .25, n_rows = 10, flip = TRUE) +
  facet_wrap(~year, nrow = 1, strip.position = "bottom") +
  scale_x_discrete() + 
  scale_y_continuous(labels = function(x) x * 10, # make this multiplyer the same as n_rows
                     expand = c(0,0)) +
  ggthemes::scale_fill_tableau(name=NULL) +
  coord_equal() +
  labs(
    title = "Faceted Waffle Bar Chart",
    subtitle = "{dplyr} storms data",
    x = "Year",
    y = "Count"
  ) +
  theme_minimal(base_family = "Roboto Condensed") +
  theme(panel.grid = element_blank(), axis.ticks.y = element_line()) +
  guides(fill = guide_legend(reverse = TRUE))

