require 'romanesco/validators/character_validator'

describe Romanesco::Validators::CharacterValidator do

  subject       { Romanesco::Validators::CharacterValidator.new }
  let(:error)   { Romanesco::InvalidExpressionError }

  context 'if the expression contains all valid characters' do

    it 'should not raise an error' do
      subject.validate('sample string')
    end

    it 'should not raise an error' do
      subject.validate('((((()))))')
    end

    it 'should not raise an error' do
      subject.validate('1234567890')
    end

    it 'should not raise an error' do
      subject.validate('*')
    end

    it 'should not raise an error' do
      subject.validate('+')
    end

    it 'should not raise an error' do
      subject.validate('/')
    end

    it 'should not raise an error' do
      subject.validate('-')
    end

  end

  context 'if the expression is blank' do

    it 'should raise an error' do
      expect { subject.validate(nil) }.to raise_error
    end

    it 'should raise an error' do
      expect { subject.validate('') }.to raise_error
    end

    it 'should raise an error' do
      expect { subject.validate(' ') }.to raise_error
    end

    it 'should raise an error' do
      expect { subject.validate("\t") }.to raise_error
    end

    it 'should raise an error' do
      expect { subject.validate("\n") }.to raise_error
    end

  end

  context 'if the expression has any invalid characters' do

    it 'should raise an error' do
      expect { subject.validate(nil) }.to raise_error
    end

    it 'should raise an error' do
      expect { subject.validate('$') }.to raise_error
    end

    it 'should raise an error' do
      expect { subject.validate('          =') }.to raise_error
    end

    it 'should raise an error' do
      expect { subject.validate('#') }.to raise_error
    end

  end


end