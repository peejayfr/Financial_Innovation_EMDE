# Function for plot1 (illustrating some aspects of leapfrogging) plot by income group

leapfrog_scatter_plot_by_income<-function(data, title) {
  # Define shape mappings
    income_shapes <- c(
    "High income" = 16,          # Cercle plein
    "Upper middle income" = 17,  # Triangle plein
    "Lower middle income" = 15,  # Carré plein
    "Low income" = 18,           # Losange plein
    "NA" = 4                     # Croix (pour le Venezuela)
  )
  
  income_labels_fr <- c(
    "High income" = "Revenu élevé",
    "Upper middle income" = "Revenu intermédiaire supérieur",
    "Lower middle income" = "Revenu intermédiaire inférieur",
    "Low income" = "Faible revenu",
    "NA" = "Non classé"
  )
  #Calculate median year
  median_year<-median(data$year)
  
  #calculate year distribution table
  year_distribution<-data %>% 
    count(year) %>% 
    arrange(year)
  
  #Create the plot
  plot<-ggplot(data, aes(x = financial_institution_account_percent_age_15, 
                   y = mobile_money_account_percent_age_15,
                   shape = income_group)) +
    geom_point(size = 3, alpha = 0.7) +
    geom_text_repel(aes(label = country_code),
                    size=2.5,
                    box.padding=0.3,
                    point.padding=0.2,
                    force=1,
                    max.overlaps=Inf
                    )+
    scale_shape_manual(values=income_shapes,labels=income_labels_fr)+
    scale_x_continuous(labels = scales::percent_format(scale = 100), 
                       limits = c(0, 1)) +
    scale_y_continuous(labels = scales::percent_format(scale = 100), 
                       limits = c(0, max(data$mobile_money_account_percent_age_15, na.rm = TRUE))) +
    labs(title = title,
         subtitle = paste("Saut technologique dans les services financiers\nDonnées de", min(data$year), "à", max(data$year), "(médiane:", median_year, ")"),
         x = "Population adulte détenant un compte bancaire (%)",
         x = "Population adulte détenant un compte bancaire (%)",
         y = "Population adulte détenant un compte mobile (%)",
         shape = "Groupe de revenu",
         caption = "Source : Banque mondiale, banque de données Findex, consultée en septembre 2024.") +
    theme_minimal() +
    theme(
      plot.background = element_rect(fill = "white", color = NA),
      panel.background = element_rect(fill = "white", color = NA),
      legend.position = "bottom",
      legend.background = element_rect(fill = "white", color = NA),
      plot.title = element_text(size = 16, face = "bold"),
      plot.subtitle = element_text(size = 12),
      axis.title = element_text(size = 12),
      axis.text = element_text(size = 10),
      legend.title = element_text(size = 10),
      legend.text = element_text(size = 9)
    )

#Print year distribution
  cat("Distribution des années dans le jeu de données:\n")
  print(kable(year_distribution))

#Generate table of countries with data before 2021
  countries_before_2021<-data %>% 
    filter(year<2021) %>% 
    select(country_name,country_code, year) %>% 
    arrange(year)
  # Print the table
  cat("Pays avec des données antérieures à 2021:\n")
  print(kable(countries_before_2021))
  
  #return the plot
  return(plot)
}


#2. Function for plot 2, by regions (scatter-plot illustrating leapfrogging)

leapfrog_scatter_plot_by_region <- function(data, title) {
  # Define French labels and shape mappings for regions
  region_shapes <- c(
    "South Asia" = 16,                    # Cercle plein
    "Europe & Central Asia" = 17,         # Triangle plein
    "Latin America & Caribbean" = 15,     # Carré plein
    "Sub-Saharan Africa" = 18,            # Losange plein
    "East Asia & Pacific" = 25,           # Triangle inversé plein
    "High income" = 23,                   # Losange horizontal
    "Middle East & North Africa" = 24     # Triangle pointant vers la gauche
  )
  
  region_labels_fr <- c(
    "South Asia" = "Asie du Sud",
    "Europe & Central Asia" = "Europe et Asie centrale",
    "Latin America & Caribbean" = "Amérique latine et Caraïbes",
    "Sub-Saharan Africa" = "Afrique subsaharienne",
    "East Asia & Pacific" = "Asie de l'Est et Pacifique",
    "High income" = "Revenu élevé",
    "Middle East & North Africa" = "Moyen-Orient et Afrique du Nord"
  )
  
  # Simplify region names in the data
  data$region_simplified <- gsub(" \\(excluding high income\\)", "", data$region)
  
  # Calculate median year
  median_year <- median(data$year)
  
  # Calculate year distribution table
  year_distribution <- data %>% 
    count(year) %>% 
    arrange(year)
  
  # Create the plot
  plot <- ggplot(data, aes(x = financial_institution_account_percent_age_15, 
                           y = mobile_money_account_percent_age_15,
                           shape = region_simplified)) +
    geom_point(size = 3, fill = "black") +
    geom_text_repel(aes(label = country_code),
                    size = 2.5,
                    box.padding = 0.3,
                    point.padding = 0.2,
                    force = 1,
                    max.overlaps = Inf
    ) +
    scale_shape_manual(values = region_shapes, labels = region_labels_fr) +
    scale_x_continuous(labels = scales::percent_format(scale = 100), 
                       limits = c(0, 1)) +
    scale_y_continuous(labels = scales::percent_format(scale = 100), 
                       limits = c(0, max(data$mobile_money_account_percent_age_15, na.rm = TRUE))) +
    labs(title = title,
         subtitle = paste("Saut technologique dans les services financiers\nDonnées de", min(data$year), "à", max(data$year), "(médiane:", median_year, ")"),
         x = "Population adulte détenant un compte bancaire (%)",
         y = "Population adulte détenant un compte mobile (%)",
         shape = "Région",
         caption = "Source : Banque mondiale, banque de données Findex, consultée en septembre 2024.\nLa classification régionale ne porte que sur les pays en développement.") +
    theme_minimal() +
    theme(
      plot.background = element_rect(fill = "white", color = NA),
      panel.background = element_rect(fill = "white", color = NA),
      legend.position = "bottom",
      legend.background = element_rect(fill = "white", color = NA),
      plot.title = element_text(size = 16, face = "bold"),
      plot.subtitle = element_text(size = 12),
      axis.title = element_text(size = 12),
      axis.text = element_text(size = 10),
      legend.title = element_text(size = 10),
      legend.text = element_text(size = 9),
      plot.caption = element_text(size = 8, hjust = 0)
    )
  
  # Print year distribution
  cat("Distribution des années dans le jeu de données:\n")
  print(kable(year_distribution))
  
  # Generate table of countries with data before 2021
  countries_before_2021 <- data %>% 
    filter(year < 2021) %>% 
    select(country_name, country_code, year) %>% 
    arrange(year)
  
  # Print the table
  cat("Pays avec des données antérieures à 2021:\n")
  print(kable(countries_before_2021))
  
  # Return the plot
  return(plot)
}
