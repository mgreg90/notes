#!/usr/bin/env ruby

require 'bundler/inline'
gemfile do
  source 'https://rubygems.org'
  gem 'playwright-cli', require: 'playwright/cli'
  gem 'git', '~> 1.3'
  gem 'pry-nav'
end

require 'fileutils'

module Notes
  module CLI
    module Commands
      extend Playwright::CLI::Registry

      class Root < Playwright::CLI::Command
        desc "Opens your notes file."

        NOTES_FILE_NAME_ROOT = '.notes'
        GITIGNORE_FILE_NAME = '.gitignore'
        GITIGNORE_LINE = '.notes*'

        def call(**)
          create_notes_file unless notes_file.file?
          add_to_gitignore
          open_notes_file
        end

        def git
          @git ||= Git.open(Dir.pwd) if Dir.exists?(File.join(Dir.pwd, '.git'))
        end

        def git?
          !!git
        end

        def notes_file
          @notes_file ||= Pathname.new(File.join(Dir.pwd, notes_filename))
        end

        def notes_filename
          "#{NOTES_FILE_NAME_ROOT}-#{git.branch if git?}"
        end

        def gitignore_file
          @gitignore_file ||= Pathname.new(File.join(Dir.pwd, GITIGNORE_FILE_NAME))
        end

        def create_notes_file
          FileUtils.touch(notes_file)
          notes_file.write("#{git.branch.name}\n\n")
        end

        def open_notes_file
          os.open_editor path: notes_file
        end

        def add_to_gitignore
          if add_to_gitignore?
            gitignore_file.open('a') do |f|
              f << "\n#{GITIGNORE_LINE}\n"
            end
          end
        end

        def add_to_gitignore?
          gitignore_file.file? &&
            !gitignore_file.readlines.map(&:chomp).include?(GITIGNORE_LINE)
        end

      end

      register_root Root

    end
  end
end

Playwright::CLI.new(Notes::CLI::Commands).call