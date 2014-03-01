package My::Suite::OQGraph;

@ISA = qw(My::Suite);

return "No OQGraph" unless $ENV{HA_OQGRAPH_SO} or
                           $::mysqld_variables{'oqgraph'} eq "ON";

sub is_default { 1 }

bless { };

