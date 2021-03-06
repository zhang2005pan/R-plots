data{
  int N; // number of blocks
  real temp[N];
  real temp_sq[N];
  real ratio[N];
  real ratio_sq[N];
  real contact[N];
  real contact_sq[N];
  real temp_ratio[N];
  real temp_contact[N];
  real ratio_contact[N];
  real conversion[N];
}
parameters{
  real constant;
  real beta_mean;
  real beta[9];
  real sigma; 
}
transformed parameters{
  real yhat[N];
  for(i in 1:N)
    yhat[i] <- constant + beta[1] * temp[i] +
      beta[2] * temp_sq[i] +
      beta[3] * ratio[i] +
      beta[4] * ratio_sq[i] +
      beta[5] * contact[i] +
      beta[6] * contact_sq[i] +
      beta[7] * temp_ratio[i] +
      beta[8] * temp_contact[i] +
      beta[9] * ratio_contact[i];
}
model{
  beta_mean ~ normal(0, 1);
  for(i in 1:9)
    beta[i] ~ normal(beta_mean, 5);
  conversion ~ normal(yhat, sigma);
}
