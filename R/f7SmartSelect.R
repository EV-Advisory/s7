#'
#' f7SmartSelect updated from shinyMobile error in NS
#'
#' @inheritParams shinyMobile::f7SmartSelect
#' @rdname f7SmartSelect
#' @importFrom shiny tags
#' @importFrom jsonlite toJSON
#'
#' @seealso \link{f7SmartSelect}
#' @export
#'

f7SmartSelect <- function (inputId,
                           label,
                           choices,
                           selected = NULL,
                           openIn = c("page",
                                      "sheet", "popup", "popover"),
                           searchbar = TRUE,
                           multiple = FALSE,
                           maxlength = NULL,
                           virtualList = FALSE,
                           ...)
{
  options <- createSelectOptions(choices, selected)
  type <- match.arg(openIn)
  config <- dropNulls(
    list(
      openIn = openIn,
      searchbar = searchbar,
      searchbarPlaceholder = "Search",
      virtualList = virtualList,
      ...
    )
  )
  shiny::tags$div(class = "list", shiny::tags$ul(shiny::tags$li(
    shiny::tags$a(
      class = "item-link smart-select",
      shiny::tags$select(
        id = inputId,
        multiple = if (multiple)
          NA
        else
          NULL,
        maxlength = if (!is.null(maxlength))
          maxlength
        else
          NULL,
        options
      ),
      shiny::tags$div(
        class = "item-content",
        shiny::tags$div(class = "item-inner", shiny::tags$div(class = "item-title",
                                                              label))
      ),
      shiny::tags$script(
        type = "application/json",
        `data-for` = inputId,
        toJSON(
          x = config,
          auto_unbox = TRUE,
          json_verbatim = TRUE
        )
      )
    )
  )))
}


createSelectOptions <- function (choices, selected)
{
  choices <- choicesWithNames(choices)
  options <- lapply(X = seq_along(choices), function(i) {
    if (inherits(choices[[1]], "list")) {
      shiny::tags$optgroup(label = names(choices)[i], lapply(X = seq_along(choices[[i]]),
                                                             function(j) {
                                                               shiny::tags$option(value = choices[[i]][[j]],
                                                                                  names(choices[[i]])[j],
                                                                                  selected = if (!is.null(selected)) {
                                                                                    if (choices[[i]][[j]] %in% selected)
                                                                                      NA
                                                                                    else
                                                                                      NULL
                                                                                  })
                                                             }))
    }
    else {
      shiny::tags$option(value = choices[[i]],
                         names(choices)[i],
                         selected = if (!is.null(selected)) {
                           if (choices[[i]] %in% selected)
                             NA
                           else
                             NULL
                         })
    }
  })
  return(options)
}

dropNulls <- function(x)
{
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}

choicesWithNames<-function (choices)
{
  listify <- function(obj) {
    makeNamed <- function(x) {
      if (is.null(names(x)))
        names(x) <- character(length(x))
      x
    }
    res <- lapply(obj, function(val) {
      if (is.list(val))
        listify(val)
      else if (length(val) == 1 && is.null(names(val)))
        val
      else makeNamed(as.list(val))
    })
    makeNamed(res)
  }
  choices <- listify(choices)
  if (length(choices) == 0)
    return(choices)
  choices <- mapply(choices, names(choices), FUN = function(choice,
                                                            name) {
    if (!is.list(choice))
      return(choice)
    if (name == "")
      stop("All sub-lists in \"choices\" must be named.")
    choicesWithNames(choice)
  }, SIMPLIFY = FALSE)
  missing <- names(choices) == ""
  names(choices)[missing] <- as.character(choices)[missing]
  choices
}
