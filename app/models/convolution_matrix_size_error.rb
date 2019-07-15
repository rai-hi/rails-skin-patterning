# frozen_string_literal: true

class ConvolutionMatrixSizeError < StandardError
  def initialize(msg = 'Convolution matrixes must have an odd width and height')
    super
  end
end
