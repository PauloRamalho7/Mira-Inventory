package GLPI::Agent::Task::Inventory::Virtualization::Jails;

use strict;
use warnings;

use parent 'GLPI::Agent::Task::Inventory::Module';

use GLPI::Agent::Tools;
use GLPI::Agent::Tools::Virtualization;

sub isEnabled {
    return canRun('jls');
}

sub doInventory {
    my (%params) = @_;

    my $inventory = $params{inventory};
    my $logger    = $params{logger};

    foreach my $machine (_getVirtualMachines(logger => $logger)) {
        $inventory->addEntry(
            section => 'VIRTUALMACHINES', entry => $machine
        );
    }
}

sub  _getVirtualMachines {
    my (%params) = (
        command => 'jls -n',
        @_
    );

    my $handle = getFileHandle(%params);

    return unless $handle;

    my @machines;
    while (my $line = <$handle>) {
        my $info;
        foreach my $item (split(' ', $line)) {
            next unless $item =~ /(\S+)=(\S+)/;
            $info->{$1} = $2;
        }

        my $machine = {
            VMTYPE    => 'bsdjail',
            NAME      => $info->{'host.hostname'},
            STATUS    => STATUS_RUNNING
        };

        push @machines, $machine;

    }
    close $handle;

    return @machines;
}

1;
