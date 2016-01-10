begin
	SIZE=16
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
	
	function custom_factorize(p)
		L = 1
		W = trues(SIZE,SIZE)
		while 2^L <= SIZE
			W = K[L]
			L += 1
		end

		N = [2^x for x=[0:L]]
		I = 0
		for s in N
			I += 1
			if (p & s) != 0
				W &= C[I]
			else
				W &= !C[I]
			end
		end
		#*1 for smaller output
		return W*1
	end
	custom_factorize(12)
end