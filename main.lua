local http = game:GetService("HttpService")
local resp = http:GetAsync("http://localhost:9999")
local data = http:JSONDecode(resp)

local screen = workspace:WaitForChild("Screen")
local disp = screen:WaitForChild("Display")
local glay = disp:WaitForChild("UIGridLayout")
local cont = screen:WaitForChild("Container")

local PORT = 8124

while true do
	--// Get image data from server
	local resp = http:GetAsync("http://localhost:"..PORT)
	local imgd = http:JSONDecode(resp)
	w,h = unpack(imgd.size)
	glay.CellSize = UDim2.new(1/w,0,1/h,0)
	data = imgd.data
	
	--// Creates all the necessary "pixels"
	while #disp:GetChildren()-1 < #data do
		local new = cont:Clone()
		new.Name = #disp:GetChildren()
		new.Parent = disp
	end
	
	--// Draws image to screen
	for i,rgb in pairs(data) do
		local pix = disp:FindFirstChild(i)
		if pix then
			pix.BackgroundColor3 = Color3.fromRGB(unpack(rgb))
		end
	end
	task.wait()
end
