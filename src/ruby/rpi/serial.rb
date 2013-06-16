require "serialport"

port_str = "/dev/ttyAMA0"
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

puts "connected to #{port_str}"

while true do
  while (i = sp.gets.chomp) do
    puts "raw msg: #{i}"

    message_ar = i.split(" ").map{|c| c.to_i}
    node_id = message_ar[0]
    values = []
    message_index = (1..message_ar.size-1).step(2).to_a

    message_index.each do |i|
      value = message_ar[i] + 256 * message_ar[i+1].to_i
      value -= 65536 if value > 32768
      values << value
    end

    puts "node_id #{node_id}: #{values}"
  end
end

sp.close