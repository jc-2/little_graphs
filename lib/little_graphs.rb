require 'quick_magick'

class LittleGraphs
  attr_accessor :width, :height

  def initialize(width = 100, height = 35)
    @width = width
    @height = height
  end

  def draw(datapoints, filename = nil)
    coordinates = define_coordinates(datapoints)

    f = QuickMagick::Image::solid(@width, @height, :white)
    f.draw_polyline(coordinates, :fill => :white, :stroke => :blue)

    if filename.nil?
      f.to_blob
    else
      f.save(filename)
    end
  end

  def define_coordinates(datapoints)
    margin = 5
    point_space = @width/datapoints.length
    translated_datapoints = translate_datapoints(datapoints)
    coordinates = []

    translated_datapoints.each_with_index do |datapoint, i|
      coordinates.push [i*point_space+margin, datapoint + 1]
    end
    coordinates.flatten
  end

  def translate_domain(datapoints)
    point_space = @width/datapoints.length
  end

  def translate_datapoints(datapoints)
    point_space = @height/(datapoints.max - datapoints.min)

    datapoints.map do |datapoint|
      @height - (datapoint - datapoints.min) * point_space
    end
  end

end
