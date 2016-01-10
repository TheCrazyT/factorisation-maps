begin
	function normalize_num(v,KL)
		R = 0
		i = 0
		n = 0
		x = 0
		y = 0
		
		while true
			if v & Int128(2)^i != 0
				R |= Int128(2)^x
			end
			x += 1
			i += 1
			n += 1
			if (KL & Int128(2)^n) != 0
				if x == 1
					R |= 1
					break
				end
				x = 0
				n += 1
			end
		end
		R
	end
	function not(v)
		v $ 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
	end
	
	J1_5 = 221535295005332079421278918372840789
	J2_5 = 265843691043184692583024226401150566
	J3_5 = 312757189261815779310224648909125752
	J4_5 = 331011454359735873466059311716269952
	J5_5 = 332301083698321892166315820995018752
	KL_5 = 951498461772324920048247814144335051808047104

	function primtest()
		# binary 11101 -> 29
		v = J1_5 & not(J2_5) & J3_5 & J4_5 & J5_5
		v = normalize_num(v,KL_5)
		x = 2^0 | 2^28
		v = v $ x
		R = (v==0)
		R
	end
	
	@time print(primtest())
	@time print(isprime(29))
	
	#Output:
	#true  0.250568 seconds (104.94 k allocations: 4.327 MB)
	#true  0.045355 seconds (34.15 k allocations: 1.562 MB)

	# Oh well ,we loose this by time :(, but only they "cheat" by using a PRIME table.
	# (it basically just looks up any number < 2^16 in a table that way.)
	# See https://github.com/JuliaLang/julia/blob/master/base/primes.jl
	# But might have more performance on big numbers!

end