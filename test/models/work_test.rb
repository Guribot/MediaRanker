require "test_helper"


describe Work do
  let(:w) { works(:bladerunner) }
  # it "must be valid" do
  #   value(work).must_be :valid?
  # end


  describe 'validations' do
    it "can be created with all validations" do
      w.must_be :valid?
    end

    describe "titles" do
      it "requires a title" do
        w = Work.new

        w.wont_be :valid?
        w.errors.messages.must_include :title
      end

      it "requires unique title" do
        w = Work.new(title:"Blade Runner", category: "movie")

        w.wont_be :valid?
        w.errors.messages.must_include :title
      end

      it "allows for title uniqueness within category" do
        x = Work.new(title:"Blade Runner", category: "book")

        x.must_be :valid?
      end
    end
  end

  describe '#best' do
    it 'returns work with most votes' do
      Work.best.must_equal works(:sower)
    end
  end

  describe '#best_10' do
    it 'returns top 10 works with most votes when there are >10  works' do
      b = Work.best_10('album')

      b.count.must_equal 10
      b.first.must_equal works(:thrill)
    end

    it 'returns as many works as exist when <10 works exist' do
      b = Work.best_10('movie')

      b.count.must_equal 2
      b.first.must_equal w
    end

    it 'returns empty array when category has 0 works' do
      b = Work.best_10('nope')

      b.must_equal []
    end
  end
end
