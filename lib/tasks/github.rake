namespace :github do
  desc "TODO"
  task :poll, [:repo] => :environment do |_task, args|
    args.with_defaults(:repo => 'rails/rails')

    # Clear Interactions and Affinities to start from a clean state
    Interaction.all.destroy_all
    Affinity.all.destroy_all

    # Create all interactions out of the repository
    GithubPollingService.new(args[:repo]).poll_interactions

    # Generate the affinities between users
    Rake::Task['affinities:compute'].invoke('all')
  end

end
