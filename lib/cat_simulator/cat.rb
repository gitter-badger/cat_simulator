module CatSimulator
  class Cat < Chingu::GameObject
    def initialize(options = {})
      options.update(:image => Gosu::Image["cat.png"])
      super(options)
      self.input = {holding_left: :move_left, holding_right: :move_right}
    end

    def move_left
      @x -= 1
    end

    def move_right
      @x += 1
    end
  end
end
