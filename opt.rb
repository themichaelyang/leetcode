require 'benchmark'

word1 = "a" * 1000
word2 = "b" * 500
i = 500
n = 100_000

Benchmark.bm(15) do |x|
  x.report("slice") do
    n.times do
      output = ""
      output << word1[i..]
      output << word2[i..]
    end
  end

  x.report("char-by-char") do
    n.times do
      output = ""
      j = i
      while j < word1.length
        output << word1[j]
        j += 1
      end
      j = i
      while j < word2.length
        output << word2[j]
        j += 1
      end
    end
  end
end
