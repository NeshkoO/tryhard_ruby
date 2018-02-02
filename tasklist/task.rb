class Task
  @@nextid = 0
  attr_accessor :text, :active
  attr_reader :id

  def initialize options
    @id=@@nextid
    @@nextid += 1
    self.text= options[:text]||''
    @active = true
  end

  def text=(text)
    @text = text.capitalize
  end
end