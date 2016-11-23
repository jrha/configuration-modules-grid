use strict;
use warnings;

BEGIN {
    *CORE::GLOBAL::sleep = sub {};
}


use Test::More;
use CAF::Object;
use Test::Quattor qw(simple);
use NCM::Component::maui;

$CAF::Object::NoAction = 1;

set_caf_file_close_diff(1);

my $cfg = get_config_for_profile('simple');
my $cmp = NCM::Component::maui->new('simple');

set_file_contents("/var/spool/maui/maui.cfg", "something");

# fake sysvinit file, should be enough to bypass existence check
set_file_contents("/etc/init.d/maui", "something");


command_history_reset();

is($cmp->Configure($cfg), 1, "Component runs correctly with a test profile");

my $fh = get_file("/var/spool/maui/maui.cfg");
is("$fh", "#\n# File generated by ncm-maui\n#\nsomething new\n", "File content updated");

ok(command_history_ok([
       'service maui stop',
       'service maui start',
]), "expected commands for change");

done_testing;