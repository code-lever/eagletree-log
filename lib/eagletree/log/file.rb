module EagleTree
  module Log

    # Represents a single Eagle Tree data logger file.
    class File

      # Hardware that recorded this file
      attr_reader :hardware

      # Version of the data recorder software
      attr_reader :version

    end

  end
end
