# titanic is avaliable in your workspace
# 1 - Check the structure of titanic
str(titanic)

# 2 - Use ggplot() for the first instruction
<<<<<<< HEAD
ggplot(titanic, aes(x =  factor(Pclass), fill = factor(Sex))) +
  geom_bar(position = "dodge")

# 3 - Plot 2, add facet_grid() layer
ggplot(titanic, aes(x =  factor(Pclass), fill = factor(Sex))) +
=======
ggplot(titanic, aes(x = Pclass, fill = Sex)) +
  geom_bar(position = "dodge")

# 3 - Plot 2, add facet_grid() layer
ggplot(titanic, aes(x = Pclass, fill = Sex)) +
>>>>>>> f4b4994606b41848e6b12a3c79553936dd63163b
  geom_bar(position = "dodge") +
  facet_grid( . ~ Survived)

# 4 - Define an object for position jitterdodge, to use below
posn.jd <- position_jitterdodge(0.5, 0, 0.6)

# 5 - Plot 3, but use the position object from instruction 4
<<<<<<< HEAD
ggplot(titanic, aes(x =  factor(Pclass), y =Age, col = factor(Sex))) +
=======
ggplot(titanic, aes(x = Pclass, y =Age, col = Sex)) +
>>>>>>> f4b4994606b41848e6b12a3c79553936dd63163b
  geom_point(size = 3, alpha=0.5,position = posn.jd ) +
  facet_grid( . ~ Survived)

