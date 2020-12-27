#! /usr/bin/perl
use strict;
use warnings;
use ZOOM;
# https://metacpan.org/release/Net-Z3950-ZOOM
# perl -MCPAN -e shell
# install ZOOM
#
# needs libyaz from yaz toolkit
#https://www.indexdata.com/resources/software/yaz/
#http://ftp.indexdata.dk/pub/yaz/yaz-5.27.1.tar.gz
#./buildconf.sh
#./configure
# (sudo) make install

my ($host, $port, $dbname, $user, $pw, $syntax, $query, $max) = @ARGV;
# print "perlexecuted";
if (not defined $host && $port) {
  die "Need host and port\n";
}
else {
  if($host eq "--test" && defined $port) {
    #print "test $port \n";
    my $host2 = "";
    my $port2 = "";
    my $dbname2 = "";
    my $user2 = "";
    my $pw2 = "";
    my $syntax2 = "";
    my $query2 = "";
    my $max2 = 10;
    if($port eq 1){
      $host2 = "193.30.112.135";
      $port2 = "9991";
      $dbname2 = "HBZ01";
      $user2 = "";
      $pw2 = "";
      $syntax2 = "MAB";
      $query2 = "funktion";
    }
    #print "tt $host2 \n";
    my $records = get_records($host2, $port2, $dbname2, $user2, $pw2, $syntax2, $query2, $max2);
    #print $records;
    #return $records;
  }
  else{
    if(defined $host && defined $port && defined $dbname && defined $user && defined $pw && defined $syntax && defined $query){
        if(not defined $max){
        my $max = 10;
        }
      my $records = get_records($host, $port, $dbname, $user, $pw, $syntax, $query, $max);
		#print $records;
		#return $records;
    }
    else {
      die "Need more arguments\n";
    }
  }
}

sub get_records {
  my ($host1, $port1, $dbname1, $user1, $pw1, $syntax1, $query1, $max1) = @_;
  #print "$host1  $port1 $dbname1 $user1 $pw1 $syntax1 $query1\n";
  if(not defined $max1){
    my $max1 = 10;
    }
  if(defined $host1 && defined $port1 && defined $dbname1 && defined $user1 && defined $pw1 && defined $syntax1 && defined $query1){
  #print "$host1  $port1 $dbname1 $user1 $pw1 $syntax1 $query1\n";
  my $conn = new ZOOM::Connection($host1, $port1,
         databaseName => $dbname1,
         preferredRecordSyntax => uc $syntax1,
         user => $user1,
         password => $pw1,
         count => $max1
         );
         my $rs = $conn->search_pqf($query1);
         my $size = $rs->size();
         if($size > $max1){
         $size = $max1;
         }
         print(chr(0x1c));
         for(my $pos = 0; $pos < $size; $pos++){
            my $tmp = $rs->record($pos);
            if(not defined $tmp){
                print chr(0x00), "Can't get record for index $pos\n";
                next;
            }
            my $rec2 = $tmp->render();
            if(not defined $rec2){
                print chr(0x00), "Can't render for index $pos\n";
                next;
            }
            print "$pos", "\n", $rec2;
             if(uc $syntax1 eq "USMARC"){
            print chr(0x1d);
            }
         }
         print chr(0x1c);
         #my $rec = $rs->record(0);
         # print $rec->render();
	 return $rs;
  }
}
