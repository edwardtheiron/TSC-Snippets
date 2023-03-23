---------------Odometer------------------
Odometer = {
	DistanceCount = 0,
	LastTickerCount = 0,
	PreviousUnSpeed = 0,
	Channels = {}
}

function Odometer:Update(speed,ticker)
	-- you can use Odometer not only each frame if you have "ticker"
	-- speed is a result of Call ("GetSpeed"), signed speed in m/s. ticker is basically +time each frame
	local speed_unsigned = math.abs(speed)
	if speed_unsigned < 0.01 then return end -- exit on zero speed
	local sign = speed / speed_unsigned -- sign: 1 or -1
	local mean = (self.PreviousUnSpeed + speed_unsigned) / 2
	local integral = mean * (ticker - self.LastTickerCount)
	self.DistanceCount = self.DistanceCount + integral
	self.LastTickerCount = ticker	
	self.PreviousUnSpeed = speed_unsigned
	for k, v in pairs(self.Channels) do
		if self.Channels[k] == "ended" then 
			break
		elseif self.Channels[k] - integral > 0.5 then
			self.Channels[k] = self.Channels[k] - integral
		else
			self.Channels[k] = "ended"
		end
	end
end

function Odometer:Start(channel_name,distance)
	if not self.Channels[channel_name] then 
		--Print("we started Odometer - "..channel_name,distance) 
		self.Channels[channel_name] = distance		
	end
end

function Odometer:Check(channel_name)
		return self.Channels[channel_name] or false
end

function Odometer:Remove(channel_name)
	self.Channels[channel_name] = nil
end
---------------Odometer end------------------