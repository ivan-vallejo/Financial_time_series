
predictor.wenge <- function(y){
  ## load library
  if (!require("rugarch")) install.packages("rugarch")
  library(rugarch)

  ## eGARCH(1,1) + AR1 fit incl. covariates in both mean & variance
  x <- y[-length(y[,1]),-1]
  f <- y[-1,1]
  vars_selected <- c(10,4,40,39,36,17,37,38)
  x_ahead <- as.matrix(tail(y,1)[,vars_selected+1])
  
  fit.spec <- ugarchspec(variance.model = list(model = "eGARCH", 
                                               garchOrder = c(1, 1),
                                               external.regressors = as.matrix(x[,vars_selected])), 
                         mean.model = list(armaOrder = c(1, 0),
                                           include.mean = TRUE,
                                           archm=FALSE,
                                           archpow=1,
                                           external.regressors = as.matrix(x[,vars_selected])),
                         distribution.model = "norm")
  ## fit model, if it not converges collect error and use backup predictor
  fit <- try(ugarchfit(data = f, spec = fit.spec, scale=TRUE, solver = "solnp",
                       solver.control = list(trace=FALSE,tol=1e-12, delta=1e-11)),silent = TRUE)
  
  if("try-error" %in% class(fit)){
    ## if it failed to converge, run backup predictor AR1
    ar1 <- arima(f,order=c(1,0,0),xreg=x[,vars_selected])
    options(warn=-1)
    return(as.numeric(predict(ar1,newxreg=x_ahead)$pred))
  } else{
  ## prediction eGARCH(1,1)+AR1
    predict <- try(fitted(ugarchforecast(fit,n.ahead=1, external.forecasts = list(mregfor=x_ahead,vregfor=NULL))),
                   silent = TRUE)
    if("try-error" %in% class(predict)){
      ar1 <- arima(f,order=c(1,0,0),xreg=x[,vars_selected])
      options(warn=-1)
      return(as.numeric(predict(ar1,newxreg=x_ahead)$pred[1]))
    } else{
      return(as.numeric(predict))
      }
  }
}