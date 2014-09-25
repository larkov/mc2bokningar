#!/usr/bin/env ruby
#
# Script to create an ICS file from a csv file for import to mrbs
#

require 'CSV'
require 'date'

if ARGV[0] != nil
  puts 'BEGIN:VCALENDAR'
  CSV.foreach(ARGV[0], { :col_sep => ';' }) do |row|
    puts 'BEGIN:VEVENT'
    startdate = DateTime.strptime(row[3],'%d/%m/%y %H:%M')
    enddate = DateTime.strptime(row[4],'%d/%m/%y %H:%M')
    sdate = startdate.strftime("%Y%m%dT%H%M00")
    edate = enddate.strftime("%Y%m%dT%H%M00")
    puts 'DTSTART;TZID=Europe/Stockholm:'+sdate #20140624T083000'
    puts 'DTEND;TZID=Europe/Stockholm:'+edate #20140624T093000'
    puts 'SUMMARY:'+row[1]
    if row[2] == nil
      name = 'Unknown'
    else
      name = row[2]
    end
    puts 'DESCRIPTION:Imported from old\n Name:'+ name
    puts 'LOCATION:MC2 - '+row[0]
    puts 'STATUS:CONFIRMED'
    puts 'ORGANIZER;CN="'+name+'":mailto:'+row[1]
    puts 'END:VEVENT'
  end
  puts 'END:VCALENDAR'
  puts ''
else
  puts "First command should be which csvfile to convert"
end
