#!/usr/bin/env ruby

require 'bindata'
require File.join(File.dirname(__FILE__),'..','types')
require File.join(File.dirname(__FILE__),'..','structs')

fail "Filename not given" if ARGV[0].nil?

# .bin files are sequences of <RtpStreamInfoT,IPAddr,IPAddr>
File.open(ARGV[0]) do |io|
    fmth = "%-15s %5s %-15s %5s %-10s %9s\n"
    fmtr = "%-15s %5d %-15s %5d 0x%08x %9d\n"
    printf fmth, 'src', 'port', 'dst', 'port', 'SSRC', 'npkts'
    while not io.eof?
        r         = RtpStreamInfoT.read(io)
        src_addr  = IPAddr.read(io)
        dest_addr = IPAddr.read(io)
        printf fmtr,
            src_addr,
            r.src_port,
            dest_addr,
            r.dest_port,
            r.ssrc,
            r.npackets
    end
end
