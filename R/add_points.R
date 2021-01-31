#' Add sampling stations
#'
#' @param stations_x A vector of x coordinates of sampling stations
#' @param stations_y A vector of y coordiates of sampling stations
#' @param col Color of sampling stations
#' @param points_cex A numeric value giving the size of points
#'
#' @return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' add_stations(station_x=c(-70.8, -67), station_y=c(42.5, 44.8), col="blue", point_ces=0.2)
#' }
add_stations <- function(stations_x=NULL,
                         stations_y=NULL,
                         col="red",
                         points_cex=0.5)

{
    if (is.null(stations_x)) {
        stop("Missing x coordiantes of sampling stations!")
    }

    if(is.null(stations_y)) {
        stop("Missing y coordiantes of sampling stations!")
    }

    points(stations_x, stations_y,
           pch=16, col=col, cex=points_cex)
}
