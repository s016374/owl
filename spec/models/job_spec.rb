describe Job do
  before(:all) do
    @dgg = User.find_by_email('admin@dgg.io')
    puts @dgg.inspect
  end

  describe '#set_defaults' do
    context 'create new job' do

      it 'should be able to create job with blank title' do
        job = Job.new(title: '', user: @dgg)
        job.save
        expect(job.title).to eq('')
      end

      it 'description equal title and occupation equal QA if blank' do
        job = Job.new(title: 'abc123', user: @dgg)
        job.save
        expect(job.occupation).to eq('QA')
        expect(job.description).to eq(job.title)
      end

      xit 'pending test' do
        # TODO try codeship try travis
      end

    end
  end
end
