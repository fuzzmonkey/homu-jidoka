require "serialport"

port_str = "/dev/ttyAMA0"
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

puts 'connected to /dev/ttyAMA0'

while true do
  while (i = sp.gets.chomp) do       # see note 2
    puts "raw msg: #{i}"
    message_ar = i.split(" ").map{|c| c.to_i}
    node_id = message_ar.slice!(0)
    values = []

    message_ar.each_with_index do |char,i|
      value = char[i] + 256 * char[i+1]
      value -= 65536 if value > 32768
      values << value
    end

    puts "node_id #{node_id}: #{values}"
  end
end

sp.close