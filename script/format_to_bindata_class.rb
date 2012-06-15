#!/usr/bin/env ruby

TypeMap = {
     'guint16' => 'uint16',
     'guint32' => 'uint32',
     'int'     => 'int32',
     'gint'    => 'int32',
     'double'  => 'double'
}

def structname_to_classname(structname)
    structname.gsub!(/^([^_])|_([^_])/) do |match|
        s = $1 || $2
        s.upcase
    end
end

fail "No filename given" if ARGV[0].nil?

basefmt   = "  %-10s %-30s"
lengthfmt = "#{basefmt} %1s :length => %d\n"

state = 'scan'
prev_size, prev_ofs = 0, 0
structsize = 0
File.open(ARGV[0], 'r') do |f|
    f.each_line do |line|
        case state
        when 'scan'
            if line =~ /:$/
                line =~ /^([^\s]+)/
                structname = $1
                line =~ /\(\s*(\d+),/
                structsize = $1.to_i
                puts "class #{structname_to_classname structname} < BinData::Record"
                printf "#{basefmt}\n", 'endian', ':little'
                state = 'inclass'
            end
        when 'inclass'
            if line =~ /^\s*$/
                skip = structsize - prev_ofs - prev_size
                printf lengthfmt, 'skip', '', '', skip if skip > 0
                puts "end"
                prev_size, prev_ofs = 0, 0
                state = 'scan'
            elsif line =~ /\(\s*(\d+),\s*(\d+)\)/
                size, ofs = $1.to_i, $2.to_i
                skip = ofs - prev_ofs - prev_size
                type, name = line.split(/\s+/,3)[0,2]
                name.gsub! /\*/, ''
                name.gsub! /\[.*\]/, ''
                printf lengthfmt, 'skip', '', '', skip if skip > 0
                if TypeMap.has_key? type
                    printf "#{basefmt}\n", TypeMap[type], ':'+name
                else
                    printf lengthfmt, 'string', ':'+name, ',', size
                end
                prev_size, prev_ofs = size, ofs
            end
        end
    end
end
puts "end" if state == 'inclass'
