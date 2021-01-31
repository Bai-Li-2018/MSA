#' Add shapefiles on map of study area
#'
#' @param sp_path Path of shapefiles.
#' @param col A color for added shapefile.
#' @param border_col A color for border of added shapefile.
#'
#' @import maps
#' @import rgdal
#' @import graphics
#'
#' @return A map with other added shapefiles
#'
#' @export
#'
#' @examples
#' \dontrun{
#' add_sp(sp_path=".", col="blue", border_col="black")
#' }
add_sp <- function(sp_path=NULL,
                   col=NULL,
                   border_col=NULL)

{
    if (is.null(sp_path)) {
        stop("There is no shapefile for plotting.")
    } else {
        sp <- rgdal::readOGR(dsn=sp_path)

        map(sp,
            col=col, fill=TRUE,
            border=border_col, lwd=0.2,
            add=TRUE)
    }
}
