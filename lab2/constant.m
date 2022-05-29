 p=0.01;
 k1=0:p:2;
 k2=k1;
 f1=exp(-6*k1);
 f2=exp(-3*k2);
 [f,k]=sconv(f1,f2,k1,k2,p);