require 'spec_helper'
describe 'multigpu' do

  context 'with defaults for all parameters' do
    it { should contain_class('multigpu') }
  end
end
