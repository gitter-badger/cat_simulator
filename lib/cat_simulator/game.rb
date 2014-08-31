module CatSimulator
  class Game < Chingu::Window
    def initialize
      super
      self.input = {escape: :exit}
      @player = Cat.create(x: 100, y: 400)
    end
  end
end
