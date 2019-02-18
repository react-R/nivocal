#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
nivocal <- function(
  data = NULL,
  from = NULL,
  to = NULL,
  ...,
  width = NULL, height = NULL, elementId = NULL
) {

  # from and to are required
  #  assume first and last are from and to
  if(is.null(from)) from <- data$day[1]
  if(is.null(to)) to <- tail(data,1)$day

  # convert data to array of objects or by row list of lists
  data <- mapply(
    function(day, value) {
      list(day = day, value = value)
    },
    data$day,
    data$value,
    SIMPLIFY = FALSE
  )

  # describe a React component to send to the browser for rendering.
  component <- reactR::reactMarkup(
    htmltools::tag(
      "ResponsiveCalendar",
      list(
        data = data,
        from = from,
        to = to,
        # assume extra arguments are props
        ...
      )
    )
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'nivocal',
    component,
    width = width,
    height = height,
    package = 'nivocal',
    elementId = elementId
  )
}

#' Shiny bindings for nivocal
#'
#' Output and render functions for using nivocal within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a nivocal
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name nivocal-shiny
#'
#' @export
nivocalOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'nivocal', width, height, package = 'nivocal')
}

#' @rdname nivocal-shiny
#' @export
renderNivocal <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, nivocalOutput, env, quoted = TRUE)
}

#' Called by HTMLWidgets to produce the widget's root element.
#' @rdname nivocal-shiny
nivocal_html <- function(id, style, class, ...) {
  htmltools::tagList(
    # Necessary for RStudio viewer version < 1.2
    reactR::html_dependency_corejs(),
    reactR::html_dependency_react(),
    reactR::html_dependency_reacttools(),
    htmltools::tags$div(id = id, class = class, style = style)
  )
}
