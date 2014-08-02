class HomeController < ApplicationController
    
  BITS_PER_RAW_ITEM = 32
    
  def index
      
      @name = Array.new()
      @duration = Array.new()
      @fingerprint = Array.new()

      fpcalcpackage = File.join(Rails.root, 'exefiles', 'fpcalc_32bit')

      file1 = File.join(Rails.root, 'data', 'a.wav')
      @output1 = %x[#{fpcalcpackage} -version].to_s
      format1 = output1.to_s
      @name[0] = format1.split('=')[1].split("\n")[0].split('/').last
      @duration[0] = format1.split('=')[2].split("\n")[0]
      split_dat1 = format1.split('=').last
      @fingerprint[0] = split_dat1.split("\n")[0].split(',').map { |x| x.to_i }

      file2 = File.join(Rails.root, 'data', 'b.wav')
      output2 = %x[#{fpcalcpackage} -raw #{file2}].to_s
      format2 = output2.to_s
      @name[1] = format2.split('=')[1].split("\n")[0].split('/').last
      @duration[1] = format2.split('=')[2].split("\n")[0]
      split_dat2 = format2.split('=').last
      @fingerprint[1] = split_dat2.split("\n")[0].split(',').map { |x| x.to_i }

      max_raw_size = [@fingerprint[0].size, @fingerprint[1].size].max
      bit_size     = max_raw_size * BITS_PER_RAW_ITEM

      distance     = hamming_distance(@fingerprint[0], @fingerprint[1])

      @sim = 1 - distance.to_f / bit_size
      
      if (@output1 == '')
          @resp = 'command didnt return shit'
      else
          @resp = 'command returned shit'
      end
      
  end

  def test
  end
    
  def hamming_distance(raw1, raw2)
	distance = 0

	min_size, max_size = [raw1, raw2].map(&:size).sort

	min_size.times do |i|
	distance += (raw1[i] ^ raw2[i]).to_s(2).count('1')
	end

	distance += (max_size - min_size) * BITS_PER_RAW_ITEM
  end
  private :hamming_distance
    
end
