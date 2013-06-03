require 'csv'
require 'open-uri'

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
        @sessions = []

        open(uri, 'rb') do |file|
          @name = file.gets.strip
          @meta = file.gets.strip.split
          session_count = @meta[27].to_i

          if 'All Sessions' != file.gets.strip
            raise RuntimeError, "No 'All Sessions' marker found"
          end

          # empty files are still valid, just have no sessions
          if session_count.zero?
            break
          end

          # read off the full file range
          all_sessions_range = file.gets.strip.split.map(&:to_i)

          session_count.times do |expected|
            num = /Session (?<num>\d)/.match(file.gets)[:num].to_i
            if (expected + 1) != num
              raise RuntimeError, "Unexpected session marker encountered"
            end

            range = file.gets.strip.split.map(&:to_i).map { |v| v * @meta[22].to_i }
            @sessions << Session.new(num, range)
          end

          session_index = 0
          session = @sessions[session_index]
          session_rows = []
          CSV.new(file, { :col_sep => ' ', :headers => true }).each do |csv|
            if !((session.range[0]..(session.range[1]-1)).include? csv[0].to_i)
              session.rows = session_rows
              session_index += 1
              session = @sessions[session_index]
              session_rows = []
            end

            session_rows << csv
          end
          session.rows = session_rows unless session.nil?

        end

        @hardware = @meta[23] # TODO interpret correctly
        @version = @meta[25].to_f

      rescue
        raise ArgumentError, 'File does not appear to be an Eagle Tree log'
      end

    end

  end
end
