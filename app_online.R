# Load necessary library
library(shiny)

# Define the UI for the application
ui <- fluidPage(
  # Add custom CSS to ensure images do not exceed the window size
  tags$style(HTML("
        .responsive-img {
            max-width: 100%;
            max-height: 500px;  /* Restrict maximum height */
            width: auto;
            height: auto;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
    ")),
  
  # Title of the app
  titlePanel("Brazil, States, and Capitals Dashboard"),
  
  # Create a tab layout
  tabsetPanel(
    # First Tab: Trends
    tabPanel("Trends",
             # Two figures vertically with titles
             fluidRow(
               h3("Trends Figure 1 Title"),
               imageOutput("trends_figure1", width = "100%", height = "auto")
             ),
             fluidRow(
               h3("Trends Figure 2 Title"),
               imageOutput("trends_figure2", width = "100%", height = "auto")
             )
    ),
    
    # Second Tab: Brazil
    tabPanel("Brazil",
             # Figures 1 and 2 side by side with a header
             h3("Title for Figures 1 and 2"),
             fluidRow(
               column(6, imageOutput("brazil_figure1", width = "100%", height = "auto")),
               column(6, imageOutput("brazil_figure2", width = "100%", height = "auto"))
             ),
             
             # Figure 3 alone with a header
             h3("Title for Figure 3"),
             fluidRow(
               column(12, imageOutput("brazil_figure3", width = "100%", height = "auto"))
             ),
             
             # Figures 4 and 5 side by side with a header
             h3("Title for Figures 4 and 5"),
             fluidRow(
               column(6, imageOutput("brazil_figure4", width = "100%", height = "auto")),
               column(6, imageOutput("brazil_figure5", width = "100%", height = "auto"))
             ),
             
             # Figure 6 alone at the bottom
             fluidRow(
               h3("Title for Figure 6"),
               column(12, imageOutput("brazil_figure6", width = "100%", height = "auto"))
             )
    ),
    
    # Third Tab: Brazilian States
    tabPanel("States",
             # Dropdown menu for selecting a state
             selectInput("selected_state", "Choose a Brazilian State:",
                         choices = c("AC", "AL", "AP", "AM", "BA", "CE", "DF", 
                                     "ES", "GO", "MA", "MT", "MS", 
                                     "MG", "PA", "PB", "PR", "PE", "PI", "RJ", 
                                     "RN", "RS", "RO", "RR", "SC", 
                                     "SP", "SE", "TO")),
             
             # Empty titles with space for you to add titles later
             fluidRow(
               h3(""),  # Placeholder for title 1
               imageOutput("state_image1", width = "100%", height = "auto")
             ),
             fluidRow(
               h3(""),  # Placeholder for title 2
               imageOutput("state_image2", width = "100%", height = "auto")
             ),
             fluidRow(
               h3(""),  # Placeholder for title 3
               imageOutput("state_image3", width = "100%", height = "auto")
             )
    ),
    
    # Fourth Tab: Brazilian Capitals
    tabPanel("Capitals",
             # Alphabetically ordered dropdown menu for selecting a capital
             selectInput("selected_capital", "Choose a Brazilian Capital:",
                         choices = sort(c("Aracaju", "Belém", "Belo Horizonte", "Boa Vista", "Brasília", "Campo Grande", 
                                          "Cuiabá", "Curitiba", "Florianópolis", "Fortaleza", "Goiânia", "João Pessoa", 
                                          "Macapá", "Maceió", "Manaus", "Natal", "Palmas", "Porto Alegre", 
                                          "Porto Velho", "Recife", "Rio Branco", "Rio de Janeiro", "Salvador", 
                                          "São Luís", "São Paulo", "Teresina", "Vitória"))),
             
             # Display the figures with header titles
             fluidRow(
               h3("Capital Image 1 Title"),
               imageOutput("capital_image1", width = "100%", height = "auto")
             ),
             fluidRow(
               h3("Capital Image 2 Title"),
               imageOutput("capital_image2", width = "100%", height = "auto")
             )
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  ### Tab 1: Trends Figures ###
  output$trends_figure1 <- renderImage({
    list(src = "https://gitlab.fiocruz.br/marcelo.gomes/infogripe/-/raw/master/Boletins%20do%20InfoGripe/Imagens/UF/Mapa_ufs_tendencia.png", contentType = "image/png", class = "responsive-img", alt = "Trends Figure 1")
  }, deleteFile = FALSE)
  
  output$trends_figure2 <- renderImage({
    list(src = "https://gitlab.fiocruz.br/marcelo.gomes/infogripe/-/raw/master/Boletins%20do%20InfoGripe/Imagens/Capitais/Mapa_capitais_tendencia.png", contentType = "image/png", class = "responsive-img", alt = "Trends Figure 2")
  }, deleteFile = FALSE)
  
  ### Tab 2: Brazil Static Figures ###
  output$brazil_figure1 <- renderImage({
    list(src = "https://example.com/fig_BR.png", contentType = "image/png", class = "responsive-img", alt = "Figure 1 for Brazil")
  }, deleteFile = FALSE)
  
  output$brazil_figure2 <- renderImage({
    list(src = "https://example.com/fig_BR_fx_etaria.png", contentType = "image/png", class = "responsive-img", alt = "Figure 2 for Brazil")
  }, deleteFile = FALSE)
  
  output$brazil_figure3 <- renderImage({
    list(src = "https://example.com/fig_BR_inc_mort.png", contentType = "image/png", class = "responsive-img", alt = "Figure 3 for Brazil")
  }, deleteFile = FALSE)
  
  output$brazil_figure4 <- renderImage({
    list(src = "https://example.com/fig_BR_virus_lab_inc.png", contentType = "image/png", class = "responsive-img", alt = "Figure 4 for Brazil")
  }, deleteFile = FALSE)
  
  output$brazil_figure5 <- renderImage({
    list(src = "https://example.com/fig_BR_virus_lab_mort.png", contentType = "image/png", class = "responsive-img", alt = "Figure 5 for Brazil")
  }, deleteFile = FALSE)
  
  output$brazil_figure6 <- renderImage({
    list(src = "https://example.com/fig_BR_virus_lab.png", contentType = "image/png", class = "responsive-img", alt = "Figure 6 for Brazil")
  }, deleteFile = FALSE)
  
  ### Tab 3: Brazilian States ###
  get_image_url <- function(state, image_number) {
    base_url <- "https://gitlab.fiocruz.br/marcelo.gomes/infogripe/-/tree/master/Boletins%20do%20InfoGripe/Imagens/UF/"  # Replace this with your actual base URL
    if (image_number == 1) {
      return(paste0(base_url, "fig_", state, ".png"))
    } else if (image_number == 2) {
      return(paste0(base_url, "fig_", state, "_fx_etaria.png"))
    } else if (image_number == 3) {
      return(paste0(base_url, "fig_", state, "_virus_lab.png"))
    }
  }
  
  output$state_image1 <- renderImage({
    state <- input$selected_state
    list(src = get_image_url(state, 1), contentType = "image/png", class = "responsive-img", alt = paste("State", state, "Image 1"))
  }, deleteFile = FALSE)
  
  output$state_image2 <- renderImage({
    state <- input$selected_state
    list(src = get_image_url(state, 2), contentType = "image/png", class = "responsive-img", alt = paste("State", state, "Image 2"))
  }, deleteFile = FALSE)
  
  output$state_image3 <- renderImage({
    state <- input$selected_state
    list(src = get_image_url(state, 3), contentType = "image/png", class = "responsive-img", alt = paste("State", state, "Image 3"))
  }, deleteFile = FALSE)
  
  ### Tab 4: Brazilian Capitals ###
  get_capital_image_url <- function(capital) {
    state_abbr <- switch(capital,
                         "Rio Branco" = "AC", "Maceió" = "AL", "Macapá" = "AP", "Manaus" = "AM",
                         "Salvador" = "BA", "Fortaleza" = "CE", "Brasília" = "DF", "Vitória" = "ES",
                         "Goiânia" = "GO", "São Luís" = "MA", "Cuiabá" = "MT", "Campo Grande" = "MS",
                         "Belo Horizonte" = "MG", "Belém" = "PA", "João Pessoa" = "PB", "Curitiba" = "PR",
                         "Recife" = "PE", "Teresina" = "PI", "Rio de Janeiro" = "RJ", "Natal" = "RN",
                         "Porto Alegre" = "RS", "Porto Velho" = "RO", "Boa Vista" = "RR", "Florianópolis" = "SC",
                         "São Paulo" = "SP", "Aracaju" = "SE", "Palmas" = "TO")
    
    # Return URLs for capital images
    paste0("https://example.com/fig_", state_abbr, "_", gsub(" ", "_", toupper(capital)))
  }
  
  output$capital_image1 <- renderImage({
    capital <- input$selected_capital
    list(src = paste0(get_capital_image_url(capital), ".png"), contentType = "image/png", class = "responsive-img", alt = paste("Capital", capital, "Image 1"))
  }, deleteFile = FALSE)
  
  output$capital_image2 <- renderImage({
    capital <- input$selected_capital
    list(src = paste0(get_capital_image_url(capital), "_fx_etaria.png"), contentType = "image/png", class = "responsive-img", alt = paste("Capital", capital, "Image 2"))
  }, deleteFile = FALSE)
}

# Run the application
shinyApp(ui = ui, server = server)
