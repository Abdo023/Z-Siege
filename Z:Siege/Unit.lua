local U = {}


function U.new( parent )
	local unit = display.newCircle( parent, 0, 0, 15 )
	unit.strokeWidth = 2


	function unit.move( x,y )
		local move = transition.to( unit, {x=x, y=y, time=500} )
		print( "Unit Moving" )
	end

	return unit
end

return U