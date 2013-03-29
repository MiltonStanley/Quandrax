class EU3_Province
  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def add(line)

  end

  def write(location)

  end

end

def split_key_val_pair(line)
  line.split('=',2)
end

def make_provinces(array)
  temp_file = File.open('../lib/templates/province.tmp')
  while line = temp_file.gets
    key, value = split_key_val_pair(line)
    if is_province_header?(key)
      array << EU3_Province.new(key) 
    else
      array.last.add(line)
    end
  end
end

def is_province_header?(key)
  key =~ /^\d+/
end

array = Array.new
make_provinces(array)
array.each { |prov| prov.write(Kernel) }