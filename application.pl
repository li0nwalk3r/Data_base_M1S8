  GNU nano 2.7.4                                  Fichier : application.pl                                            

#!/usr/bin/perl
use strict;
use DBI;

=COMMENTARY

#-- PROCEDURE --

# execute INSERT query
my $rows = $dbh->do("INSERT INTO test VALUES (2)");
print "$rows row(s) affected\n";

# execute SELECT query
my $sth = $dbh->prepare("SELECT * FROM test");
my $num = $sth->execute();
print "query returned $num rows\n";

# iterate through resultset
while(my $ref = $sth->fetchrow_hashref()) {
print "$ref->{'a'}  $ref->{'b'}\n";
}
=cut 

sub importCsv{

}

sub menu{
	print" -- MENU --\n";
	print"\n";
	print"1. Import data from CSV file into database \n";
	print"2. Ongoing\n";
	print"3. Ongoing\n";
	print"4. Ongoing\n";
	print"0: Exit\n";
}

# -- MAIN --
# connect
my $dbh = DBI->connect("DBI:Pg:dbname=gbouchentouf;host=dbserver","gbouchentouf", "", {'RaiseError' => 1});

my $choice = -1;
menu();
while ($answer !=0) {
	$answer  = <STDIN>
	if (answer eq 1){
		importCsv();
	}
}


$sth->finish;
$dbh->disconnect();


