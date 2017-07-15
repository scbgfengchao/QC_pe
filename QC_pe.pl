#!/usr/bin/perl
use strict;
use warnings;

my ($line1,$line2, $line3, $line4, $len,$n,$n1,$nnum,@arr,%hash);
my $i=0;

$n = int($ARGV[1]/20);
$n1 = int($ARGV[2]/20);

open(FH1, "$ARGV[0]_raw.1.fq.filter") || die($!);
open(FH,"$ARGV[0]_raw.2.fq.filter") || die($!);
open(OUT, ">$ARGV[0]_1.fq") || die($!);
open(OUT1,">$ARGV[0]_2.fq") || die($!);

while(<FH>){
	chomp;
	$i ++;
	if ($i % 4== 1){
		@arr = split /\s+/;
		$line1 = $arr[0];
	}elsif ($i % 4== 2) {
		$line2 = $_;
		$len = length ($_);
		$nnum=()=$_=~m/N/ig;
	}elsif ($i % 4== 3) {
		$line3 = $_;
	}else{
		$line4 = $_;
		if($len eq $ARGV[1] && $nnum lt $n){
			$hash{$arr[0]}=$line1."\n".$line2."\n".$line3."\n".$line4."\n";
		}
	}
}

while(<FH1>){
	chomp;
	$i ++;
	if ($i % 4== 1){
		@arr = split /\s+/;
		$line1 = $arr[0];
	}elsif ($i % 4== 2) {
		$line2 = $_;
		$len = length ($_);
		$nnum=()=$_=~m/N/ig;
	}elsif ($i % 4== 3) {
		$line3 = $_;
	}else{
		$line4 = $_;
		if($len eq $ARGV[2] && $nnum lt $n1){
			if (exists $hash{$arr[0]}) {
				print OUT1 $hash{$arr[0]};
				print OUT $line1."\n".$line2."\n".$line3."\n".$line4."\n";
			}
		}
	}
}

close OUT;
close OUT1;
close FH;
close FH1;

