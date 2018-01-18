library(shiny)
library(tidyverse)
#install.packages("d3heatmap", "heatmaply")
#devtools::install_github('neuhausi/canvasXpress')
library(d3heatmap)
library(heatmaply)
library(canvasXpress)

test_matrix <- matrix(
    rpois(10000, 5), 
    nrow = 100, 
    dimnames = list(
        str_c("sample", as.character(1:100)),
        str_c("gene", as.character(1:100))
    ))

# test_df <- test_matrix %>% 
#     data.frame %>% 
#     rownames_to_column("sample") %>% 
#     as_data_frame

ui <- basicPage(
    tabsetPanel(
        tabPanel("d3heatmap",    d3heatmapOutput("d3heatmap")),
        tabPanel("heatmaply",    plotlyOutput("heatmaply")),
        tabPanel("plotly",       plotlyOutput("plotly")),
        tabPanel("canvasXpress", canvasXpressOutput("canvasXpress"))
        ))


server <- function(input, output) {
    
    output$d3heatmap    <- renderD3heatmap(d3heatmap(test_matrix))
    output$heatmaply    <- renderPlotly(heatmaply(test_matrix))
    output$plotly       <- renderPlotly(plot_ly(z = test_matrix, type = "heatmap", showscale = TRUE))
    output$canvasXpress <- renderCanvasXpress(canvasXpress(test_matrix, graphType = "Heatmap"))
}

shinyApp(ui = ui, server = server)

