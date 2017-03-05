#!/usr/bin/perl
use strict;
use DBI;

# connect
my $dbh = DBI->connect("DBI:Pg:dbname=gbouchentouf;host=dbserver",
"gbouchentouf", "", {’RaiseError’ => 1});

# execute INSERT query
my $rows = $dbh->do("INSERT INTO test VALUES (5,3)");
print "$rows row(s) affected\n";

# execute SELECT query
my $sth = $dbh->prepare("SELECT * FROM test");
my $num = $sth->execute();
print “query returned $num rows\n”;

# iterate through resultset
while(my $ref = $sth->fetchrow_hashref()) {
print "$ref->{’a’}  $ref->{’b’}\n";
}

$sth->finish;
$dbh->disconnect();