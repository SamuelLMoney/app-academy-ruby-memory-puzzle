require "byebug"

class Array
  def sample!
    # byebug
    ele = self.sample
    self.delete_at(self.index(ele))
    ele
  end
end
