module EagleTree
  module Log

    # Represents an individual recording session.
    class Session

      # @return [Fixnum] this sessions number in the data file
      attr_reader :number

      # @return [Array<Fixnum>] range of entries timestamps for this session
      attr_reader :range

      # @return [Array] rows of raw data from session
      attr_reader :rows

      def initialize number, range
        @number = number
        @range = range
      end

      def rows= rows
        @rows = rows
      end

      # Gets the duration of the flight, in seconds.
      #
      # @return [Float] duration of the flight, in seconds
      def duration
        @duration ||= (range[1] - range[0]) / 1000.0
      end

      def altitudes
        @altitudes ||= int_fields('Altitude')
      end

      def altitudes?
        self.altitudes.any? { |alt| alt > 0.0 }
      end

      def airspeeds
        @airspeeds ||= int_fields('Airspeed')
      end

      def airspeeds?
        self.airspeeds.any? { |as| as > 0.0 }
      end

      def servo_currents
        @servo_currents ||= float_fields('ServoCurrent*100', 100.0)
      end

      def servo_currents?
        self.servo_currents.any? { |c| c > 0.0 }
      end

      def pack_voltages
        @pack_voltages ||= float_fields('PackVolt*100', 100.0)
      end

      def pack_voltages?
        self.pack_voltages.any? { |v| v > 0.0 }
      end

      def throttles
        @throttles ||= int_fields('Throttle')
      end

      def throttles?
        self.throttles.any? { |th| th > 0.0 }
      end

      private

      def int_fields name
        fields(name).map(&:to_i)
      end

      def float_fields name, divisor
        fields(name).map(&:to_f).map { |val| val / divisor }
      end

      def fields name
        @rows.each_with_object(name).map(&:[])
      end

    end

  end
end
