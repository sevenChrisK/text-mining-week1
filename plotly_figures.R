library(plotly)

# Load the prepared data with script
source("load_data.R")

# Define custom colors that want to use for differentiating regions on plots
colors <- c('#4AC6B7', '#1972A4', '#965F8A', '#FF7070', '#C61951')
# Define axis options that will use for layout of all axes
axis_layout <- list(range = c(0, 1), tick0=0, dtick=0.1, fixedrange=TRUE, scaleratio = 1)


# Plot all years of EGOV data on a 3d scatter chart using E.Participation, Telecoms Infrastructure and Online Service as axes
fig <- df_egov_all_years %>%
  plot_ly(type = 'scatter3d',
          x = ~E.Participation.Index.x,
          y = ~Telecommunication.Infrastructure.Index.x,
          z = ~Online.Service.Index.x,
          frame = ~Survey.Year.x,
          color = ~Region,
          colors = colors,
          hoverinfo = 'text',
          text = ~paste("Country: ", Country.Name,
                        "<br>E Government Rank: ", E.Government.Index.x,
                        "<br>E Participation Index: ", E.Participation.Index.x,
                        "<br>Telecomms Infrastructure Index: ", Telecommunication.Infrastructure.Index.x,
                        "<br>Online Service Index: ", Online.Service.Index.x)
          ) %>%
  layout(title = list(text = "EGOV 2003-2022: Relationship between E Participation, Online Service, and Telecomms Infrastructure indices",
                      pad = list(b = 50, l = 50, r = 50, t = 200)), 
    scene = list(
    aspectmode='cube',
    xaxis = axis_layout,
    yaxis = axis_layout,
    zaxis = axis_layout
  ))

fig
