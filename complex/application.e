note
	description : "complex application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			a : COMPLEX
			b : COMPLEX
			c : COMPLEX
			d : COMPLEX
			e : COMPLEX
			f : COMPLEX
		do
			create a.make(1,-5)
			create b.make(2, 3)
			c := a + b
			create d.make (-5, 0)
			create e.make (0, -1)
			create f.make (1, 0)

			print(c)
			print(d)
			print(e)
			print(f)
		end

end
