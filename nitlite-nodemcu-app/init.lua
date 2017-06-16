-- set the gpio mode for the desired pin
switch = 4
gpio.mode(switch, gpio.OUTPUT)
gpio.write(switch, gpio.LOW)

-- declare wifi ssid and password
ssid = "Shalz"
pass = "84015510"

-- configuring Wireless Internet
print('\nAll About Circuits init.lua\n')
wifi.setmode(wifi.STATION)
print('set mode=STATION (mode='..wifi.getmode()..')\n')
print('MAC Address: ',wifi.sta.getmac())
print('Chip ID: ',node.chipid())
print('Heap Size: ',node.heap(),'\n')
-- wifi config start
wifi.sta.config(ssid,pass)
-- wifi config end

-- connect 
print('\nAll About Circuits main.lua\n')
tmr.alarm(0, 1000, 1, function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...\n")
   else
      ip, nm, gw=wifi.sta.getip()
      print("IP Info: \nIP Address: ",ip)
      print("Netmask: ",nm)
      print("Gateway Addr: ",gw,'\n')
      tmr.stop(0)
   end
end)

-- setup the mqtt client
mqttClient = mqtt.Client("clientid", 120)

mqttClient:lwt("/lwt", "offline", 0, 0)

mqttClientm:on("connect", function(client) print ("connected") end)
mqttClient:on("offline", function(client) print ("offline") end)

-- start the mqtt client

-- listen for events