begin
	function printBitMasks(V)
		E = Array{Int64}(2^6)
		for i in 1:2^6
			E[i] = -1
		end
		i = 1
		for o in V
			contains = false
			for l in E
				if l == o
					contains = true
				end
			end
			if !contains
				E[i] = o
				i += 1
			end
		end
		F = Array{Int64}(i-1)
		for j in 1:(i-1)
			F[j] = E[j]
		end
		F=sort(F)
		for j in 1:(i-1)
			if F[j] != 90000000000
				println(Int64((F[j]-1)/10))
			end
		end
	end
	
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
	
	
	#90000000000 just for proper output
	X = (1+ (A & 1)*10 + (B & 1)*100 + K[1]*2000).*C[1]+90000000000
	Y = (1+ (A & 1)*10 + (B & 1)*100 + K[1]*2000).*(!C[1])+90000000000
	#X = (C[1]*1 + (A & 2)/2*1000 + (B & 2)/2*10000).*C[2]
	#Y = (C[1]*1 + (A & 2)/2*1000 + (B & 2)/2*10000).*(!C[2])
	println("X:")
	println(X)
	println("Y:")
	println(Y)
	
	printBitMasks(X)
	println()
	printBitMasks(Y)

	X = (1+C[1]*10 + (A & 1)*100 + (B & 1)*1000 + ((A & 2).==2)*10000 + ((B & 2).==2)*100000 + K[2]*2000000).*C[2]+90000000000
	Y = (1+C[1]*10 + (A & 1)*100 + (B & 1)*1000 + ((A & 2).==2)*10000 + ((B & 2).==2)*100000 + K[2]*2000000).*(!C[2])+90000000000
	#X = (C[1]*1 + (A & 2)/2*1000 + (B & 2)/2*10000).*C[2]
	#Y = (C[1]*1 + (A & 2)/2*1000 + (B & 2)/2*10000).*(!C[2])
	println("X2:")
	println(X)
	println("Y2:")
	println(Y)
	
	printBitMasks(X)
	println()
	printBitMasks(Y)
	
	
	X = (1+C[1]*10 + C[2]*100 + ((A & 1).==1)*1000 + ((B & 1).==1)*10000 + ((A & 2).==2)*100000 + ((B & 2).==2)*1000000 + ((A & 4).==4)*10000000 + ((B & 4).==4)*100000000 + K[3]*2000000000).*C[3]+90000000000
	Y = (1+C[1]*10 + C[2]*100 + ((A & 1).==1)*1000 + ((B & 1).==1)*10000 + ((A & 2).==2)*100000 + ((B & 2).==2)*1000000 + ((A & 4).==4)*10000000 + ((B & 4).==4)*100000000 + K[3]*2000000000).*(!C[3])+90000000000
	println("X4:")
	println(X)
	println("Y4:")
	println(Y)
	
	printBitMasks(X)
	println()
	printBitMasks(Y)
	
	
end