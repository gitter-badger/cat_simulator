module CatSimulator
  class Cat < Chingu::GameObject
    traits :velocity, :collision_detection, :bounding_box

    def setup
      @animations = {
        idle: Chingu::Animation.new(file: "cat_idle.png", height: 30, width: 30),
        walk: Chingu::Animation.new(file: "cat_walk.png", height: 30, width: 30)
      }

      @state = :idle

      self.input = {
        holding_left: :move_left,
        holding_right: :move_right,
        released_left: :stop_moving_left,
        released_right: :stop_moving_right
      }

      self.acceleration_y = 0.1
    end

    def move_left
      @state = :walk_left
      @x -= 1
      @factor_x = -1
    end

    def move_right
      @state = :walk_right
      @x += 1
      @factor_x = 1
    end

    def stop_moving_left
      @state = :idle if @state == :walk_left
    end

    def stop_moving_right
      @state = :idle if @state == :walk_right
    end

    def update
      @image = animation.next
    end

    def encounter_platform(platform)
      @y = previous_y
      stop
    end

    def animation
      case @state
      when :idle
        @animations[:idle]
      when :walk_left, :walk_right
        @animations[:walk]
      end
    end
  end
end
