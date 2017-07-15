#! usr/bin/perl
use warnings;
use strict;
open FH,"$ARGV[0]",or die $!;
open OUT,">$ARGV[0].q2030",or die $!;
my $i=0;
my @a;
my $q20=0;
my $q30=0;
my $j;
my $line;

while (<FH>){
chomp $_;
$i ++;
$line = $i;
if ($line % 4 == 0) {
	@a=split (//,$_);
	for ($j=0; $j<=$ARGV[1]-1; $j++){
		if (ord($a[$j]) >= 53){
			$q20 = $q20+1;
		}
		if (ord($a[$j])>= 63){
			$q30 = $q30+1;
		}
	}
}
}

my $no=$line/4;
print OUT "Seq No\."."\t"."$no"."\n";
my $Q20 = $q20/$ARGV[1]/$line*400;
my $Q30 = $q30/$ARGV[1]/$line*400;
print OUT "Q20\t$Q20\n";  
print OUT "Q30\t$Q30\n";

close FH;
close OUT;

