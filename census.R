# Load acs - American Community survey
library(acs)
library(dplyr)


# Step 1 - Choose Geography level. Example - You might want to view census data by state or county or zip code etc.
# For this example, let's choose state level. '*' denotes all states
USState = geo.make(state = '*') # In this step I'm choosing state level
CTState = geo.make(state = 'CT') # Choose CT state
CTCounties = geo.make(state = 'CT', county = '*') # CT state, county level
CTPlaces = geo.make(state = 'CT', place = '*') # CT state, place(city) level
CTNYCounties = geo.make(state = c('CT','NY'), county = '*') # CT and NY states, county leve
USZip = geo.make(zip.code = '*') # Zip code level

# Step 2 - Choose the required table
# ACS has information in tables. For example, income details have a table. Population details have a table.
# Let's choose the right table to find means of transport
Search = acs.lookup(endyear = 2011, keyword = "transport", case.sensitive = F)
View(Search@results)

# B08006 seems to be the right table. Let's download 

USStateLvl = acs.fetch(endyear = 2011, table.number = 'B08006', geography = USState, col.names = 'pretty')
CTLvl = acs.fetch(endyear = 2011, table.number = 'B08006', geography = CTState, col.names = 'pretty')
CTCountiesLvl = acs.fetch(endyear = 2011, table.number = 'B08006', geography = CTCounties, col.names = 'pretty')
CTNYCountiesLvl = acs.fetch(endyear = 2011, table.number = 'B08006', geography = CTNYCounties, col.names = 'pretty')
CTPlacesLvl = acs.fetch(endyear = 2011, table.number = 'B08006', geography = CTPlaces, col.names = 'pretty')
USZipLvl = acs.fetch(endyear = 2011, table.number = 'B08006', geography = USZip, col.names = 'pretty')


#View data 
View(USStateLvl@estimate)
View(CTLvl@estimate)
View(CTCountiesLvl@estimate)
View(CTNYCountiesLvl@estimate)
View(CTPlacesLvl@estimate)
View(USZipLvl@estimate)

# Store results in data frame
PublicTransport = data.frame(USStateLvl@estimate)
PublicTransport = add_rownames(PublicTransport, "region")

# Visualize data
library(ggplot2)
library(maps)

states <- map_data("state")
map.df <- merge(states,PublicTransport, by="region", all.x=T)
map.df <- map.df[order(map.df$order),]
plotit = ggplot(map.df, aes(x=long,y=lat,group=group))+geom_polygon(aes(fill=Household_Income)) + geom_path() +  scale_fill_gradientn(colours=rev(heat.colors(10)),na.value="grey90")+  coord_map()+labs(title="Median Household income", x = "Longitude", y = "Latitude") + theme(plot.title = element_text(size=25)) 
plotit

##########################################################################################
# How about household income by zip code?
# Make a simple change
USZip = geo.make(zip.code = '*')

# Download the same table by zip code
HouseholdIncomebyZip = acs.fetch(endyear = 2011, table.number = 'B19013', geography = USZip, col.names = 'pretty')

HHZip = data.frame(HouseholdIncomebyZip@estimate)
HHZip = add_rownames(HHZip, "zip")
HHZip$zip = substr(HHZip$zip, start = 7, stop = 12)
HHZip$Household_Income = HHZip$Median.Household.Income..Median.household.income.in.the.past.12.months..in.2011.inflation.adjusted.dollars.


library(zipcode)
data(zipcode)
zipmap.df <- merge(zipcode,HHZip, by="zip", all.x=T)

zipmap.df <- na.omit(zipmap.df)

plotit = ggplot(zipmap.df, aes(x=longitude,y=latitude,group=zip))
plotit + geom_polygon(aes(fill=Household_Income)) + geom_path() + theme(plot.title = element_text(size=22))
plotit

scale_fill_gradientn(colours=rev(heat.colors(10)),na.value="grey90")+  coord_map()+labs(title="Median Household income", x = "Longitude", y = "Latitude")
plotit



######################################################################
Search = acs.lookup(endyear = 2011, keyword = "transport", case.sensitive = F)
View(Search@results)

Indian = acs.fetch(endyear = 2011, table.number = 'B02006', geography = USZip, col.names = 'pretty')

B08006
XX = acs.fetch(endyear = 2011, table.number = 'B08006', geography = USState, col.names = 'pretty')
View(XX@estimate)

Indianss = data.frame(Indian@estimate)


http://zevross.com/blog/2015/10/14/manipulating-and-mapping-us-census-data-in-r-using-the-acs-tigris-and-leaflet-packages-3/






acs.lookup(endyear = 2011, table.number = 'B08006')




















Income.df$region = tolower(Income.df$State)

Income.df$Household_Income = Income.df$Median.Household.Income..Median.household.income.in.the.past.12.months..in.2011.inflation.adjusted.dollars.
Income.df$Median.Household.Income..Median.household.income.in.the.past.12.months..in.2011.inflation.adjusted.dollars. = NULL







