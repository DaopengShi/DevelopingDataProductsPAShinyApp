library(shiny)

shinyUI(
  fluidPage(
    titlePanel("Brief information of 50 states of the USA"),
  
    sidebarLayout(
      sidebarPanel(
        selectInput("statename",
                    label = "choose a state:",
                    choices = c(Choose='', state.name),
                    selectize = TRUE),
        helpText("You can choose a USA state or leave the above select box blank
                 . When you choose one state, the location of the chosen state
                 will be highlighted on the USA map."),
        br(),
        checkboxInput("showdetail",
                      label = "show detail of state(s)",
                      value = TRUE),
        helpText("When the check box is checked, the datail of the state(s) and the 
                 instruction of detail columns will be showed."),
        conditionalPanel(
          "input.showdetail",
          h5('The detail of state include following column:'),
          p('Statename: name of state.'),
          p('Population: population estimate as of July 1, 1975.'),
          p('Income: per capita income (1974).'),
          p('Illiteracy: illiteracy (1970, percent of population).'),
          p('Life Exp: life expectancy in years (1969–71).'),
          p('Murder: murder and non-negligent manslaughter rate per 100,000 
            population (1976).'),
          p('HS Grad: percent high-school graduates (1970).'),
          p('Frost: mean number of days with minimum temperature below freezing
            (1931–1960) in capital or large city.'),
          p('Area: land area in square miles.')
        )
      ),
      mainPanel(
        uiOutput("uimaptitle"),
        plotOutput("map"),
        conditionalPanel(
          "input.showdetail",
          uiOutput("uidetailtitle"),
          dataTableOutput(outputId = "table")
        )
      )
    )
  )
)
