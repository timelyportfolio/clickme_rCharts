##as this point, this is unnecessary since I lost the ability to knit_expand

xtsAsMelt <- function(opts) {
  require(xts)
  require(reshape2)
  
  #translate xts to a melted time series with 3 columns (date, indexname, and value)
  #for this behavior will be more generic than the original
  #data will not be transformed, so template.rmd will be changed to reflect
  
  
  #convert to data frame
  data.df <- data.frame(cbind(format(index(opts$data),"%Y-%m-%d"),coredata(opts$data)))
  colnames(data.df)[1] = "date"
  data.melt <- melt(data.df,id.vars=1,stringsAsFactors=FALSE)
  colnames(data.melt) <- c('date','indexname','value')
  #remove periods from indexnames to prevent javascript confusion
  #these . usually come from spaces in the colnames when melted
  data.melt[,"indexname"] <- apply(matrix(data.melt[,"indexname"]),2,gsub,pattern="[.]",replacement="")
  return(data.melt)
}
