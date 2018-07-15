#!/usr/bin/perl

use strict;
use warnings;

use File::Fetch;
my $url = 'http://anorien.csc.warwick.ac.uk/mirrors/download.opensuse.org/repositories/server:/monitoring/openSUSE_Leap_42.1/x86_64/zabbix-agent-2.2.21-1.1.x86_64.rpm';
my $local_file = 'zabbix-agent-2.2.21-1.1.x86_64.rpm';
my $ff = File::Fetch->new(uri => $url);
my $file = $ff->fetch() or die $ff->error;
print "$file\n";
system "rpm -ivh $file";
system "rm -rf $file";
system "chmod 777 /etc/zabbix/zabbix-agentd.conf";
my $filename = '/etc/zabbix/zabbix-agentd.conf';
if (-e $filename) {
print "File Exists!\n";
}
else {
print "File Doesnt Exist\n";
exit;
}
system "chmod 777 /etc/zabbix/zabbix-agentd.conf";
system "sed -i s/Server=127.0.0.1/Server=domain.com/g /etc/zabbix/zabbix-agentd.conf";
print "Enter Hostname: ";
my $name = <STDIN>;
chomp $name;
system "sed -i 's/Hostname=Zabbix server/Hostname=$name/g' /etc/zabbix/zabbix-agentd.conf";
system "sed -i '/ServerActive=127.0.0.1/s/^/#/g' /etc/zabbix/zabbix-agentd.conf"; 
print "Hostname is '$name'\n";
print "Starting Zabbix-agent";
my $service= `rczabbix-agentd start \n`;


