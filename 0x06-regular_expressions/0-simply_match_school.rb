#!/usr/bin/env ruby

def match_school(input)
  pattern = /School$/

  match = pattern.match(input)

  if match
    puts match[0]
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
