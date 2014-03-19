require 'spec_helper'

describe Agave::API do
  describe :reserve do
    it 'first page' do
      Agave::API.reserve
    end

    it 'all items' do
      Agave::API.reserve(Agave::API.reserve_page_count)
    end
  end

  it :reserve_page_count do
    Agave::API.reserve_page_count
  end

end

