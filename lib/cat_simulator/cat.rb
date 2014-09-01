module CatSimulator
  class Cat < Chingu::GameObject
    def initialize(options = {})
      super(options)
      @animations = {
        idle: Chingu::Animation.new(file: "cat_idle.png", height: 64, width: 64),
        walk: Chingu::Animation.new(file: "cat_walk.png", height: 64, width: 64)
      }

      @state = :idle

      self.input = {
        holding_left: :move_left,
        holding_right: :move_right,
        released_left: :stop_moving_left,
        released_right: :stop_moving_right
      }
    end

    def move_left
      @state = :walk_left
      @x -= 1
    end

    def move_right
      @state = :walk_right
      @x += 1
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
