class RtpStreamInfoT < BinData::Record
  endian     :little                       
  string     :src_addr                      , :length => 16
  uint16     :src_port                     
  skip                                        :length => 6
  string     :dest_addr                     , :length => 16
  uint16     :dest_port                    
  skip                                        :length => 2
  uint32     :ssrc                         
  string     :pt                            , :length => 1
  skip                                        :length => 7
  string     :info_payload_type_str         , :length => 8
  uint32     :npackets                     
  uint32     :first_frame_num              
  uint32     :setup_frame_number           
  uint32     :start_sec                    
  uint32     :start_usec                   
  string     :tag_vlan_error                , :length => 4
  uint32     :start_rel_sec                
  uint32     :start_rel_usec               
  uint32     :stop_rel_sec                 
  uint32     :stop_rel_usec                
  string     :tag_diffserv_error            , :length => 4
  uint16     :vlan_id                      
  skip                                        :length => 2
  string     :rtp_stats                     , :length => 5000
  string     :problem                       , :length => 4
  skip                                        :length => 4
end
class TapRtpStatT < BinData::Record
  endian     :little                       
  string     :first_packet                  , :length => 4
  uint32     :flags                        
  uint16     :seq_num                      
  skip                                        :length => 2
  uint32     :timestamp                    
  uint32     :first_timestamp              
  uint32     :delta_timestamp              
  double     :bandwidth                    
  string     :bw_history                    , :length => 4800
  uint16     :bw_start_index               
  uint16     :bw_index                     
  uint32     :total_bytes                  
  uint32     :clock_rate                   
  skip                                        :length => 4
  double     :delta                        
  double     :jitter                       
  double     :diff                         
  double     :skew                         
  double     :sumt                         
  double     :sumTS                        
  double     :sumt2                        
  double     :sumtTS                       
  double     :time                         
  double     :start_time                   
  double     :lastnominaltime              
  double     :max_delta                    
  double     :max_jitter                   
  double     :max_skew                     
  double     :mean_jitter                  
  uint32     :max_nr                       
  uint16     :start_seq_nr                 
  uint16     :stop_seq_nr                  
  uint32     :total_nr                     
  uint32     :sequence                     
  string     :under                         , :length => 4
  int32      :cycles                       
  uint16     :pt                           
  skip                                        :length => 2
  int32      :reg_pt                       
end
class BwHistoryItem < BinData::Record
  endian     :little                       
  double     :time                         
  uint32     :bytes                        
  skip                                        :length => 4
end
class Address < BinData::Record
  endian     :little                       
  string     :type                          , :length => 4
  int32      :len                          
  string     :data                          , :length => 8
end
