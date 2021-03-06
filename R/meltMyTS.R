#' Use \pkg{reshape2}'s \code{melt} on multivariate time series object
#' 
#' \code{meltMyTS} is primarily designed to prepare data to be used with  
#' \code{\link[QMSS]{ggMyTS}} (\pkg{QMSS}) to make plots of time series trends
#' with \code{\link[ggplot2]{ggplot}}.
#'
#' @param mv.ts.object A multivariate time series object created with \code{\link[stats]{ts}}.
#' @param time.var A character string naming the time variable.
#' @param keep.vars An optional character vector with names of variables to keep. 
#' If \code{keep.vars} is not specified then all variables in \code{mv.ts.object} 
#' will be kept. However, if any variables are named then all other variables will
#' be dropped, except \code{time.var}, which is always kept.   
#' @return A molten data frame.
#' @author Jonah Gabry <jsg2201@@columbia.edu>. See \code{\link[reshape2]{melt}} 
#' in (\pkg{reshape2}) for the author of the original \code{melt} function. 
#' @seealso \code{\link[QMSS]{ggMyTS}}, \code{\link[reshape2]{melt.data.frame}} 
#' @export
#' @examples
#' See examples in documentation for ggMyTS.

meltMyTS <- function(mv.ts.object, time.var, keep.vars){
  # mv.ts.object = a multivariate ts object
  # keep.vars = character vector with names of variables to keep 
  # time.var = character string naming the time variable
  require(reshape2)
  
  if(missing(keep.vars)) {
    melt.dat <- data.frame(mv.ts.object)
  }
  else {
    if (!(time.var %in% keep.vars)){
      keep.vars <- c(keep.vars, time.var)
    }
    melt.dat <- data.frame(mv.ts.object)[, keep.vars]
  }
  melt.dat <- melt(melt.dat, id.vars = time.var)
  colnames(melt.dat)[which(colnames(melt.dat) == time.var)] <- "time"
  return(melt.dat)
}
