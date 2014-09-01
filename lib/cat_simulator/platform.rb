module CatSimulator
  class Platform < Chingu::GameObject
    traits :collision_detection, :bounding_box

    def setup
      @image = Image['platform/grass_middle.png']
      @x = 100
      @y = $window.height - (@image.height / 2)
    end
  end
end
