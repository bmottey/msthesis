data {
    // number of observations
    int<lower=1> Nobs;
    
    // number of predictors
    int<lower=1> Npreds;
     
    // number of regions
    int<lower=1> J;
    
    // response list of length Nobs
    real weight[Nobs];
    
    // response matrix
    matrix[Nobs, Npreds] X;
   
   // provide the id for each region
   // this will be a list of length N
   int<lower=1, upper=J> region[Nobs];
    
  }
  
  parameters {
    // matrix of regression coefficients ...
    // matrix[Npreds, J] beta; // this gives random slopes model
    vector[Npreds] beta; // this gives fixed slopes
    
    
    // region intercept
    vector[J] u;
    
    // specify the error terms
    real<lower=0> sigma_model;
    real<lower=0> sigma_region;
  }
  
  
  model {
    // declare a local variable
    real mu;
    // draw value from it's theoretical formulation
    u ~ normal(0, sigma_region);
    // likelihood
    for (i in 1:Nobs){
      // remember mu = XB + u  ... you could move this to transformed parameters
      mu = X[i, ]*beta + u[region[i]];
      weight[i] ~ normal(mu, sigma_model);
    }
  }
  
