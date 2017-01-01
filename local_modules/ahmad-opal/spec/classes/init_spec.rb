require 'spec_helper'
describe 'opal' do

  context 'with defaults for all parameters' do
    it { should contain_class('opal') }
  end
end
