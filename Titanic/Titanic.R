# titanic is avaliable in your workspace
# 1 - Check the structure of titanic
str(titanic)

# 2 - Use ggplot() for the first instruction
# Plots a bar graph with the Pclass on the x axis and the count of individuals on the y. The fill color is determined by the gender (sex).
# Position dodge is used to separate the sexes into two bars as opposed to a stacked bar.
ggplot(titanic, aes(x = Pclass, fill = Sex)) + 
  geom_bar(position = "dodge")

# 3 - Plot 2, add facet_grid() layer
# Facet_grid separates the survivors (1) from the victims (0). Bar is constructed the same as above.
ggplot(titanic, aes(x = Pclass, fill = Sex)) + 
  geom_bar(position = "dodge") +
  facet_grid(.~ Survived)

# 4 - Define an object for position jitterdodge, to use below
posn.jd <- position_jitterdodge(0.5, 0, 0.6)

# 5 - Plot 3, but use the position object from instruction 4
# Plots points of individuals. X represents the Pclass and the y axis represents the age. Color represents the sex. Two graphs are created for survivors and victims. 
# Size changes the size of the dots and alpha makes the dots transparent.
ggplot(titanic, aes(x = Pclass, y= Age, color = Sex)) + 
  geom_point(size = 3, alpha = 0.5, position = posn.jd) +
  facet_grid(.~ Survived)

