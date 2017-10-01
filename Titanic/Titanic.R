# titanic is avaliable in your workspace
# 1 - Check the structure of titanic
str(titanic)

# 2 - Use ggplot() for the first instruction
# Plots a bargraph showing the Pclass on the x axis and the number of Pclass on the y axis Bars are filled in with the gender of these individuals.
# Dodge is used to split the sexes into two bars, as opposed to a stacked bar.
ggplot(titanic, aes(x = Pclass, fill = Sex)) + 
  geom_bar(position = "dodge")

# 3 - Plot 2, add facet_grid() layer
# Simliar to above, however two graphs are made. The first graph shows those who have perished and the second graph shows survivors.
ggplot(titanic, aes(x = Pclass, fill = Sex)) + 
  geom_bar(position = "dodge") +
  facet_grid(.~ Survived)

# 4 - Define an object for position jitterdodge, to use below
posn.jd <- position_jitterdodge(0.5, 0, 0.6)

# 5 - Plot 3, but use the position object from instruction 4
# Plots all survivors as a dot with the x-axis showing their P Class, the y-axis showing their age, and the fill color showing their gender. 
# Size of the dots were enlarged with size and made slightly transparent with alpha.
ggplot(titanic, aes(x = Pclass, y= Age, color = Sex)) + 
  geom_point(size = 3, alpha = 0.5, position = posn.jd) +
  facet_grid(.~ Survived)

