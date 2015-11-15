class Pi
  class Pin
    attr:@pin_num
    def initialize(num, mode ="in")
      @pin_num = num
      File.open("/sys/class/gpio/export","w"){|f|
        f.write("#{@pin_num}")
      }

      File.open("/sys/class/gpio/gpio#{pin}/direction","w"){|f|
        f.write(mode)
      } 
      self
    end

    def read
      File.open("/sys/class/gpio/gpio#{pin}/value","r"){|f|
        f.read
      } 
    end

    def write(str)
      File.open("/sys/class/gpio/gpio#{pin}/value","w"){|f|
        f.write(str)
      } 
    end

    def toggle
      File.open("/sys/class/gpio/gpio#{pin}/value","w+"){|f|
        val = f.read.to_i
        f.write("#{1 - val}")
      } 
    end
  end

end
