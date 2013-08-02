require 'ruby_kml'

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

      # Gets the duration of the session, in seconds.
      #
      # @return [Float] duration of the session, in seconds
      def duration
        @duration ||= (range[1] - range[0]) / 1000.0
      end

      def milliseconds
        @altitudes ||= int_fields('Milliseconds')
      end

      def milliseconds?
        nonzero?(self.milliseconds)
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
        @coords ||= longitudes.zip(latitudes, gps_altitudes)
      end

      def coords?
        self.longitudes? || self.latitudes? || self.gps_altitudes?
      end

      # Determines if KML methods can be called for this session.
      #
      # @return [Boolean] true if KML can be generated for this session, false otherwise
      def to_kml?
        coords?
      end

      # Converts the session into a KML document containing a placemark.
      #
      # @param file_options [Hash] hash containing options for file
      # @param placemark_options [Hash] hash containing options for placemark
      # @return [String] KML document for the session
      # @see #to_kml_file file options
      # @see #to_kml_placemark placemark options
      def to_kml(file_options = {}, placemark_options = {})
        raise RuntimeError, 'No coordinates available for KML generation' unless to_kml?
        to_kml_file(file_options, placemark_options).render
      end

      # Converts the session into a KMLFile containing a placemark.
      #
      # @param file_options [Hash] hash containing options for file
      # @option file_options [String] :name name option of KML::Document
      # @option file_options [String] :description name option of KML::Document
      # @option file_options [String] :style_id id option of KML::Style
      # @param placemark_options [Hash] hash containing options for placemark
      # @return [KMLFile] file for the session
      # @see #to_kml_placemark placemark options
      def to_kml_file(file_options = {}, placemark_options = {})
        raise RuntimeError, 'No coordinates available for KML generation' unless to_kml?
        options = apply_default_file_options(file_options)

        kml = KMLFile.new
        kml.objects << KML::Document.new(
          :name => options[:name],
          :description => options[:description],
          :styles => [
            KML::Style.new(
              :id => options[:style_id],
              :line_style => KML::LineStyle.new(:color => '7F00FFFF', :width => 4),
              :poly_style => KML::PolyStyle.new(:color => '7F00FF00')
            )
          ],
          :features => [ to_kml_placemark(placemark_options) ]
        )
        kml
      end

      # Converts the session into a KML::Placemark containing GPS coordinates.
      #
      # @param options [Hash] hash containing options for placemark
      # @option options [String] :altitude_mode altitude_mode option of KML::LineString
      # @option options [Boolean] :extrude extrude option of KML::LineString
      # @option options [String] :name name option of KML::Placemark
      # @option options [String] :style_url style_url option of KML::Placemark
      # @option options [Boolean] :tessellate tessellate option of KML::LineString
      # @return [KML::Placemark] placemark for the session
      def to_kml_placemark(options = {})
        raise RuntimeError, 'No coordinates available for KML generation' unless to_kml?
        options = apply_default_placemark_options(options)

        KML::Placemark.new(
          :name => options[:name],
          :style_url => options[:style_url],
          :geometry => KML::LineString.new(
            :altitude_mode => options[:altitude_mode],
            :extrude => options[:extrude],
            :tessellate => options[:tessellate],
            :coordinates => coords.map { |c| c.join(',') }.join(' ')
          )
        )
      end

      private

      def apply_default_file_options options
        options = { :name => 'Eagle Tree GPS Path' }.merge(options)
        options = { :description => 'Session paths for GPS log data' }.merge(options)
        options = { :style_id => 'default-poly-style' }.merge(options)
        options
      end

      def apply_default_placemark_options options
        options = { :altitude_mode => 'absolute' }.merge(options)
        options = { :extrude => true }.merge(options)
        options = { :name => "Session (#{duration.round(1)}s)" }.merge(options)
        options = { :style_url => '#default-poly-style' }.merge(options)
        options = { :tessellate => true }.merge(options)
        options
      end

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
