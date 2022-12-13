local http = game:GetService("HttpService")
local resp = http:GetAsync("http://localhost:9999")
local data = http:JSONDecode(resp)

local screen = workspace:WaitForChild("Screen")
local disp = screen:WaitForChild("Display")
local glay = disp:WaitForChild("UIGridLayout")
local cont = screen:WaitForChild("Container")

while true do
	local resp = http:GetAsync("http://localhost:8124")
	local imgd = http:JSONDecode(resp)
	w,h = unpack(imgd.size)
	glay.CellSize = UDim2.new(1/w,0,1/h,0)
	data = imgd.data
	
	while #disp:GetChildren()-1 < #data do
		local new = cont:Clone()
		new.Name = #disp:GetChildren()-1
		new.Parent = disp
	end
	for i,rgb in pairs(data) do
		local pix = disp:FindFirstChild(i)
		if pix then
			pix.BackgroundColor3 = Color3.fromRGB(unpack(rgb))
		end
	end
	task.wait()
end
