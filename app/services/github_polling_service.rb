class GithubPollingService
  attr_reader :repository

  def initialize(repository)
    @repository = repository
  end

  def poll_interactions
    process_pull_request_comments(fetch_pull_requests)
    puts 'Bye!'
  end

private

  def client
    # In production, we wouldn't put these credentials here.
    # They would be stored in a config yaml file or in the environment variables of the server.
    Octokit::Client.new(:login => 'ghshoutout', :password => 'gocleary2020').tap { |cli|
      cli.auto_paginate = true
    }
  end

  def pull_request_comment_type
    @pull_request_comment_type ||= InteractionType.where(name: 'PullRequestComment').first
  end

  # Fetches *OPEN* pull requests
  def pull_requests
    client.pull_requests(repository)
  end

  def comments_in(pull_request)
    client.issue_comments repository, pull_request[:number]
  end

  def fetch_pull_requests
    spinner = TTY::Spinner.new("[:spinner] Fetching pull requests ...", format: :pulse_2)
    spinner.auto_spin
    pull_requests.tap {
      spinner.stop('Done!')
    }
  end

  def process_pull_request_comments(pulls)
    puts 'Processing pull request comments ...'
    bar = RakeProgressbar.new(pulls.count)
    pulls.each { |pull|
      pull_owner = pull[:user][:login]

      comments_in(pull).each { |comment|
        comment_owner = comment[:user][:login]

        # Avoid creating interactions out of comments that were made by the pull request creator
        if pull_owner != comment_owner
          Interaction.create(source_user: comment_owner, target_user: pull_owner, interacted_at: comment[:created_at], interaction_type: pull_request_comment_type)
        end
      }
      bar.inc
    }
    bar.finished
    puts 'Done!'
  end

end