class RtpmonRecord
    attr_reader :rtp_stream_info, :src_addr, :dest_addr
    def initialize(r,s_addr,d_addr)
        @rtp_stream_info = r
        @src_addr        = s_addr
        @dest_addr       = d_addr
    end
end

class RtpmonReader
    def initialize(filename)
        @io = File.open(filename)
    end
    def records
        if block_given?
            while not @io.eof?
                yield RtpmonRecord.new(RtpStreamInfoT.read(@io),IPAddr.read(@io),IPAddr.read(@io))
            end
        else
            Enumerator.new(self, :records)
        end
    end
end

# Lifted from BinData's examples
class IPAddr < BinData::Primitive
  array :octets, :type => :uint8, :initial_length => 4

  def set(val)
    ints = val.split(/\./).collect { |int| int.to_i }
    self.octets = ints
  end

  def get
    self.octets.collect { |octet| "%d" % octet }.join(".")
  end
end
