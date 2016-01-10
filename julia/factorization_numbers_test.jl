begin

	# Instead of maps we now reduce the maps to only the important bits
	# This reduces the memory/storage used dramatically.
	# Also calculation of binary-results change dramatically.
	# Output would be like:
	# 11110101000000000000000100000000000000000001
	# By counting the digits you simply find out by what number it is divideable.
	# In this case 24 is divideable through 1,2,3,4,6,8,12 and 24.
	# ToDo: Update main.cpp (use big number library there)
	#       Julia only supports 128bit integers as maximum, what a shame.
	#       I do not prefer to go back to lists or anything like that, maybe need to wait for updates.

	function normalize_num(v,KL)
		R = 0
		i = 0
		n = 0
		x = 0
		y = 0
		
		while true
			if v & UInt128(2)^i != 0
				R |= UInt128(2)^x
			end
			x += 1
			i += 1
			n += 1
			if (KL & UInt128(2)^n) != 0
				if x == 1
					R |= 1
					break
				end
				#println(x," ",i)
				x = 0
				n += 1
			end
		end
		R
	end
	function calc_fact_num(pos,fnum)
		R = UInt128(0)
		M = C[pos]
		N = K[fnum]
		i = 0
		for x in 1:SIZE
			for y in 1:SIZE
				if N[x,y]
					if M[x,y]
						R |= UInt128(2)^i
					end
					i += 1
				end
			end
		end
		R
	end
	function calc_kl(KL_X)
		R = UInt128(0)
		i = 0
		done = false
		for y in 1:SIZE
			for x in 1:SIZE
				if !KL_X[x,y]
					if x == 1
						done = true
					end
					R |= UInt128(2)^i
					if done
						break
					end
					i += 1
					break
				end
				i += 1
			end
			if done
				break
			end
		end
		R
	end
	function not(v)
		v $ 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
	end
	
	#v = normalize_num(0b1000000000001000000,0b11010101010010010000100000000)
	#println()
	#println(reverse(bin(v)))
	
	if true
	
	SIZE=2^5
	A = reshape(collect(0:SIZE*SIZE-1) % SIZE + 1,SIZE,SIZE)
	function F(x,y)
			A[y,x]
	end
	B = [F(x,y) for x=collect(1:SIZE),y=collect(1:SIZE)]
	
	C = Array(Array,6)
	C[1] = ((A.*B)&(2^0)).==2^0
	C[2] = ((A.*B)&(2^1)).==2^1
	C[3] = ((A.*B)&(2^2)).==2^2
	C[4] = ((A.*B)&(2^3)).==2^3
	C[5] = ((A.*B)&(2^4)).==2^4
	C[6] = ((A.*B)&(2^5)).==2^5
	
	K = Array(Array,6)
	K[1] = (A.*B).<=2^1
	K[2] = (A.*B).<=2^2
	K[3] = (A.*B).<=2^3
	K[4] = (A.*B).<=2^4
	K[5] = (A.*B).<=2^5
	K[6] = (A.*B).<=2^6
	
	
	
	#We could actually factorize with just those numbers instead of the big maps
	J1_1 = calc_fact_num(1,1)
	J1_2 = calc_fact_num(1,2)
	J1_3 = calc_fact_num(1,3)
	J1_4 = calc_fact_num(1,4)
	J1_5 = calc_fact_num(1,5)
	J1_6 = calc_fact_num(1,6)

	J2_1 = calc_fact_num(2,1)
	J2_2 = calc_fact_num(2,2)
	J2_3 = calc_fact_num(2,3)
	J2_4 = calc_fact_num(2,4)
	J2_5 = calc_fact_num(2,5)
	J2_6 = calc_fact_num(2,6)

	J3_1 = calc_fact_num(3,1)
	J3_2 = calc_fact_num(3,2)
	J3_3 = calc_fact_num(3,3)
	J3_4 = calc_fact_num(3,4)
	J3_5 = calc_fact_num(3,5)
	J3_6 = calc_fact_num(3,6)

	J4_1 = calc_fact_num(4,1)
	J4_2 = calc_fact_num(4,2)
	J4_3 = calc_fact_num(4,3)
	J4_4 = calc_fact_num(4,4)
	J4_5 = calc_fact_num(4,5)
	J4_6 = calc_fact_num(4,6)

	J5_1 = calc_fact_num(5,1)
	J5_2 = calc_fact_num(5,2)
	J5_3 = calc_fact_num(5,3)
	J5_4 = calc_fact_num(5,4)
	J5_5 = calc_fact_num(5,5)
	J5_6 = calc_fact_num(5,6)
	
	KL_3 = calc_kl(K[3])
	KL_4 = calc_kl(K[4])
	KL_5 = calc_kl(K[5])

	# binary 111 -> 7
	v = J1_3 & J2_3 & J3_3
	v = normalize_num(v,KL_3)
	println(reverse(bin(v)))

	println()
	# binary 1001 -> 9
	v = J1_4 & not(J2_4) & not(J3_4) & J4_4
	v = normalize_num(v,KL_4)
	println(reverse(bin(v)))
	
	println()

	println("J1_5:",J1_5)
	println("J2_5:",J2_5)
	println("J3_5:",J3_5)
	println("J4_5:",J4_5)
	println("J5_5:",J5_5)
	println("KL_5:",KL_5)

	println()
	# binary 11000 -> 24
	v = not(J1_5) & not(J2_5) & not(J3_5) & J4_5 & J5_5
	v = normalize_num(v,KL_5)
	println(reverse(bin(v)))

	end
end