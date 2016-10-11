
readEDF <- function(name, checkConsistency=FALSE) {
    retVal <- NULL
    if (file.exists(name)) {
      retVal <- parseEDF(name);

      ## Convert factors to strings:
      retVal$events$msg <- as.character(retVal$events$msg)
      ## Remove empty events:
      retVal$events <- retVal$events[retVal$events$msg != "",]
      ## Delete TTL triggers if none present
      if(!any(retVal$input$ttl!=0)){
        retVal$input <- NULL
        retVal$samples$InputS <- NULL
        cat("No TTL triggers found. Now assuming no input was sent to the parallel port. Deleting the corresponding column in the output.")
      }
    } else {
        warning(paste0("Specified file (",name,") not found."))
    }
    return(retVal)
}
