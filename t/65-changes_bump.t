use warnings;
use strict;
use feature 'say';

use Carp;
use Cwd qw(getcwd);
use Data::Dumper;
use Test::More;
use Dist::Mgr qw(:all);
use version;

use lib 't/lib';
use Helper qw(:all);
use Hook::Output::Tiny;

my $cwd = getcwd();
like $cwd, qr/dist-mgr$/, "in root dir ok";
die "not in the root dir" if $cwd !~ /dist-mgr$/;

my $work = 't/data/work/Changes-release';
my $orig = 't/data/orig/Changes-release';

unlink_changes();

# version_bump()
{
    copy_changes();

    changes_bump(5.55, $work);
    my @d = split /\n/, file_scalar($work);

    is $d[0], 'Revision history for Test-Module', "line 0 ok";
    is $d[1], '', "line 1 ok";
    is $d[2], '5.55 UNREL', "line 2 ok";
    is $d[3], '    -', "line 3 ok";
    is $d[4], '', "line 4 ok";
    like $d[5], qr/0.01    \d{4}-\d{2}-\d{2}/, "line 5 ok";
    is $d[6], '    - Auto generated distribution with Dist::Mgr', "line 6 ok";
}

unlink_changes();

done_testing;
