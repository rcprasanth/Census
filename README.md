# Census
Exploring acs package in R

# Census data can be accessed from R in 3 simple steps
1.	Choose Geography and level in which data is required. You can choose all states in US or particular states for which data is required. In addition, there are other levels to choose such as counties and zip codes.
2.	Choose the right table. Data is stored by census in the form of tables. For example, population details are stored in table ‘B01003’. Similarly, educational attainment details are stored in ‘S1501’. This step involves a bit of research before downloading the data.
3.	Download data into R.

# Demo
Load acs package - American Community survey
library(acs)

# Step 1 - Choose Geography level. Example - You might want to view census data by state or county or zip code etc. 
geo.make() lets you choose your geography.
Examples for geo.make() are as follows

USState = geo.make(state = '*') # All states in US
CTState = geo.make(state = 'CT') # Connecticut state
CTCounties = geo.make(state = 'CT', county = '*') # Connecticut state, counties
CTPlaces = geo.make(state = 'CT', place = '*') # CT state by places(cities)
CTMACounties = geo.make(state = c('CT','NY'), county = '*') #CT ,NY counties

# Step 2 - Choose the required table
Census has information in tables. You can look up table names from R using acs.lookup(). In this function, provide end year and keyword for your search.

Let's try to study the mode of transport to work across US and few states.

Search = acs.lookup(endyear = 2011, keyword = "transport", case.sensitive = F)

View(Search@results) #To view search results
