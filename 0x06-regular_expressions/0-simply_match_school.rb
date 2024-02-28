#!/usr/bin/env ruby

def match_school(input)
  pattern = /School/

  matches = input.scan(pattern)

  if matches.any?
    puts matches.join
  else
    puts "$"
  end
end

if ARGV.empty?
  puts "Usage: ./0-simply_match_school.rb <input>"
else
  input = ARGV[0]
  match_school(input)
end
