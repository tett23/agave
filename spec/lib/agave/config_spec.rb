require 'spec_helper'

describe Agave::Config do
  it :server do
    expect(Agave::Config.server).to eq('192.168.1.5')
  end
  it :port do
    expect(Agave::Config.port).to eq(5510)
  end
end

