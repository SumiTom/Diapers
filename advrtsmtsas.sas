/*  *//*  *//*  *//*  *//*  *//*  */
/*Effect of Advertisement on Sales*/
/*  *//*  *//*  *//*  *//*  *//*  */

FILENAME REFFILE '/home/samanbonbamak13700/sas final project/trans_groupbyBrandWeekStore_1.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.transBWS_1;
	GETNAMES=YES;
RUN;

data delivery;
INFILE '/home/samanbonbamak13700/sas final project/Delivery_Stores.txt' expandtabs;
run;

data a;
set work.transBWS_1;
run;

PROC CONTENTS DATA=a; RUN;

proc print data=a (obs = 10);
run;


proc freq data=a;
table store_n/out = try;
run;

proc sort data=a;
by store_n;
run;

proc sort data=try;
by store_n;
run;

data a1;
merge try a;
by store_n;
drop percent;
run;

/*delete only 1 obs & interaction terms*/
data a2;
set a1;
if count < 2 then delete;
F_AD = F_A*D;
F_Adisc = F_A*disc;
F_AplusD = F_Aplus*D;
F_Aplusdisc = F_Aplus*disc;
F_BD = F_B*D;
F_Bdisc = F_B*disc;
F_Ddisc = D*disc;
run;

/*POLS without time effect*/
proc reg data=a2;
model sale = price F_A F_Aplus F_B D disc F_AD F_Adisc F_AplusD F_Aplusdisc F_BD F_Bdisc F_Ddisc;
run;

/*Hausmantest*/
proc panel data=a2;
id store_n week;
model sale = price F_A F_Aplus F_B D disc /Rantwo;
run;

/*FixedEffect*/
proc panel data=a2;
id store_n week;
model sale = price F_A F_Aplus F_B D disc F_Adisc F_Aplusdisc F_Bdisc /fixtwo;
run;

/* *****Final model**** No Interaction terms fixed effect two  */
proc panel data=a2;
id store_n week;
model sale = price F_A F_Aplus F_B D disc /fixtwo;
run;

proc means data=a2;
var price F_A F_Aplus F_B D disc;
run;
/*Mean of independent variables*/
/* Price 0.3104334 */
/* F_A 0.0644955 */
/* F_Aplus 0.0039261 */
/* F_B 0.0467618 */
/* D 0.0168741 */
/* disc 0.1893186 */




/*  *//*  *//*  *//*  *//*  *//*  */
/* PAMPERS marketing effect on HUGGIES Sales */
/*  *//*  *//*  *//*  *//*  *//*  */
/* FILENAME REFFILE '/home/samanbonbamak13700/sas final project/Competitors_marketing_effect.csv'; */
/* PROC IMPORT DATAFILE=REFFILE */
/* 	DBMS=CSV */
/* 	OUT=WORK.comp_me_1; */
/* 	GETNAMES=YES; */
/* RUN; */
/* data a3; */
/* set work.comp_me_1; */
/* run; */
/* proc print data=a3(obs=10); */
/* run; */
/* Hausman test */
/* proc panel data=a3; */
/* id store_n week; */
/* model sale_h = price_h	feature_h	disc_h	display_h	price_p	feature_p	disc_p	display_p; */
/* run; */
/* POLS */
/* proc reg data=a3; */
/* model sale_h = price_h	feature_h	disc_h	display_h	price_p	feature_p	disc_p	display_p; */
/* run; */
/* Fixed Effect */
/* proc panel data=a3; */
/* id store_n week; */
/* model sale_h = price_h	feature_h	disc_h	display_h	price_p	feature_p	disc_p	display_p /fixone; */
/* run; */
/*  */
/* Fixed Time Effect without feature */
/* proc panel data=a3; */
/* id store_n week; */
/* model sale_h = price_h	feature_h	disc_h	display_h	price_p	disc_p	display_p /fixtwo; */
/* run; */
/*  */
/* proc corr data=a3 noprob outp=OutCorr /** store results * */
/*           nomiss /** listwise deletion of missing values * */
/*           cov;   /**  include covariances * */
/* var sale_h price_h	feature_h	disc_h	display_h	price_p	feature_p	disc_p	display_p; */
/* run; */

/*  *//*  *//*  *//*  *//*  *//*  */
/*Cross Price Elacticity*/
/*  *//*  *//*  *//*  *//*  *//*  */
FILENAME REFFILE '/home/samanbonbamak13700/sas final project/CrossPriceElacticity.csv';
PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.cross_pe;
	GETNAMES=YES;
RUN;
data a4;
set work.cross_pe;
run;
proc print data=a4;
run;
/*  */
proc reg data=a4;
model res = BENETTON BUMPIES DRYPERS HUGGIES LUVS PAMPERS;
run;

/*  *//*  *//*  *//*  *//*  *//*  */
/*RFM Customer Analysis*/
/*  *//*  *//*  *//*  *//*  *//*  */


