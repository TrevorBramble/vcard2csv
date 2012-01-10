#!/usr/bin/env ruby

require 'vcard'

if ARGV.length < 2
  puts "Usage: vcard2allcsv input_file output_file [all]\n"
  exit
end

unless vcard_file = File.open(ARGV[0])
  puts "Unable to read Vcard file\n"
  exit
end

unless csv_file = File.new(ARGV[1], 'w')
  puts "Unable to write CSV file\n"
end

all = (ARGV[2].nil? or ARGV[2] != 'all') ? false : true

vcards = ''

for line in vcard_file do vcards << line end

contacts = Vpim::Vcard.decode(vcards)

for contact in contacts
  csv_line = ''

  if all
    csv_line += "\"#{contact.name.fullname}\","
    csv_line += "\"#{contact.email}\","
  else
    csv_line += "\"#{contact.name.fullname}\","
    csv_line += "\"#{contact.emails.join(',')}\","
    csv_line += "\"#{contact.telephone}\","
    csv_line += "\"#{contact.note}\","
    csv_line += "\"#{contact.nickname}\""
  end

  csv_file << "#{csv_line}\n"
end

