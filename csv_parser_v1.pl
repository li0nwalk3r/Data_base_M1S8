#Make sure you install the following modules before running this script
#To run it just write on cmdline - perl csv_parser.pl "PATH_TO_FILE" "FILENAME.ext"
# !/usr/bin/perl
#use DBI;
use strict;
use warnings;
use Text::CSV;

sub parseCSV() {
    
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
    
    open (my $fh, "<", $input) || die "Can't open file $input";
    
    my $csv=Text::CSV->new();
    
    my @idAnimal;
    my @nameAnimal;
    my @typeAnimal;
    my @color;
    my @sexe;  
    my @sterilized;
    my @yearOfBirth;
    my @vaccin1;
    my @vaccin2;
    my @vaccin3;
    my @cellphone; 
    my @surname;
    my @name;
    my @street;
    my @postalCode;
    my @city;
    my @nbHabitants;
    my @departmentCode;
    my @tmpCellphone;
    my @tmpCity;

    $csv-> getline($fh);
    
    while (my $row = $csv -> getline($fh)){
	
	push @idAnimal, $row->[0];
	push @nameAnimal,$row->[1];
	push @typeAnimal , $row->[2];
	push @color,$row->[3];
	push @sexe, $row->[4];
	push @sterilized ,$row->[5];
	push @yearOfBirth , $row->[6];
	push @vaccin1, $row->[7];
	push @vaccin2 , $row->[8];
	push @vaccin3 , $row->[9];
	push @cellphone, $row->[10];
	push @surname , $row->[11];
	push @name , $row->[12];
	push @street , $row->[13];
	push @postalCode , $row->[14];
	push @city ,$row->[15];
	push @nbHabitants , $row->[16];
	push @departmentCode , $row->[17]

    }
    
    close($fh);

    #Connect to the source and handle connection
    my $dbh = DBI->connect("DBI:Pg:dbname=mfnabais;host=dbserver","mfnabais", "", {'RaiseError' => 1}) ;
    
    #Insert values into database (eliminating the duplicates)

    for (my $i = 0; $i < $#idAnimal; $i++){

	my $sql_animals = $dbh-> do("INSERT INTO animals (idanimal, nameanimal, typeanimal, coloranimal, sexanimal,cellphone) VALUES ($idAnimal[$i],'$nameAnimal[$i]','$typeAnimal[$i]','$color[$i]','$sexe[$i]',$cellphone[$i])") || die $dbh->errstr;

	my $sql_healtbook = $dbh-> do("INSERT INTO healthbook (idanimal, sterilized, yearofbirth, vaccine1, vaccine2, vaccine3) VALUES ($idAnimal[$i],'$sterilized[$i]',$yearOfBirth[$i],$vaccine1[$i],$vaccine2[$i],$vaccine3[$i])") || die $dbh->errstr;
	
	if (scalar(grep(/$cellphone[$i]/,@tmpCellphone)) eq 0){
	    push @tmpCellphone, $cellphone[$i];
	    my $sql_owner= $dbh-> do("INSERT INTO owner (surname, name, cellphone, street, city, postalcode) VALUES ('$surname[$i]','$name[$i]',$cellphone[$i],'$street[$i]','$city[$i]',$postalcode[$i])") || die $dbh->errstr;
	}
	
	if (scalar(grep(/$city[$i]/,@tmpCity)) eq 0){
	    push @tmpCity, $city[$i];
	    my $sql_city= $dbh-> do("INSERT INTO city (city, nbhabitantscity, departmentcode) VALUES ('$city[$i]', $nbHabitants[$i] ,departmentCode[$i])") || die $dbh->errstr;
	}    
    }
       
    $dbh->disconnect();

}

parseCSV();
