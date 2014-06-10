require 'romanesco'

describe '#to_s' do

  it 'should print it out' do
    expression = "(3)"

    tree = parse(expression)

    tree.to_s.should == "(3.0)"
  end

  it 'should print it out' do
    expression = "(3+4)"

    tree = parse(expression)

    tree.to_s.should ==  "(3.0 + 4.0)"
  end

  it 'should print it out' do
    expression = "2"

    tree = parse(expression)

    tree.to_s.should == "2.0"
  end

  it 'should print it out' do
    expression = "2*3+4"

    tree = parse(expression)

    tree.to_s.should ==  "2.0 * 3.0 + 4.0"
  end

  it 'should print it out' do
    expression = "2*(3+4)"

    tree = parse(expression)

    tree.to_s.should ==  "2.0 * (3.0 + 4.0)"
  end

  it 'should print it out' do
    expression = '(1+10)*3'

    tree = parse(expression)

    tree.to_s.should == '(1.0 + 10.0) * 3.0'
  end

end

def parse(exp)
  Romanesco.parse(exp)
end