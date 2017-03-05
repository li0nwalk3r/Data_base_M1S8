#Make sure you install the following modules before running this script
#To run it just write on cmdline - perl csv_parser.pl "PATH_TO_FILE" "FILENAME.ext"
# !/usr/bin/perl
use strict;
use warnings;
use Text::CSV;

# Check validity of command-line args
my $num_args = $#ARGV + 1;
if ($num_args != 2) {
    print "\nUsage: csv_parser.pl path_to_file filename\n";
    exit;
}

#Read the CSV file & create lists that correspond to different attributes
my $path_to_file = $ARGV[0];
my $filename = $ARGV[1];
my $input= join("",$path_to_file,$filename);
my $csv=Text::CSV->new();

open(INPUT, $input) || die "Can't open file $input";

while (<INPUT>){
    if($csv->parse($_)) {       #checks to see if data exists in $_ and parses it if it does
	my @fields=$csv->fields;  # puts the values from each field in an array
	#print join(" ",@fields,"\n");
	print join(" ",@fields[0,1,2,3],"\n");
	my $elements = @fields;
    }
    print $elements;
}



close(INPUT);


