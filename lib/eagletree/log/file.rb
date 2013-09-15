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

      # Determines if the file at the given URI is a EagleTree log file.
      #
      # @param uri URI to file to read
      # @return [EagleTree::Log::File] loaded file if the file is an Eagle Tree log file, nil otherwise
      def self.eagle_tree? uri
        File.new(uri) rescue nil
      end

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

      # Gets the total duration of all sessions contained within.
      #
      # @return [Float] total duration of all sessions, in seconds
      def duration
        @sessions.map(&:duration).reduce(&:+)
      end

      # Determines if KML methods can be called for this file.
      #
      # @return [Boolean] true if KML can be generated for this file, false otherwise
      def to_kml?
        @sessions.any?(&:to_kml?)
      end

      # Converts the file into a KML document containing placemarks for each
      # session containing GPS data.
      #
      # @param options [Hash] hash containing options for file
      # @return [String] KML document for all applicable sessions in the file
      # @see #to_kml_file file options
      def to_kml(options = {})
        raise RuntimeError, 'No coordinates available for KML generation' unless to_kml?
        to_kml_file(options).render
      end

      # Converts the file into a KMLFile containing placemarks for each session containing
      # GPS data.
      #
      # @param options [Hash] hash containing options for file
      # @option options [String] :name name option of KML::Document
      # @option options [String] :description name option of KML::Document
      # @return [KMLFile] file for the session
      def to_kml_file(options = {})
        raise RuntimeError, 'No coordinates available for KML generation' unless to_kml?
        options = apply_default_file_options(options)

        style = 'kmlfile-style-id'
        kml_sessions = @sessions.select(&:to_kml?)
        marks = kml_sessions.each_with_object({ :style_url => "##{style}" }).map(&:to_kml_placemark)

        kml = KMLFile.new
        kml.objects << KML::Document.new(
          :name => options[:name],
          :description => options[:description],
          :styles => [
            KML::Style.new(
              :id => style,
              :line_style => KML::LineStyle.new(:color => '7F00FFFF', :width => 4),
              :poly_style => KML::PolyStyle.new(:color => '7F00FF00')
            )
          ],
          :features => marks
        )
        kml
      end

      private

      def apply_default_file_options options
        options = { :name => 'Eagle Tree GPS Path' }.merge(options)
        options = { :description => 'Session paths for GPS log data' }.merge(options)
        options
      end

    end

  end
end
