# 1. Importing raw data from the World Bank findex database
data_raw<-read_xlsx(here("data", "raw","DataBankWide.xlsx"), sheet="Data")
class(data_raw)
# 2. looking at the raw base
str(data_raw)
colnames(data_raw)
#Keep only basic columns and some indicators useful to assess financial innovation
class (data_raw)
datashort<-data_raw %>% 
  select("Country name",
         "Country code",
         "Year",
         "Region",
         "Income group",
         "Financial institution account (% age 15+)",
         "Mobile money account (% age 15+)",
         "Saved at a financial institution (% age 15+)",
         "Made or received a digital payment (% age 15+)",
         "Borrowed any money from a formal financial institution or using a mobile money account (% age 15+)",
         "Used a mobile phone or the internet to buy something online (% age 15+)",
         "Received private sector wages: into an account (% age 15+)" ,
         "Received government payments: into an account (% age 15+)",
         "Used a mobile phone or the internet to access a financial institution account (% age 15+)",
         "Made or received a digital payment (% age 15+)" ) %>% 
  clean_names()
colnames(datashort) #testing
#The Country name column comprises of groups of countries. Need to keep only individual countries
country_groups<-c("High income", "Low income", "Lower middle income", "Upper middle income",
                  "Middle East & North Africa (excluding high income)", "Sub-Saharan Africa (excluding high income)",
                  "Latin America & Caribbean (excluding high income)", 
                  "Europe & Central Asia (excluding high income)", 
                  "East Asia & Pacific (excluding high income)", "South Asia (excluding high income)",
                  "Sub-Saharan Africa","Middle East & North Africa","Latin America & Caribbean",
                  "Europe & Central Asia","East Asia & Pacific","South Asia",
                  "World", "High income: OECD","Euro area",
                  "Developing","Middle income", "North America","Arab world")
datashort_individual_countries<-datashort %>% 
  filter(!(country_name %in% country_groups))
#check country names (162 individual countries)
unique(datashort_individual_countries$country_name)
#Keeping two indicators only to discuss leapfrogging, and keeping 
#only the latest instances of these available in the same year
leapfrog_data<-datashort_individual_countries %>% 
  select(country_name,
         country_code,
         year,
         income_group,
         region,
         financial_institution_account_percent_age_15,
         mobile_money_account_percent_age_15) %>% #selecting relevant columns
  filter(!is.na(financial_institution_account_percent_age_15) & 
           !is.na(mobile_money_account_percent_age_15)) %>% # keeping only years with data
  group_by(country_name) %>%
  arrange(desc(year)) %>%
  slice(1) %>%#selecting the most recent year where both data are available
  ungroup()

#Plot 1, using the leapfrog_scatter_plot_by_income function (in visualization.R)
plot1<-leapfrog_scatter_plot_by_income(leapfrog_data,"Innovation financière dans les pays émergents")
plot1

#Saving the plot
ggsave(here("output","figures","leapfrog_scatter_plot_by_income.png"),plot1,width=12, height=8, dpi=300)

#Plot2, using the leapfrog_scatter_plot_by_region function (in visualization.R)
plot2<-leapfrog_scatter_plot_by_region(leapfrog_data,"Innovation financière dans les pays émergents")
plot2

#Saving the plot
ggsave(here("output","figures","leapfrog_scatter_plot_by_region.png"), plot2, width=12,height=8,dpi=300)
