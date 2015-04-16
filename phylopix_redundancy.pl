#!/usr/bin/perl

# Public domain.

if($ARGV[0] eq "") {
print "no input file.\nsyntax: reduntant.pl <input> <output> <cutoff>\n"; exit; }
if($ARGV[1] eq "") {
print "no output file.\nsyntax: reduntant.pl <input> <output> <cutoff>\n"; exit; }
if($ARGV[2] eq "") {
print "no cutoff value.\nsyntax: reduntant.pl <input> <output> <cutoff>\n"; exit; }

print "opening file...\n";
open(FILE, "$ARGV[0]");
@file = <FILE>;
close(FILE);

print "pre routines...\n";

undef %saw;
@file = grep(!$saw{$_}++, @file);

foreach $x (@file) {
($one, $two, $three, $four) = split "\t", $x;
$four = ($four / 100);
$x = "$one\t$two\t$four\t$three\n";
if ($four < $ARGV[2]) { undef $x; }
if ($one eq $two) { undef $x; }
}

print "checking for identical matches...\n";

my %seen;

foreach $_ (@file) {
      next if $seen{ join "|", (split)[1, 0] };
      $seen{ join "|", (split)[0, 1] } ++;
      push(@final, $_);
}

$firstfinal = $final[0]; chomp $firstfinal;
if ($firstfinal eq "0") { undef $final[0]; }

print "writing...\n"; 
open(RESULTFILE, ">$ARGV[1]"); 
print RESULTFILE @final; 
close(RESULTFILE);
