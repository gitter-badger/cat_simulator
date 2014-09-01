module CatSimulator
  class Cat < Chingu::GameObject
    traits :velocity, :collision_detection, :bounding_box, :timer

    def setup
      @animations = {
        idle: Chingu::Animation.new(file: "cat_idle.png", height: 32, width: 32),
        walk: Chingu::Animation.new(file: "cat_walk.png", height: 32, width: 32),
        jump: Chingu::Animation.new(file: "cat_jump.png", height: 32, width: 32)
      }

      @animations[:jump].frame_names = {
        start: 0..1, fly: 2..3, land: 4..7
      }

      @animations[:jump][:fly].loop = true

      @state = :idle

      self.input = {
        holding_left: :move_left,
        holding_right: :move_right,
        released_left: :stop_moving_left,
        released_right: :stop_moving_right,
        space: :jump
      }

      self.acceleration_y = 0.1
    end

    def move_left
      @state = :walk_left unless @state == :jump
      @x -= 1
      @factor_x = -1
    end

    def move_right
      @state = :walk_right unless @state == :jump
      @x += 1
      @factor_x = 1
    end

    def stop_moving_left
      @state = :idle if @state == :walk_left
    end

    def stop_moving_right
      @state = :idle if @state == :walk_right
    end

    def jump
      unless [:jump, :fly].include?(@state)
        stop_timer(:land)
        stop_timer(:fly)
        @state = :jump
        self.velocity_y = -2.5
        after(200, name: :fly) { @state = :fly }
      end
    end

    def update
      @image = animation.next
    end

    def encounter_platform(platform)
      if velocity_y > 0.1
        @state = :land
        after(400, name: :land) { @state = :idle }
      end
      @y = previous_y
      stop
    end

    def animation
      case @state
      when :idle
        @animations[:idle]
      when :walk_left, :walk_right
        @animations[:walk]
      when :jump
        @animations[:jump][:start]
      when :fly
        @animations[:jump][:fly]
      when :land
        @animations[:jump][:land]
      end
    end
  end
end
