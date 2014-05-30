require 'romanesco/errors'

describe Romanesco::ExpressionTree do

  describe '#required_variables' do
    expression = Romanesco::Romanesco.parse('(lions + tigers) * bears')

    expression.required_variables.should == [:lions, :tigers, :bears]
  end

end

