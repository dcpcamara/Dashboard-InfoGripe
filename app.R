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
        .logo-banner {
            max-width: 100px; /* Adjust the size as needed */
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
        .title-panel {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            padding-left: 20px; /* Spacing between logo and title */
            display: inline-block;
        }
        .figure-title {
            text-align: center; Ensure titles are centered */
            margin-left: 15px;  /* Consistent left margin for titles */    
            margin-top: 40px;    /* Add some margin above the titles */
        }
        .figure-space {
            margin-bottom: 60px; /* Add space between figures */
        }
    ")),
  
  # Include the logo and title in the same row
  fluidRow(
    column(1, 
           img(src = "logo.png", class = "logo-banner")),  # Logo in the first column
    column(11, 
           div("Dashboard de resultados do boletim InfoGripe", class = "title-panel"))  # Title in the second column
  ),
  
  # Create a tab layout
  tabsetPanel(
    # First Tab: Trends
    tabPanel("Tendências",
             # Two figures vertically with titles
             h3("Mapa de tendência de SRAG para o curto e longo prazo - Unidades Federativas", 
                class = "figure-title"),
             fluidRow(
               imageOutput("trends_figure1", width = "100%", height = "auto")
             ),
             h3("Mapa de tendência de SRAG para o curto e longo prazo - somente capitais", 
                class = "figure-title"),
             fluidRow(
               imageOutput("trends_figure2", width = "100%", height = "auto")
             )
    ),
    
    # Second Tab: Brazil
    tabPanel("Brasil",
             # Figures 1 and 2 side by side with a header
             h3("Figura 1. Série temporal, estimativa de casos recentes de SRAG e tendências de curto (últimas 3 semanas) e longo prazo (últimas 6 semanas) em todo o território nacional - geral e por faixas etárias de interesse.", 
                class = "figure-title"),
             fluidRow(
               column(6, 
                      imageOutput("brazil_figure1", width = "100%", height = "auto")),
               column(6, 
                      imageOutput("brazil_figure2", width = "100%", height = "auto"))
             ),
             
             # Figure 3 alone with a header
             h3("Figura 2. Incidência e mortalidade nas últimas 8 semanas.", 
                class = "figure-title"),
             fluidRow(
               column(12, 
                      imageOutput("brazil_figure3", width = "100%", height = "auto"))
             ),
             
             # Figures 4 and 5 side by side with a header
             h3("Figura 3. Média da incidência e mortalidade semanal de SRAG nas últimas oito semanas, por vírus e faixa etária de interesse.",
                class = "figure-title"),
             fluidRow(
               column(6, 
                      imageOutput("brazil_figure4", width = "100%", height = "auto")),
               column(6, 
                      imageOutput("brazil_figure5", width = "100%", height = "auto"))
             ),
             
             # Figure 6 alone at the bottom
             h3("Figura 4. Incidência semanal de SRAG e por vírus identificado laboratorialmente, por faixas etárias de interesse.", 
                class = "figure-title"),
             fluidRow(
               column(12, 
                      imageOutput("brazil_figure6", width = "100%", height = "auto"))
             )
    ),
    
    # Third Tab: Brazilian States
    tabPanel("Unidades Federativas",
             # Dropdown menu for selecting a state
             selectInput("selected_state", "Selecione uma Unidade Federativa:",
                         choices = c("AC", "AL", "AP", "AM", "BA", "CE", "DF", 
                                     "ES", "GO", "MA", "MT", "MS", 
                                     "MG", "PA", "PB", "PR", "PE", "PI", "RJ", 
                                     "RN", "RS", "RO", "RR", "SC", 
                                     "SP", "SE", "TO")),
             
             # Empty titles with space for you to add titles later
             h3("Figura 1. Série temporal, estimativa de casos recentes de SRAG e tendências de curto (últimas 3 semanas) e longo prazo (últimas 6 semanas) por Unidade Federativa - geral e por faixas etárias de interesse.",
                class = "figure-title"),
             fluidRow(
               column(6, 
                      imageOutput("state_image1", width = "100%", height = "auto")),
               column(6, 
                      imageOutput("state_image2", width = "100%", height = "auto"))
             ),
             h3("Figura 2. Casos semanais de SRAG e por vírus identificado laboratorialmente, por faixas etárias de interesse.", 
                class = "figure-title"), 
             fluidRow(
               imageOutput("state_image3", width = "100%", height = "auto")
             )
    ),
    
    # Fourth Tab: Brazilian Capitals
    tabPanel("Capitais",
             # Alphabetically ordered dropdown menu for selecting a capital
             selectInput("selected_capital", "Choose a Brazilian Capital:",
                         choices = sort(c("Aracaju", "Belém", "Belo Horizonte", "Boa Vista", "Brasília", "Campo Grande", 
                                          "Cuiabá", "Curitiba", "Florianópolis", "Fortaleza", "Goiânia", "João Pessoa", 
                                          "Macapá", "Maceió", "Manaus", "Natal", "Palmas", "Porto Alegre", 
                                          "Porto Velho", "Recife", "Rio Branco", "Rio de Janeiro", "Salvador", 
                                          "São Luís", "São Paulo", "Teresina", "Vitória"))),
             
             # Display the figures with header titles
             h3("Série temporal, estimativa de casos recentes de SRAG e tendências de curto (últimas 3 semanas) e longo prazo (últimas 6 semanas) por Unidade Federativa - geral e por faixas etárias de interesse.", 
                class = "figure-title"),
             fluidRow(
               column(6, 
                      imageOutput("capital_image1", width = "100%", height = "auto")),
               column(6, 
                      imageOutput("capital_image2", width = "100%", height = "auto"))
             )
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  ### Tab 1: Trends Figures ###
  output$trends_figure1 <- renderImage({
    list(src = "www/Mapa_ufs_tendencia.png", 
         contentType = "image/png", 
         class = "responsive-img", 
         alt = "Trends Figure 1")
  }, deleteFile = FALSE)
  
  output$trends_figure2 <- renderImage({
    list(src = "www/Mapa_capitais_tendencia.png", 
         contentType = "image/png", 
         class = "responsive-img", 
         alt = "Trends Figure 2")
  }, deleteFile = FALSE)
  
  ### Tab 2: Brazil Static Figures
  output$brazil_figure1 <- renderImage({
    list(src = "www/fig_BR.png", 
         contentType = "image/png", 
         class = "responsive-img", 
         alt = "Figure 1 for Brazil")
  }, deleteFile = FALSE)
  
  output$brazil_figure2 <- renderImage({
    list(src = "www/fig_BR_fx_etaria.png", 
         contentType = "image/png", 
         class = "responsive-img", 
         alt = "Figure 2 for Brazil")
  }, deleteFile = FALSE)
  
  output$brazil_figure3 <- renderImage({
    list(src = "www/fig_BR_inc_mort.png", 
         contentType = "image/png", 
         class = "responsive-img", 
         alt = "Figure 3 for Brazil")
  }, deleteFile = FALSE)
  
  output$brazil_figure4 <- renderImage({
    list(src = "www/fig_BR_virus_lab_inc.png", 
         contentType = "image/png", 
         class = "responsive-img", 
         alt = "Figure 4 for Brazil")
  }, deleteFile = FALSE)
  
  output$brazil_figure5 <- renderImage({
    list(src = "www/fig_BR_virus_lab_mort.png", 
         contentType = "image/png", 
         class = "responsive-img", 
         alt = "Figure 5 for Brazil")
  }, deleteFile = FALSE)
  
  output$brazil_figure6 <- renderImage({
    list(src = "www/fig_BR_virus_lab.png", 
         contentType = "image/png", 
         class = "responsive-img", 
         alt = "Figure 6 for Brazil")
  }, deleteFile = FALSE)
  
  ### Tab 3: Brazilian States
  get_image_path <- function(state, image_number) {
    if (image_number == 1) {
      return(paste0("www/fig_", state, ".png"))
    } else if (image_number == 2) {
      return(paste0("www/fig_", state, "_fx_etaria.png"))
    } else if (image_number == 3) {
      return(paste0("www/fig_", state, "_virus_lab.png"))
    }
  }
  
  output$state_image1 <- renderImage({
    state <- input$selected_state
    list(src = get_image_path(state, 1), 
         contentType = "image/png", 
         class = "responsive-img", 
         alt = paste("UF", state, "Image 1"))
  }, deleteFile = FALSE)
  
  output$state_image2 <- renderImage({
    state <- input$selected_state
    list(src = get_image_path(state, 2), 
         contentType = "image/png", 
         class = "responsive-img", 
         alt = paste("UF", state, "Image 2"))
  }, deleteFile = FALSE)
  
  output$state_image3 <- renderImage({
    state <- input$selected_state
    list(src = get_image_path(state, 3), 
         contentType = "image/png", 
         class = "responsive-img", 
         alt = paste("UF", state, "Image 3"))
  }, deleteFile = FALSE)
  
  ### Tab 4: Brazilian Capitals
  get_capital_image_path <- function(capital) {
    state_abbr <- switch(
      capital,
      "Rio Branco" = "AC", "Maceió" = "AL", "Macapá" = "AP", "Manaus" = "AM",
      "Salvador" = "BA", "Fortaleza" = "CE", "Brasília" = "DF", "Vitória" = "ES",
      "Goiânia" = "GO", "São Luís" = "MA", "Cuiabá" = "MT", "Campo Grande" = "MS",
      "Belo Horizonte" = "MG", "Belém" = "PA", "João Pessoa" = "PB", "Curitiba" = "PR",
      "Recife" = "PE", "Teresina" = "PI", "Rio de Janeiro" = "RJ", "Natal" = "RN",
      "Porto Alegre" = "RS", "Porto Velho" = "RO", "Boa Vista" = "RR", "Florianópolis" = "SC",
      "São Paulo" = "SP", "Aracaju" = "SE", "Palmas" = "TO"
    )
    
    # Return paths for capital images
    paste0("www/fig_", state_abbr, "_", gsub(" ", "_", toupper(capital)))
  }
  
  output$capital_image1 <- renderImage({
    capital <- input$selected_capital
    list(src = paste0(get_capital_image_path(capital), ".png"), 
         contentType = "image/png", 
         class = "responsive-img", 
         alt = paste("Capital", capital, "Image 1"))
  }, deleteFile = FALSE)
  
  output$capital_image2 <- renderImage({
    capital <- input$selected_capital
    list(src = paste0(get_capital_image_path(capital), "_fx_etaria.png"), 
         contentType = "image/png", 
         class = "responsive-img", 
         alt = paste("Capital", capital, "Image 2"))
  }, deleteFile = FALSE)
}

# Run the application
shinyApp(ui = ui, server = server)
