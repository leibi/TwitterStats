#!/usr/bin/perl
   
   #use strict;
   use Class::Struct;
   use Net::Twitter;
   use Term::ReadKey;


   struct Friend => {
       name => '$',
       NbFriends => '$',
       NbFollowers => '$',
       Friends => '@',
       Followers => '@',
   };

   my @FriendsArray;

   print "Please enter your twitter username:\t";
   my $username = <STDIN>;

   print "Please enter your twitter password:\t";
   ReadMode 'raw';
   my $passphrase;
   while (1) {
      my $key .= (ReadKey 0);
      if ($key ne "\n") {
        print '*';
        $passphrase .= $key
      } else {
         last
      }
   }
   ReadMode 'restore';


   my $twit = Net::Twitter->new({username=>$username, password=>$passphrase });
   my $friendres = $twit->friends();

   foreach $myfriend (@{$friendres}){  
      #while ( my ($key, $value) = each(%$myfriend) ) {
      # print "$key => $value\n";
      #}
      #print "Size : " .keys(%$myfriend) ."\n"; 
      #my $valname= $myfriend->{'screen_name'};
      #my $valnr= $myfriend->{'friends_count'};
      #print "Friend ". $valname . " has " . $valnr . " friends\n";

      $fStruct = Friend->new();
      print "Processing: ". $myfriend->{'screen_name'} . "\n";
      $fStruct->name($myfriend->{'screen_name'});
      $fStruct->NbFriends($myfriend->{'friends_count'});
      $fStruct->NbFollowers($myfriend->{'followers_count'});
      #$fStruct->Followers($twit->followers($myfriend->{'screen_name'}));
      #$fStruct->Friends($twit->friends($myfriend->{'screen_name'}));
      push(@FriendsArray,$fStruct);
   }

print "Printing Array:\n";
#my $counter = 0;
foreach(@FriendsArray){
  #print $counter . "\n";
  #$counter +=1;
  print $_->name() . " has ";
  print $_->NbFriends() . " friends and ";
  print $_->NbFollowers() . " followers \n";
  #foreach $fr ($_->Friends()){
  #      print "        => " . $fr->{'screen_name'} . "\n";
  #}
  #foreach $fo ($_->Followers()){
  #      print "        => " . $fo->{'screen_name'} . "\n";
  #}

}
  

