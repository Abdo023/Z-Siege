local C = {}

function C.hex (hex, alpha) 
	local redColor,greenColor,blueColor=hex:match('(..)(..)(..)')
	redColor, greenColor, blueColor = tonumber(redColor, 16)/255, tonumber(greenColor, 16)/255, tonumber(blueColor, 16)/255
	redColor, greenColor, blueColor = math.floor(redColor*100)/100, math.floor(greenColor*100)/100, math.floor(blueColor*100)/100
	if alpha == nil then
		return redColor, greenColor, blueColor
	elseif alpha > 1 then
		alpha = alpha / 100
	end
	return redColor, greenColor, blueColor, alpha
end

function C.rgb (r, g, b, alpha)
	local redColor,greenColor,blueColor=r/255, g/255, b/255
	redColor, greenColor, blueColor = math.floor(redColor*100)/100, math.floor(greenColor*100)/100, math.floor(blueColor*100)/100
	if alpha == nil then
		return redColor, greenColor, blueColor
	elseif alpha > 1 then
		alpha = alpha / 100
	end
	return redColor, greenColor, blueColor, alpha
end


function C.white(  )
	return  1,1,1
end

function C.black(  )
	return  0,0,0
end

function C.red(  )
	return  1,0,0
end

function C.green(  )
	return  0,1,0
end

function C.blue(  )
	return  0,0,1
end

function C.grey(  )
	return  C.rgb( 105,105,105 )
end

function C.purple(  )
	return  C.rgb( 138,43,226 )
end

function C.cyan(  )
	return  C.rgb( 0,255,255 )
end

function C.yellow(  )
	return  C.rgb( 255,255,0 )
end

function C.gold(  )
	return  C.rgb( 255,215,0 )
end

function C.orange(  )
	return  C.rgb( 255,140,0 )
end

function C.pink(  )
	return  C.rgb( 255,105,180 )
end

function C.brown(  )
	return  C.rgb( 139,69,19 )
end

return C