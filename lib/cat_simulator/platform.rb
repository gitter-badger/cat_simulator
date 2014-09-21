module CatSimulator
  class Platform < Chingu::GameObject
    traits :collision_detection, :bounding_box

    def setup
      @image = Image['platform/grass_middle.png']
    end
  end
end
