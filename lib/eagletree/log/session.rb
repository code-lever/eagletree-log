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

    end

  end
end
