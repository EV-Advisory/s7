#' Check and convert a value into a reactive function
#'
#'
#' @description For some use cases in shiny app development, you will need to check if a value is a
#' reactive function or reactive value.  To preserve the generalizeable functionality of the ui and server functions,
#' this supporting function is used to convert a static value or values into a reactive declaration to be
#' used later on in the function.
#'
#' @param x object to convert if NOT already a reactive function
#'
#' @return Reactive function
#'
#' @importFrom shiny reactive
#'

to_reactive<-function(x){
  if(!is.reactive(x)) return(reactive(x))
  return(x)
}
