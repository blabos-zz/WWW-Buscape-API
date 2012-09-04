#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'WWW::Buscape::API' ) || print "Bail out!\n";
}

diag( "Testing WWW::Buscape::API $WWW::Buscape::API::VERSION, Perl $], $^X" );
