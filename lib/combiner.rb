# input:
# - two enumerators returning elements sorted by their key
# - block calculating the key for each element
# - block combining two elements having the same key or a single element, if there is no partner
# output:
# - enumerator for the combined elements
class Combiner
	def initialize(&key_extractor)
		@key_extractor = key_extractor
	end

	def key(value)
		value.nil? ? nil : @key_extractor.call(value)
	end

	# show value of each last_values index 
	def combine(*enumerators)
		Enumerator.new do |yielder|
			last_values = Array.new(enumerators.size)
			done = enumerators.all? { |enumerator| enumerator.nil? }
			while(!done)
				# stop enumeration if don't have any enumerator(break if enumerators[index] = nil)
				last_values.each_with_index do |value, index|
					if value.nil? && !enumerators[index].nil?
						last_values[index] = enumerators[index].next
					break if enumerators[index] = nil
						puts "error"
					end
				end
			end
		end
	end

	#we got a Array without any nil element
	# <=> operatore compare 2 attr and if they includ same data or nil return 0,
	# if right of operator is bigeer return 1 and if is smallest return -1  
	def sorting(lasst_values)
		if last_values.compact.empty?
			min_key = last_values.map { |e| key(e) }.min do
				min_key.sort { |a, b| a <=> b } 
			end
		end
	end

	# return sorted Array
	def sorted(last_values, values)
		values = Array.new(last_values.size)
		last_values.each_with_index do |value, index|
			if key(value) == min_key
				values[index] = value
				last_values[index] = nil
			end
		end
		yielder.yield(values)
	end
end

