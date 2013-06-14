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
        nonzero?(self.altitudes)
      end

      def airspeeds
        @airspeeds ||= int_fields('Airspeed')
      end

      def airspeeds?
        nonzero?(self.airspeeds)
      end

      def servo_currents
        @servo_currents ||= float_fields('ServoCurrent*100').map { |val| val / 100.0 }
      end

      def servo_currents?
        nonzero?(self.servo_currents)
      end

      def throttles
        @throttles ||= int_fields('Throttle')
      end

      def throttles?
        nonzero?(self.throttles)
      end

      def pack_voltages
        @pack_voltages ||= float_fields('PackVolt*100').map { |val| val / 100.0 }
      end

      def pack_voltages?
        nonzero?(self.pack_voltages)
      end

      def amps
        @amps ||= float_fields('Amps*100').map { |val| val / 100.0 }
      end

      def amps?
        nonzero?(self.amps)
      end

      def temps1
        @temps1 ||= float_fields('Temp1*10').map { |val| val / 10.0 }
      end

      def temps1?
        nonzero?(self.temps1)
      end

      def temps2
        @temps2 ||= float_fields('Temp2*10').map { |val| val / 10.0 }
      end

      def temps2?
        nonzero?(self.temps2)
      end

      def temps3
        @temps3 ||= float_fields('Temp3*10').map { |val| val / 10.0 }
      end

      def temps3?
        nonzero?(self.temps3)
      end

      def rpms
        @rpms ||= int_fields('RPM')
      end

      def rpms?
        nonzero?(self.rpms)
      end

      def rpms2
        @rpms2 ||= int_fields('RPM2')
      end

      def rpms2?
        nonzero?(self.rpms2)
      end

      def latitudes
        @latitudes ||= float_fields('GPSLat')
      end

      def latitudes?
        nonzero?(self.latitudes)
      end

      def longitudes
        @longitudes ||= float_fields('GPSLon')
      end

      def longitudes?
        nonzero?(self.longitudes)
      end

      def gps_altitudes
        @gps_altitudes ||= float_fields('GPSAlt')
      end

      def gps_altitudes?
        nonzero?(self.gps_altitudes)
      end

      def coords
        @coords ||= latitudes.zip(longitudes, gps_altitudes)
      end

      def coords?
        self.latitudes? || self.longitudes? || self.gps_altitudes?
      end

      def to_kml

      end

      private

      def nonzero? array
        !array.all?(&:zero?)
      end

      def int_fields name
        fields(name).map(&:to_i)
      end

      def float_fields name
        fields(name).map(&:to_f)
      end

      def fields name
        @rows.each_with_object(name).map(&:[])
      end

    end

  end
end
