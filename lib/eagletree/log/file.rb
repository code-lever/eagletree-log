require 'csv'

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

          all_range = file.gets.chomp.split.map(&:to_i).map { |v| v * @meta[22].to_i }

          @sessions = []
          session_count = @meta[27].to_i

          # empty files are still valid, just have no sessions
          if session_count.zero?
            break
          end

          session_count.times do |expected|
            num = /Session (?<num>\d)/.match(file.gets)[:num].to_i
            if (expected + 1) != num
              raise RuntimeError, "Unexpected session marker encountered"
            end

            range = file.gets.chomp.split.map(&:to_i).map { |v| v * @meta[22].to_i }
            @sessions << Session.new(num, range)
          end

          if all_range != [@sessions.first.range[0], @sessions.last.range[1]]
            raise RuntimeError, 'File did not appear to contain all sessions'
          end

          session_index = 0
          session = @sessions[session_index]
          session_rows = []
          CSV.new(file, { :col_sep => ' ', :headers => true }).each do |csv|
            if !((session.range[0]..session.range[1]).include? csv[0].to_i)
              session.rows = session_rows
              session_index += 1
              session = @sessions[session_index]
              session_rows = []
            end

            session_rows << csv
          end
          session.rows = session_rows

        end

        @hardware = @meta[23] # TODO interpret correctly
        @version = @meta[25].to_f

      rescue
        raise ArgumentError, 'File does not appear to be an Eagle Tree log'
      end

    end

  end
end
