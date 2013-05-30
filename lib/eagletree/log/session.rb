module EagleTree
  module Log

    # Represents an individual recording session.
    class Session

      # @return [Fixnum] this sessions number in the data file
      attr_reader :number

      # @return [Array<Fixnum>] range of entries timestamps for this session
      attr_reader :range

      def initialize number, range
        @number = number
        @range = range
      end

    end

  end
end
