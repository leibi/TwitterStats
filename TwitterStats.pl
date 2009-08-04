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
      $fStruct = Friend->new();
      print "Processing: ". $myfriend->{'screen_name'} . "\n";
      $fStruct->name($myfriend->{'screen_name'});
      $fStruct->NbFriends($myfriend->{'friends_count'});
      $fStruct->NbFollowers($myfriend->{'followers_count'});
      push(@FriendsArray,$fStruct);
   }

   foreach(@FriendsArray){
      print $_->name() . " has ";
      print $_->NbFriends() . " friends and ";
      print $_->NbFollowers() . " followers \n";
   }
  

