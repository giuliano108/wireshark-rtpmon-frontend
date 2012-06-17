require 'rubygems'
require 'bundler/setup'
require 'sinatra'

require File.join(File.dirname(__FILE__), 'environment')

helpers do
    def pp_unix_time(time)
        DateTime.strptime(time.to_s,'%s').strftime('%Y%m%d-%H:%M:%S')
    end
    def pp_duration(duration)
        secs  = duration.to_int
        mins  = secs / 60
        hours = mins / 60

        "%d:%02d:%02d" % [hours, mins % 60, secs % 60]
    end
    def calc_lost(rtp_stats)
        expected = (rtp_stats.stop_seq_nr + rtp_stats.cycles*65536) - rtp_stats.start_seq_nr + 1
        lost = expected - rtp_stats.total_nr
        if expected != 0
            lost_perc = (lost.to_f * 100)/expected.to_f
        end
        "%d (%.1f%%)" % [lost, lost_perc]
    end
=begin
        rtp_packet_analyse(&(strinfo->rtp_stats), pinfo, rtpinfo);
        if (strinfo->rtp_stats.flags & STAT_FLAG_WRONG_TIMESTAMP
            || strinfo->rtp_stats.flags & STAT_FLAG_WRONG_SEQ)
            strinfo->problem = TRUE;

reset_start
display_number
ajax (handles spinner)

=end
end

error do
    e = request.env['sinatra.error']
    Kernel.puts e.backtrace.join("\n")
    'Application error'
end

# root page
get '/' do
    haml :root
end

get '/data/:format' do
    sleep 3
    last_index = 0
    File.open(DataPath+'/rtpmonlast.txt','r') { |file| last_index = file.gets.to_i }
    @reader = RtpmonReader.new(DataPath+'/'+("rtpmon%05d.bin" % last_index))
    if params[:format] == 'html'
        haml :table, :layout => false
    else
        content_type :text
        "OK"
    end
end
