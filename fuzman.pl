#!/usr/bin/perl -w
#program to verify fuzman filter
#inputs are Zin,Vin,Uk,Vref
#outputs are Vout,Zout,k
$M = 0.05; #Value of M
$Q = 0.01; #Value of Q
$Vin = 21; #initial estimate of input voltage
$Zin = 0.99; #initial estimate of input error
@Vref = qw(20 20.6 19.27 20.1 19.8 19.36 19.42 19.62 19.38 20.4 19.32 18.1 19.64 19.25 19.44 19.21 19.69 19.67 19.62 19.58);
$n = @Vref;
@Iref = qw(0.42 0.93 0.45 0.78 0.83 0.72 0.75 0.9 0.77 0.96 0.84 0.41 0.82 0.68 0.72 0.55 0.7 0.73 0.76 0.68);
for ( $j = 0;$j < $n; $j++ ) 
  {
   $P[$j] = $Vref[$j] * $Iref[$j]; #Power array is calculated here
  };
$Vopt = 21;
@Iopt = qw (1.19 1.20 1.22 1.24 1.22 1.21);
$q = @Iopt;
for ( $l = 0; $l < $q; $l++ )
  {
      $Popt[$l] = $Vopt * $Iopt[$l];
  };
fuzman ();
fuzman_opt ();
print "That's all folk!!";
####################################################
################# Fuzman algorithm #################
####################################################
sub fuzman
{
open (FIRST,">fuzman.txt");
 for ( $i = 0;$i < $n;$i++ )
  { 
      $h = $i - 1;
   if ( $i == '0' )
    {
      $Zcap[$i] = $Zin + $Q; # Priori error probability projectile
      $k[$i] = $Zcap[$i] / ($Zcap[$i] + 1); # Fuzzy gain
      $Vcap[$i] = $Vin + ($k[$i] * ($Vref[$i] - $Vin)); # priori voltage projectile
      $temp1 = $P[$i];
      $temp2 = $Vref[$i];
      $U[$i] = $temp1/$temp2;
      $V[$i] = $Vcap[$i] + ($M * $U[$i]); #Output fuzman voltage projectile
      $Zhat = $Zcap[$i] + 1; 
      $omega = $k[$i] * $k[$i] * $Zhat;
      $Z[$i] = ((1 - $k[$i]) * $Zcap[$i]) + $omega;
      $Pm[$i] = $V[$i] * $Iref[$i];
      }
      elsif ( $i > '0' )
          {
           $Zcap[$i] = $Z[$h] + $Q;
           $k[$i] = $Zcap[$i] / ($Zcap[$i] + 1); # Fuzzy gain
           $Vcap[$i] = $V[$h] + ($k[$i] * ($Vref[$i] - $V[$h]));
           $temp1 = $P[$i] - $P[$h];
           $temp2 = $Vref[$i] - $Vref[$h];
           $U[$i] = $temp1/$temp2;
           $V[$i] = $Vcap[$i] + ($M * $U[$i]); #Output fuzman voltage projectile
           $Zhat = $Zcap[$i] + 1; 
           $omega = $k[$i] * $k[$i] * $Zhat;
           $Z[$i] = ((1 - $k[$i]) * $Zcap[$i]) + $omega;
           $Pm[$i] = $V[$i] * $Iref[$i]; 
            }
      write(FIRST);
    }
   format FIRST_TOP =
Page @<<<
$%

 Vref   Iref   Pref        Gain         Voltage             Error             Power
====== ====== ====== =============== ============== ==================== ===============
.
format FIRST =
@<<<<< @<<<<< @<<<<< @<<<<<<<<<<<<<< @<<<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<
$Vref[$i], $Iref[$i], $P[$i], $k[$i], $V[$i], $Z[$i], $Pm[$i]
.
 close (FIRST);
             }
#####################################################################
################ Fuzman Optimal Conditions ##########################
#####################################################################
sub fuzman_opt
{
open (SECOND,">fuzman_opt.txt");
for ( $y = 0;$y < $q;$y++ )
  { 
      $g = $y - 1;
   if ( $y == '0' )
    {
      $Zcapopt[$y] = $Zin + $Q; # Priori error probability projectile
      $kopt[$y] = $Zcapopt[$y] / ($Zcapopt[$y] + 1); # Fuzzy gain
      $Vcapopt[$y] = $Vin + ($kopt[$y] * ($Vopt - $Vin)); # priori voltage projectile
     # $temp3 = $P[$y];
     # $temp4 = $Vopt;
      $Uopt[$y] = $Iopt[$y];
      $Vo[$y] = $Vcapopt[$y] + ($M * $Uopt[$y]); #Output fuzman voltage projectile
      $Zhatopt = $Zcapopt[$y] + 1; 
      $omegaopt = $kopt[$y] * $kopt[$y] * $Zhatopt;
      $Zopt[$y] = ((1 - $kopt[$y]) * $Zcapopt[$y]) + $omegaopt;
      $Pmopt[$y] = $Vo[$y] * $Iopt[$y];
      }
      elsif ( $y > '0' )
          {
           $Zcapopt[$y] = $Zopt[$g] + $Q; # Priori error probability projectile
           $kopt[$y] = $Zcapopt[$y] / ($Zcapopt[$y] + 1); # Fuzzy gain
           $Vcapopt[$y] = $Vo[$g] + ($kopt[$y] * ($Vopt - $Vo[$g])); # priori voltage projectile
          # $temp3 = $P[$y]-$P[$g];
          # $temp4 = $Vo[$g]-$Vopt;
           $Uopt[$y] = $Iopt[$y]-$Iopt[$g];
           $Vo[$y] = $Vcapopt[$y] + ($M * $Uopt[$y]); #Output fuzman voltage projectile
           $Zhatopt = $Zcapopt[$y] + 1; 
           $omegaopt = $kopt[$y] * $kopt[$y] * $Zhatopt;
           $Zopt[$y] = ((1 - $kopt[$y]) * $Zcapopt[$y]) + $omegaopt;
           $Pmopt[$y] = $Vo[$y] * $Iopt[$y];
            }
      write(SECOND);
  }
   format SECOND_TOP =
Page @<<<
$%

 Vopt   Iopt   Popt    Gain(optimal)  Voltage(opt)     Error(optimal)      Power(opt)
====== ====== ====== =============== ============== ==================== ===============
.
format SECOND =
@<<<<< @<<<<< @<<<<< @<<<<<<<<<<<<<< @<<<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<
$Vopt, $Iopt[$y], $Popt[$y], $kopt[$y], $Vo[$y], $Zopt[$y], $Pmopt[$y]
.
close (SECOND);
}
                 
