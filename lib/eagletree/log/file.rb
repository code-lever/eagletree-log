module EagleTree
  module Log

    # Represents a single Eagle Tree data logger file.
    class File

      # @return [String] Hardware that recorded this file
      attr_reader :hardware

      # @return [String] Name given to the log file
      attr_reader :name

      # @return [Array<Session>] Sessions contained in this file
      attr_reader :sessions

      # @return [FixNum] Version of the data recorder software
      attr_reader :version

      def initialize uri

        open(uri, 'rb') do |file|
          @name = file.gets.chomp
          @meta = file.gets.chomp.split

          if 'All Sessions' != file.gets.chomp
            raise RuntimeError, "No 'All Sessions' marker found"
          end

          all_range = file.gets.chomp.split.map &:to_i

          @sessions = []
          session_count = @meta[21].to_i # XXX constant?
          session_count.times do |expected|
            num = /Session (?<num>\d)/.match(file.gets)[:num].to_i
            if (expected + 1) != num
              raise RuntimeError, "Unexpected session marker encountered"
            end

            range = file.gets.chomp.split.map &:to_i

            @sessions << Session.new(num, range)
          end

          if all_range != [@sessions.first.range[0], @sessions.last.range[1]]
            raise ArgumentError, 'File did not appear to contain all sessions'
          end
        end

      rescue
        raise ArgumentError, 'File does not appear to be an Eagle Tree log'
      end

    end

  end
end
