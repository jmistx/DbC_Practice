note
	description: "Summary description for {COMPLEX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMPLEX

	create
		make

	feature
		make(re_, im_: DOUBLE)
		do
			re := re_
			im := im_
			create double_math
		end

	feature -- Arithmetics
		infix "+" (other: COMPLEX) : COMPLEX
		local
			result_ : COMPLEX
		do
			create result_.make (re + other.re, im + other.im )
			Result := result_
		ensure
			real_part_addition: Result.re = re + other.re
			imaginary_part_addition: Result.im = im + other.im
		end


	feature -- Arithmetics
	-- (+, -)
	-- (a + ib) + (x + iy) = (a + x) + i(b + y)
		plus (op: COMPLEX)
		do
			re := re + op.re
			im := im + op.im
		ensure
			real_part_addition: re = old re + op.re
			imaginary_part_addition: im = old im + op.im
		end




	-- *, REAL, COMPLEX
	-- /
	-- radius, Angle



	-- * ensure:
	-- c.radius = a.radius * b.radius
	-- c.angle = a.angle + b.angle

	-- / ensure (a / b):
	-- pre-condition:
	-- b != 0 || a != 0
	-- post condition:
	-- b = 0 => Result = Infinity
	-- c.radius = a.radius / b.radius
	-- c.angle = a.angle - b.angle


	feature -- Access
		re: DOUBLE
		im: DOUBLE
		radius: DOUBLE
		do
			Result := double_math.sqrt(re*re + im*im)
		end
		angle: DOUBLE
		local
			angle_ : DOUBLE
		do
			create angle_
			if re > 0 then
				angle_ := double_math.arc_tangent (im / re)
			end
			if re < 0 and im > 0 then
				angle_ := double_math.arc_tangent (im / re) + double_math.pi
			end
			if re < 0 and im > 0 then
				angle_ := double_math.arc_tangent (im / re) - double_math.pi
			end
			if re = 0 and im = 0 then
				angle_ := 0
			end
			if re = 0 and im > 0 then
				angle_ := double_math.pi / 2
			end
			if re = 0 and im < 0 then
				angle_ := 3.0/2.0 * double_math.pi
			end
			if re > 0 and im = 0 then
				angle_ := 0
			end
			if re < 0 and im = 0 then
				angle_ := double_math.pi
			end
			from
			until
				angle_ >= 0
			loop
				angle_ := angle_ + 2 * double_math.pi
			end

			Result := angle_
		end

	feature {NONE} --Utils
		double_math : DOUBLE_MATH
		epsilon : DOUBLE
		do
			Result := 0.00000001
		end
		equals_with_epsilon(a, b : DOUBLE) : BOOLEAN
		do
			Result := double_math.dabs (a - b) < epsilon
		end


	-- Axiom
	-- sqrt(re^2 + im^2) = radius
	-- arctg(re/im) = Angle
	-- Angle < 2Pi
	-- r(cos(phi) + isin(phi)) = x + iy
	invariant
		raidus_agreed_with_coords: equals_with_epsilon(re*re + im*im, radius*radius)
		angle_not_negative: 0 <= angle
		angle_less_2Pi: angle < 2 * double_math.pi

		trigonometrical_form_agreed_with_real: equals_with_epsilon(radius * double_math.cosine (angle), re)
		trigonometrical_form_agreed_with_imaginary: equals_with_epsilon(radius * double_math.sine (angle), im)
end
