#!/usr/bin/env ruby

# Date: 2014.9.12
# Author: Hojung Yun

require 'optparse'

# set the version of script
VERSION = "0.1"

# set default value of arguments
# do not add mandatory options here
options = {
    :upper_case => false,
    :lower_case => false,
    :number => false,
    :special_ch => false
}

# option parser
opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage:"
  opt.separator "     #{File.basename($0)} [options] <mix> <max> <count>"
  opt.separator ""
  opt.separator "Examples:"
  opt.separator "     #{File.basename($0)} -u -l -n -s 3 5"
  opt.separator ""
  opt.separator "Options"

  opt.on("-u", "--upper_case", "Upper case letters (a to z)") do
    options[:upper_case] = true
  end
  opt.on("-l", "--lower_case", "Lower case letters (A to Z)") do
    options[:lower_case] = true
  end
  opt.on("-n", "--number", "Numbers (0 to 9)") do
    options[:number] = true
  end
  opt.on("-s", "--special_ch", "Special characters (!@#$%*)") do
    options[:special_ch] = true
  end
  opt.on("-v", "--version", "Display script version") do
    puts VERSION
    exit
  end
  opt.on("-h", "--help", "Display help messages") do
    puts opt_parser
    exit
  end
end

begin
  opt_parser.parse!

  # validate argument
  if ARGV.empty?
    puts "Missing mix and max numbers of characters"
    puts opt_parser #<------- print help messages
    exit 1 #<------- exit with exit code 1. check with 'echo $!' after running script
  elsif ARGV.count > 2
    puts "Too many arguments"
    puts opt_parser
    exit 2
  else
    mix_num = ARGV[0].to_i
    max_num = ARGV[1].to_i
  end

rescue OptionParser::InvalidOption, OptionParser::MissingArgument
  puts $!.to_s
  puts opt_parser
  exit
end

range_upper_case = [*'A'..'Z']
range_lower_case = [*'a'..'z']
range_number = [*'0'..'9']
range_special_ch = ['!', '@', '#', '$', '%', '*']

range = []
range += range_upper_case if options[:upper_case]
range += range_lower_case if options[:lower_case]
range += range_number if options[:number]
range += range_special_ch if options[:special_ch]

loop do
  random_num = mix_num + Random.rand(max_num-mix_num+1)
  puts Array.new(random_num) { range.sample }.join
end

__END__

$ ./rkey_gen.rb -h
Usage:
     rkey_gen.rb [options] <mix> <max>

Examples:
     rkey_gen.rb -u -l -n -s 3 5

Options
    -u, --upper_case                 Upper case letters (a to z)
    -l, --lower_case                 Lower case letters (A to Z)
    -n, --number                     Numbers (0 to 9)
    -s, --special_ch                 Special characters (!@#$%*)
    -v, --version                    Display script version
    -h, --help                       Display help messages

$ ./rkey_gen.rb -u -l -n -s 3 5
s3Qnc
dp2%
Io8
Cxc4r
-snip-

