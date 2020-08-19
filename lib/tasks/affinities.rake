namespace :affinities do
  desc "Processes all interactions created for a given date and computes the affinities between users"
  task :compute, [:date] => :environment do |_task, args|
    args.with_defaults(:date => Date.today.to_s)
    date = Date.parse(args[:date])
    AffinityBuilderService.for(date).compute
  end
end
