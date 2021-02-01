#' Plot map of study area and sampling grids
#'
#' @param map_sp_path Path of map shapefiles.
#' @param grids_sp_path Path of sampling grids shapefiles.
#' @param grids_col_var A variable to be used to plot strata (e.g., depth or longitudinal regions) with different colors.
#' @param grids_col A color palette to be used to plot strata (e.g., depth or longitudinal regions).
#' @param xlim Numeric vectors of length 2, giving the longitude range.
#' @param ylim Numeric vectors of length 2, giving the latitude range.
#' @param xlab A title for the x axis.
#' @param ylab A title for the y axis.
#' @param map_col A color for land.
#' @param map_border_col A color for border of land.
#' @param grids_border_col A color for border of grids.
#' @param legend_x X coordinate to be used to position the legend.
#' @param legend_y Y coordinate to be used to position the legend.
#' @param legend A character vector to appear in the legend
#' @param legend_title A character string to appear at the top of the legend.
#'
#' @import grDevices
#' @import maps
#' @import mapdata
#' @import rgdal
#' @import graphics
#' @import sp
#'
#' @return A map of study area and sampling grids
#'
#' @export
#'
#' @examples
#' \dontrun{
#' plot_map_grid(xlim=c(-70.8, -67), ylim=c(42.5, 44.8))
#' }
plot_map_grid <- function(map_sp_path=NULL,
                          grids_sp_path=NULL,
                          grids_col_var=NULL,
                          grids_col=NULL,
                          xlim=NULL,
                          ylim=NULL,
                          xlab="Longitude",
                          ylab="Latitude",
                          map_col="gray95",
                          map_border_col="black",
                          grids_border_col="black",
                          legend_x=NULL,
                          legend_y=NULL,
                          legend=NULL,
                          legend_title=NULL)

{
    ## Set up an empty plot
    plot(NULL,
         xlim=xlim, ylim=ylim,
         xlab=xlab, ylab=ylab,
         axes=F,
         type="n")

    ## Check if there is any map shapefiles and use map function if there is no shapefile for plotting land
    if (is.null(map_sp_path)) {
        warning("There is no shapefile for plotting map. We will use map function to plot.")

        map("worldHires",
            xlim=xlim, ylim=ylim,
            col=map_col, fill=TRUE,
            border=map_border_col, lwd=0.2,
            add=TRUE)
    } else {
        map_poly <- rgdal::readOGR(dsn=map_sp_path)
        map(map_poly,
            col=map_col, fill=TRUE,
            border=map_border_col, lwd=0.2,
            add=TRUE)
    }

    ## Check if there is any grids shapefiles
    if (is.null(grids_sp_path)) {
        warning("There is no shapefile for plotting sampling grids.")
    } else {
        grids <- rgdal::readOGR(dsn=grids_sp_path)
        var <- grids[[grids_col_var]]
        if (is.null(grids_col)) {
            palette(rainbow(length(unique(var))))
        } else {
            palette(grids_col)
        }

        map(grids,
            col=var, fill=TRUE,
            border=grids_border_col, lwd=0.2,
            add=TRUE)
    }
    box()
    degAxis(1, font=2)
    degAxis(2, font=2)

    if (!is.null(legend)) {
        legend(x=legend_x, y=legend_y,
               legend=legend,
               fill=palette(),
               cex=0.8,
               bty="n",
               title=legend_title)
    }

}
