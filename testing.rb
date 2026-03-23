module Testing
  def self.expect(actual, expected)
    @expectations ||= 0
    @failed ||= 0

    @expectations += 1

    if actual != expected
      @failed += 1
      puts "[Failed] Case ##{@expectations}. expected: #{expected}, actual: #{actual}"
    end
  end

  def self.assert(check)
    self.expect(check, true)
  end

  def self.refute(check)
    self.expect(check, false)
  end

  def self.summary
    puts "-------------------------------------------------------------------"
    puts "#{@failed == 0 ? '✅' : '🔴'} [Summary] Passed #{@expectations - @failed}, Failed: #{@failed}, Total: #{@expectations}."
  end
end
