#!/usr/bin/perl
while(<>) {
    ($line  = $_   ) =~ s/^\s+|\s+$//g;
    ($quote = $line) =~ s/'/\\'/g;
    ($value = $line) =~ s/^\s*(var )?(.*)\s*=.*$/$2/;
    $value = "''" if $value eq $line;
    print "console.log('LOGGER: ', this&&this.klass||'' ,' $quote ');\n";
    print $_;
}
