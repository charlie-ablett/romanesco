require 'romanesco/validators/parenthesis_count_validator'

describe Romanesco::Validators::ParenthesisCountValidator do

  subject       { Romanesco::Validators::ParenthesisCountValidator.new }
  let(:error)   { Romanesco::InvalidExpressionError }

  context 'if the expression contains the same number of open and closing parentheses' do

    it 'should not raise an error' do
      subject.validate('()')
    end

    it 'should not raise an error' do
      subject.validate('((((())bork)))')
    end

    it 'should not raise an error' do
      subject.validate('giraffe')
    end

    it 'should not raise an error' do
      subject.validate('(piccolo)(piccolo)(piccolo)piccolo()')
    end

    it 'should not raise an error' do
      subject.validate('1(2(3)4)5(6(7)8)9')
    end

  end

  context 'if the expression has an uneven number' do

    it 'should raise an error' do
      expect { subject.validate('(') }.to raise_error
    end

    it 'should raise an error' do
      expect { subject.validate('((') }.to raise_error
    end

    it 'should raise an error' do
      expect { subject.validate(')') }.to raise_error
    end

    it 'should raise an error' do
      expect { subject.validate('))))))))))') }.to raise_error
    end

    it 'should raise an error' do
      expect { subject.validate('((())))') }.to raise_error
    end

  end

end