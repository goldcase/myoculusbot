scriptId = 'com.thalmic.examples.myfirstscript'
scriptTitle = "Stallman"
scriptDetailsUrl = ""
key = ""
SHUTTLE_CONTINUOUS_TIMEOUT = 300
SHUTTLE_CONTINUOUS_PERIOD = 100
function onPoseEdge(pose, edge)
	myo.debug("onPoseEdge: " .. pose .. ": " .. edge)
    myo.unlock("hold")
    local keyedge = edge == "off" and "up" or "down"
	if pose == "waveIn" then
        key = "left_arrow"
	end
	if pose == "waveOut" then
        key = 'right_arrow'
	end
	if pose == "fist" then
        key = 'up_arrow'
	end
	if pose == "fingersSpread" then
        key = 'down_arrow'
	end
	if pose == "doubleTap" then
        key = 'space'
	end
	if pose == 'rest' then
		key = ''
	end
end
function onForegroundWindowChange(app, title)
    myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
    return true
end
function onPeriodic()
	local now = myo.getTimeMilliseconds()

	if shuttleTImeout then
		if (now - shuttleSince) > shuttleTimeout then
			shuttleBurst()

			shuttleTimeout = SHUTTLE_CONTINUOUS_PERIOD

			shuttleSince = now
		end
	end
	myo.keyboard(key, "press")
end