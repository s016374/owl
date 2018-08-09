describe Job do
  describe '#set_defaults' do
    context 'when user email contains dgg' do
      it 'should be able to create job with blank title' do
        dgg = User.find_by_email('admin@dgg.io')
        job = Job.new(title: '', user: dgg)
        job.save
        # expect(job).to exist
      end
    end
  end
end
