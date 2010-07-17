#!/usr/bin/perl

# Rudi Farkas 12 Dec 2009

# ----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# Rudi Farkas wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return (Guiness if possible).
# ----------------------------------------------------------------------------


# Searches the Xcode directory and its subdirectories xib files
# for each file yyy.xib creates the corresponding yyy.txt file
# which contains the output from akosma's utility nib2objc which uses ibtool

# Also replaces variable names matching /view\w+/ by UI-type dependent variable names
# for example "view25"  =>  "tabBarItem25"

# Requires Mac OSX utility nib2objc from http://github.com/akosma/nib2objc to be installed as /usr/local/bin/nib2objc

# Version 1.1
# Now using a hash %{$oldtonew} to manage multiple old to new substitutions



my $usage = "$0 <directory>";

use strict;
use File::Find;
use File::Slurp;

my $dir = ''; 

my $dir = shift || '';
die "*** bad directory : '$dir'\nusage: $usage\n\n" unless -d $dir;

my $nib2objc = "/usr/local/bin/nib2objc";

my $nf = 0;

File::Find::find( { wanted => \&wanted, no_chdir => 1 }, $dir);

#print "$nf files seen\n";

exit;


sub wanted {
    my $path = $File::Find::name;
    return if -d $path;
    ++$nf;
    if ($path =~ /\.xib$/i) {
        nib2objc($path);
    }        
}

sub nib2objc {
	my $infilepath = shift;
	my $outfilepath = $infilepath;
	$outfilepath =~ s/\.xib$/.txt/i;
    my @output = `$nib2objc $infilepath`;
    
    printf "$infilepath : file seen (%d lines)\n", 0 + @output;
    
    my $oldtonew = {}; 	# ref to empty hash
    for (@output) {
    	# detect a UI var and create substitute
   	    if (my ($uitype, $uivarsuffix) = $_ =~ /^UI(\w+) \*view(\d+) =/) {
   			my $newuivar = lcfirst $uitype;
   			$newuivar .= $uivarsuffix;
   			my $olduivar = "view$uivarsuffix";
     		printf "    olduivar=%s  =>  newuivar=%s\n", $olduivar, $newuivar;
     		$oldtonew->{$olduivar} = $newuivar;
  		}
  		# use substitutes created so far
  		for my $olduivar (keys %{$oldtonew}) {
  			my $newuivar = $oldtonew->{$olduivar};
  			if (s/\b$olduivar\b/$newuivar/g) {
       			#print;
			}
  		}
    }
    
    if (write_file $outfilepath, @output) {
    	print "$outfilepath : file written\n";
    }
    else {
     	print "$outfilepath : failed to write\n";
   }
   
   
}

