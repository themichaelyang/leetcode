module TestSuite
  def assert_equals(actual, expected)
    @assert_cases ||= 0
    @assert_cases_passed ||= 0

    @assert_cases += 1
    if self.respond_to? :name
      puts "TEST SUITE: #{self.name}"
    end
    puts "ASSERTION #{@assert_cases}"

    if actual != expected
      puts "> ❌ found: #{actual}, expected: #{expected}"
    else
      puts "> ✅ passed!"
      @assert_cases_passed += 1
    end

    puts
  end
end
