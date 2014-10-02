#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 8;
use Test::NoWarnings;
use Test::Quattor qw(disk atlas-fed-redir);
use NCM::Component::xrootd;
use Readonly;
use CAF::Object;
Test::NoWarnings::clear_warnings();

Readonly my $XROOTD_CONFIG_PATH => '/software/components/xrootd';
Readonly my $XROOTD_DISKSRV_HOST => 'grid41.lal.in2p3.fr';
Readonly my $XROOTD_REDIR_HOST => 'grid05.lal.in2p3.fr';

Readonly my $XROOTD_SYSCONFIG_CONTENTS_1 => '# This file is managed by Quattor - DO NOT EDIT lines generated by Quattor
#
#-------------------------------------------------------------------------------
# Define the instances of xrootd, cmsd and frmd here and specify the option you
# need. For example, use the -d flag to send debug output to the logfile,
# the options responsible for daemonizing, pidfiles and instance naming will
# be appended automatically.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Define the user account name which will be used to start the daemons.
# These may have many unexpected side effects, so be sure you know what you are
# doing before playing with them.
#-------------------------------------------------------------------------------
XROOTD_USER=dpmmgr
XROOTD_GROUP=dpmmgr

#-------------------------------------------------------------------------------
# Define the commandline options for the instances of the daemons.
# The format is:
# DAEMON_NAME_OPTIONS, where:
#   DAEMON - the daemon name, the valid values are: XROOTD, CMSD or FRMD
#   NAME   - the name of the instance, any uppercase alphanumeric string
#            without whitespaces is valid
#-------------------------------------------------------------------------------
XROOTD_DISK_OPTIONS=" -l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmdisk.cfg -k 90"		# Line generated by Quattor
XROOTD_REDIR_OPTIONS="-l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmredir.cfg"
XROOTD_FEDREDIR_ATLAS_OPTIONS="-l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmfedredir_atlas.cfg"
CMSD_FEDREDIR_ATLAS_OPTIONS="-l /var/log/xrootd/cmsd.log -c /etc/xrootd/xrootd-dpmfedredir_atlas.cfg"

#-------------------------------------------------------------------------------
# Names of the instances to be started by default, the case does not matter,
# the names will be converted to lowercase automatically, use space as a
# separator
#-------------------------------------------------------------------------------
XROOTD_INSTANCES=disk		# Line generated by Quattor

#export XROOT_FED_REMOTE_CMSD_MANAGER_ATLAS=meta-manager.example.com+:1234
#export XROOT_FED_REMOTE_XRD_MANAGER_ATLAS=meta-manager.example.com:1094
#export XROOT_FED_LOCAL_PORT_ATLAS=11000

# setup the DPM and DPNS hostnames from the gsiftp config, if available
if [ -e /etc/sysconfig/dpm-gsiftp ]; then
  . /etc/sysconfig/dpm-gsiftp
else
DPM_HOST=grid05.lal.in2p3.fr		# Line generated by Quattor
DPNS_HOST=grid05.lal.in2p3.fr		# Line generated by Quattor
fi
export DPM_HOST
export DPNS_HOST

if [ `uname -m` = "x86_64" ]; then
        XRDLIBDIR="lib64"
else
        XRDLIBDIR="lib"
fi
export XRDLIBDIR
export XRD_MAXREDIRECTCOUNT=1

export DPM_CONRETRY=0
export DPNS_CONRETRY=0

#export DPMXRD_ALTERNATE_HOSTNAMES=
#DAEMON_COREFILE_LIMIT=unlimited
MALLOC_ARENA_MAX=4		# Line generated by Quattor
';

Readonly my $XROOTD_SYSCONFIG_CONTENTS_2 => '# This file is managed by Quattor - DO NOT EDIT lines generated by Quattor
#
#-------------------------------------------------------------------------------
# Define the instances of xrootd, cmsd and frmd here and specify the option you
# need. For example, use the -d flag to send debug output to the logfile,
# the options responsible for daemonizing, pidfiles and instance naming will
# be appended automatically.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Define the user account name which will be used to start the daemons.
# These may have many unexpected side effects, so be sure you know what you are
# doing before playing with them.
#-------------------------------------------------------------------------------
XROOTD_USER=dpmmgr
XROOTD_GROUP=dpmmgr

#-------------------------------------------------------------------------------
# Define the commandline options for the instances of the daemons.
# The format is:
# DAEMON_NAME_OPTIONS, where:
#   DAEMON - the daemon name, the valid values are: XROOTD, CMSD or FRMD
#   NAME   - the name of the instance, any uppercase alphanumeric string
#            without whitespaces is valid
#-------------------------------------------------------------------------------
XROOTD_DISK_OPTIONS=" -l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmdisk.cfg -k 90"            # Line generated by Quattor
XROOTD_REDIR_OPTIONS="-l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmredir.cfg"
XROOTD_FEDREDIR_ATLAS_OPTIONS="-l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmfedredir_atlas.cfg"
CMSD_FEDREDIR_ATLAS_OPTIONS="-l /var/log/xrootd/cmsd.log -c /etc/xrootd/xrootd-dpmfedredir_atlas.cfg"

#-------------------------------------------------------------------------------
# Names of the instances to be started by default, the case does not matter,
# the names will be converted to lowercase automatically, use space as a
# separator
#-------------------------------------------------------------------------------
XROOTD_INSTANCES=           # Line generated by Quattor

#export XROOT_FED_REMOTE_CMSD_MANAGER_ATLAS=meta-manager.example.com+:1234
#export XROOT_FED_REMOTE_XRD_MANAGER_ATLAS=meta-manager.example.com:1094
#export XROOT_FED_LOCAL_PORT_ATLAS=11000

# setup the DPM and DPNS hostnames from the gsiftp config, if available
if [ -e /etc/sysconfig/dpm-gsiftp ]; then
  . /etc/sysconfig/dpm-gsiftp
else
#DPM_HOST=grid05.lal.in2p3.fr            # Line generated by Quattor
#DPNS_HOST=grid05.lal.in2p3.fr           # Line generated by Quattor
fi
export DPM_HOST
export DPNS_HOST

if [ `uname -m` = "x86_64" ]; then
        XRDLIBDIR="lib64"
else
        XRDLIBDIR="lib"
fi
export XRDLIBDIR
export XRD_MAXREDIRECTCOUNT=1

export DPM_CONRETRY=0
export DPNS_CONRETRY=0

#export DPMXRD_ALTERNATE_HOSTNAMES=
#DAEMON_COREFILE_LIMIT=unlimited
MALLOC_ARENA_MAX=4              # Line generated by Quattor
';

Readonly my $XROOTD_SYSCONFIG_CONTENTS_3 => '# This file is managed by Quattor - DO NOT EDIT lines generated by Quattor
#
#-------------------------------------------------------------------------------
# Define the instances of xrootd, cmsd and frmd here and specify the option you
# need. For example, use the -d flag to send debug output to the logfile,
# the options responsible for daemonizing, pidfiles and instance naming will
# be appended automatically.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Define the user account name which will be used to start the daemons.
# These may have many unexpected side effects, so be sure you know what you are
# doing before playing with them.
#-------------------------------------------------------------------------------
XROOTD_USER=dpmmgr
XROOTD_GROUP=dpmmgr

#-------------------------------------------------------------------------------
# Define the commandline options for the instances of the daemons.
# The format is:
# DAEMON_NAME_OPTIONS, where:
#   DAEMON - the daemon name, the valid values are: XROOTD, CMSD or FRMD
#   NAME   - the name of the instance, any uppercase alphanumeric string
#            without whitespaces is valid
#-------------------------------------------------------------------------------
XROOTD_DISK_OPTIONS="-l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmdisk.cfg"
XROOTD_REDIR_OPTIONS=" -l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmredir.cfg -k 90"		# Line generated by Quattor
XROOTD_FEDREDIR_ATLAS_OPTIONS="-l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmfedredir_atlas.cfg"
CMSD_FEDREDIR_ATLAS_OPTIONS="-l /var/log/xrootd/cmsd.log -c /etc/xrootd/xrootd-dpmfedredir_atlas.cfg"

#-------------------------------------------------------------------------------
# Names of the instances to be started by default, the case does not matter,
# the names will be converted to lowercase automatically, use space as a
# separator
#-------------------------------------------------------------------------------
XROOTD_INSTANCES="redir atlasfed"		# Line generated by Quattor
CMSD_INSTANCES=atlasfed		# Line generated by Quattor

#export XROOT_FED_REMOTE_CMSD_MANAGER_ATLAS=meta-manager.example.com+:1234
#export XROOT_FED_REMOTE_XRD_MANAGER_ATLAS=meta-manager.example.com:1094
#export XROOT_FED_LOCAL_PORT_ATLAS=11000

# setup the DPM and DPNS hostnames from the gsiftp config, if available
if [ -e /etc/sysconfig/dpm-gsiftp ]; then
  . /etc/sysconfig/dpm-gsiftp
else
DPM_HOST=grid05.lal.in2p3.fr		# Line generated by Quattor
DPNS_HOST=grid05.lal.in2p3.fr		# Line generated by Quattor
fi
export DPM_HOST
export DPNS_HOST

if [ `uname -m` = "x86_64" ]; then
        XRDLIBDIR="lib64"
else
        XRDLIBDIR="lib"
fi
export XRDLIBDIR
export XRD_MAXREDIRECTCOUNT=1

export DPM_CONRETRY=0
export DPNS_CONRETRY=0

#export DPMXRD_ALTERNATE_HOSTNAMES=
#DAEMON_COREFILE_LIMIT=unlimited
CMSD_ATLASFED_OPTIONS=" -l /var/log/xrootd/cmsd.log -c /etc/xrootd/xrootd-dpmfedredir_atlasfed.cfg -k 90"		# Line generated by Quattor
CMSD_CMSFED_OPTIONS=" -l /var/log/xrootd/cmsd.log -c /etc/xrootd/xrootd-dpmfedredir_cmsfed.cfg -k 90"		# Line generated by Quattor
XROOTD_ATLASFED_OPTIONS=" -l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmfedredir_atlasfed.cfg -k 90"		# Line generated by Quattor
XROOTD_CMSFED_OPTIONS=" -l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmfedredir_cmsfed.cfg -k 90"		# Line generated by Quattor
MALLOC_ARENA_MAX=4		# Line generated by Quattor
';

$CAF::Object::NoAction = 1;

=pod

=head1 SYNOPSIS

This is a test suite for configuring a disk server with ncm-xrootd.

=cut

my $cmp = NCM::Component::xrootd->new('xrootd');
my $config = get_config_for_profile("disk")->getElement($XROOTD_CONFIG_PATH)->getTree();

set_file_contents($XROOTD_SYSCONFIG_FILE, $XROOTD_SYSCONFIG_CONTENTS_1);
$cmp->configureNode($XROOTD_DISKSRV_HOST,$config);
my $fh = get_file($XROOTD_SYSCONFIG_FILE);
ok(defined($fh), "$XROOTD_SYSCONFIG_FILE was opened (1)");
is("$fh",$XROOTD_SYSCONFIG_CONTENTS_1,"$XROOTD_SYSCONFIG_FILE has expected contents (1)");
$fh->close();

set_file_contents($XROOTD_SYSCONFIG_FILE, $XROOTD_SYSCONFIG_CONTENTS_2);
$cmp->configureNode($XROOTD_DISKSRV_HOST,$config);
$fh = get_file($XROOTD_SYSCONFIG_FILE);
ok(defined($fh), "$XROOTD_SYSCONFIG_FILE was opened (2)");
is("$fh",$XROOTD_SYSCONFIG_CONTENTS_1,"$XROOTD_SYSCONFIG_FILE has expected contents (2)");
$fh->close();

$config = get_config_for_profile("atlas-fed-redir")->getElement($XROOTD_CONFIG_PATH)->getTree();
set_file_contents($XROOTD_SYSCONFIG_FILE, $XROOTD_SYSCONFIG_CONTENTS_3);
$cmp->configureNode($XROOTD_REDIR_HOST,$config);
$fh = get_file($XROOTD_SYSCONFIG_FILE);
ok(defined($fh), "$XROOTD_SYSCONFIG_FILE was opened (3)");
is("$fh",$XROOTD_SYSCONFIG_CONTENTS_3,"$XROOTD_SYSCONFIG_FILE has expected contents (3)");
$fh->close();


Test::NoWarnings::had_no_warnings();
