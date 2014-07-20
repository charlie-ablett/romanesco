require 'romanesco/tokeniser'

describe Romanesco::Tokeniser do

  subject                 { Romanesco::Tokeniser.new }

  let(:constant)          { Romanesco::ConstantToken }
  let(:open_parenthesis)  { Romanesco::OpenParenthesisToken }
  let(:close_parenthesis) { Romanesco::CloseParenthesisToken }
  let(:variable)          { Romanesco::VariableToken }
  let(:addition)          { Romanesco::AdditionToken }
  let(:subtraction)       { Romanesco::SubtractionToken }
  let(:multiplication)    { Romanesco::MultiplicationToken }
  let(:division)          { Romanesco::DivisionToken }

  describe '#tokenise' do

    context 'for a valid expression' do

      it 'should tokenise properly' do
        tokens = subject.tokenise('x+y/z')

        tokens.size.should == 5
        tokens[0].class.should == variable
        tokens[1].class.should == addition
        tokens[2].class.should == variable
        tokens[3].class.should == division
        tokens[4].class.should == variable
      end

      it 'should tokenise properly' do
        tokens = subject.tokenise('x*y-z')

        tokens.size.should == 5
        tokens[0].class.should == variable
        tokens[1].class.should == multiplication
        tokens[2].class.should == variable
        tokens[3].class.should == subtraction
        tokens[4].class.should == variable
      end

      it 'should tokenise properly' do
        tokens = subject.tokenise('(x)')

        tokens.size.should == 3
        tokens[0].class.should == open_parenthesis
        tokens[1].class.should == variable
        tokens[2].class.should == close_parenthesis
      end

      it 'should tokenise properly' do
        tokens = subject.tokenise('3+3.3333333')

        tokens.size.should == 3
        tokens[0].class.should == constant
        tokens[1].class.should == addition
        tokens[2].class.should == constant
      end

      it 'should tokenise properly' do
        tokens = subject.tokenise('.3*4.44444444')

        tokens.size.should == 3
        tokens[0].class.should == constant
        tokens[1].class.should == multiplication
        tokens[2].class.should == constant
      end

      it 'should tokenise properly' do
        tokens = subject.tokenise('0.3/4.44444444')

        tokens.size.should == 3
        tokens[0].class.should == constant
        tokens[1].class.should == division
        tokens[2].class.should == constant
      end

      it 'should tokenise properly' do
        tokens = subject.tokenise('(3+5)*giraffe')

        tokens.size.should == 7
        tokens[0].class.should == open_parenthesis
        tokens[1].class.should == constant
        tokens[2].class.should == addition
        tokens[3].class.should == constant
        tokens[4].class.should == close_parenthesis
        tokens[5].class.should == multiplication
        tokens[6].class.should == variable
      end
    end

    context 'for an invalid expression' do

      it 'should raise an error due to having incorrect expression' do
        expect { subject.tokenise("a b") }.to raise_error
      end

      it 'should throw an error for an invalid character' do
        expect{ subject.tokenise('$') }.to raise_error
      end

      it 'should throw an error for a single period not attached to a number' do
        expect{ subject.tokenise('THIS.IS.SPARTA') }.to raise_error
      end

      it 'should throw an error for a decimal point after a number' do
        expect{ subject.tokenise('3.') }.to raise_error
      end

    end

  end


end