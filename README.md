# Forecasting financial time series

<p> Forecasting competition at the Barcelona Graduate School of Economics. We were given a training dataset with several covariates and a target financial time series. The objective was to develop a forecasting algorithm which was to be tested against an out-of-sample dataset. </p>

<p>The algorithm that I developed together with some colleagues won the competition. It was based on an autoregressive model (AR1) coupled with an exponential generalized autoregressive conditional heteroskedastic model (EGARCH(1,1)) and included also some covariates. The code in R is included in the file 'model.R'. The test data used to fit the model are included in the file 'training_dataset.csv' </p>

### <a href="https://www.youtube.com/watch?v=jJDSCSLbXmY">Results of the competition</a> 

<p>In the video above, the performance of the best performing algorithms is displayed. The black lines indicate the true value of the series, the color lines the prediction of each algorithm. Ours is the one at the upper-left corner, the other ones are the three best performing competitors.</p>