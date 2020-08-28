namespace :affinities do
  desc "Processes all interactions created for a given date and computes the affinities between users"
  task :compute, [:date] => :environment do |_task, args|
    args.with_defaults(:date => Date.today.to_s)
    date_arg = args[:date]

    if date_arg == 'all'
      interaction_dates = Interaction.order(interacted_at: :asc).distinct.pluck(:interacted_at).map(&:to_date)
      interaction_dates.each do |date|
        AffinityBuilderService.for(date).compute
      end
    else
      AffinityBuilderService.for(Date.parse(date_arg)).compute
    end
  end
end
