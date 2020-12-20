use warnings;
use strict;
use Test::More;

use Data::Dumper;
use Module::Bump::Version qw(:all);

# no version
is eval { bump_version(); 1 }, undef, "no supplied version croaks ok";
like $@, qr/version parameter/, "...and error is sane";

# invalid version
is eval { bump_version('aaa'); 1 }, undef, "invalid version croaks ok";
like $@, qr/The version number/, "...and error is sane";

# invalid dir
is eval { bump_version('1.00', 'asdf'); 1 }, undef, "invalid dir croaks ok";
like $@, qr/Directory.*invalid/, "...and error is sane";

# get_version ok

my $data = get_version();

for (keys %$data) {
    print "$_: $data->{$_}\n";
}

done_testing();

