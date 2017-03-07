#Make sure you install the following modules before running this script
#To run it just write on cmdline - perl csv_parser.pl "PATH_TO_FILE" "FILENAME.ext"
# !/usr/bin/perl
use DBI;
use strict;
use warnings;
use Text::CSV;

sub parseCSV {
    
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

    my @id_animal;

    open(INPUT, $input) || die "Can't open file $input";

    while (<INPUT>){
	
	next if ($. == 1);
	chomp($_);
	if($csv->parse($_)) {  #checks to see if data exists in $_ and parses it if it does
	    
	    my @fields=$csv->fields;  # puts the values from each field in an array
	    
	    for my $elem (@fields){
		$elem= "NULL" if (!defined($elem) || ($elem eq "")); #replace empty values with NULL
		    
	    } 
		
	    my @animals = join(",",@fields[0,1,2,3,4]); #change to the number of fields (variables) of interest

	    
	    #Connect to the source and handle connection
	    my $dbh = DBI->connect("DBI:Pg:dbname=mfnabais;host=dbserver","mfnabais", "", {'RaiseError' => 1}) ;
		
	    #Prepare insert statement for table animals
	    my $sql = $dbh-> prepare("INSERT INTO Animals VALUES (?,?,?,?,?)") || die $dbh->errstr;
	    
	    foreach my $elem (@animals){
		$sql-> execute(split(",",$elem)) || die $dbh-> errstr;
		print $elem;
	    }

	    
	    
	    $dbh->disconnect();
	 
    
	}

    close(INPUT);

    }
}

parseCSV();
