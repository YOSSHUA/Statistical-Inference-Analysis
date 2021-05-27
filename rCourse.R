library(gapminder)
library(dplyr)
library(ggplot2)
# gapminder es un conjunto de datos


#pipelines
#verbos ------------------------------------

#Filter
gapminder %>%
  filter(year==2007)

#Funciona como and
gapminder %>%
  filter(country=="United States", year==2007)

#arrange
gapminder %>%
  arrange(gdpPercap) #arrange(desc(gdpPercap)) en desc

#ambos
gapminder %>%
  filter(year==2007) %>%
  arrange(desc(gdpPercap))

#con mutate
gapminder %>%
  filter(year==2007) %>%
  arrange(desc(gdpPercap))%>%
  mutate(gdp = gdpPercap*pop)

#ggplot--------------------------------

gapminder_2007 <- gapminder %>%
    filter(year==2007)


#ggplot( datos,  aes(x = datosX, y = datosY ))
#  + tipoGrafica

# geom_point() - scatter plot, cada punto es una observación
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()

#Escala log10
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point() +
  scale_x_log10()

#Con colores según cierta característica el punto es de
# diferente color.
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent)) + 
  geom_point() +
  scale_x_log10()

#Por tamaños de los puntos según ciertas características
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, 
                           color = continent, size = pop)) + 
  geom_point() +
  scale_x_log10()


#Diferentes gráficas según cada valor de una columna
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point() +
  scale_x_log10() +
  facet_wrap(~ continent)



# Summarize (mean, sum, median, min, max)-----------
#Promedio life expectancy por año
#Promedio por año 
gapminder %>% 
  filter(year == 2007) %>%
  summarize(meanLifeExp = mean(lifeExp), totalPop = sum(pop))

#Group by
gapminder %>% 
  group_by(year,continent) %>%
  summarize(meanLifeExp = mean(lifeExp), totalPop = sum(pop))

# Plot group by's
#Suma pop por año y promedio de vida
by_year <- gapminder %>%
  group_by(year, continent) %>%
  summarize(totalPop = sum(pop), meanLifeExp = mean(lifeExp))


ggplot(by_year, aes(x = year, y=totalPop, color = continent)) +
  geom_point() +
  expand_limits(y=0) # En qué valor empieza

# Gráfica de lineas
ggplot(by_year, aes(x = year, y=totalPop, color = continent)) +
  geom_line() +
  expand_limits(y=0) # En qué valor empieza


#Gráfica de barras
by_cont <- gapminder %>%
  group_by(continent) %>%
  summarize(meanLifeExp = mean(lifeExp))

ggplot(by_cont, aes(x=continent, y = meanLifeExp)) + geom_col()

# Histograma
ggplot(gapminder_2007,aes(x=lifeExp))+geom_histogram(binwidth = 5)

#Box plot
ggplot(gapminder_2007, aes(x=continent, y = lifeExp)) + geom_boxplot()+ ggtitle('Comparando Esperanza de vida por continenete de 2007')
