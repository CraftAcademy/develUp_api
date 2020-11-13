# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  DEFAULT_SKILLS = ["Javascript",
                    "Ruby",
                    "HTML-CSS",
                    "Node JS",
                    "React",
                    "Angular",
                    "React Native",
                    "Fullstack"]

  validates_intersection_of :skills, in: DEFAULT_SKILLS, message: "Invalid skill"

  validates_presence_of :company_name, :company_url, if: :client?
  validates_presence_of :name, :skills, :level, :points, :completed_projects, if: :develuper?
  validates_presence_of :name, :skills, :level, :points, :completed_projects, if: :registered?
  
  validates_presence_of :role

  enum role: [:registered, :client, :develuper]
  has_many :assignments, foreign_key: "client_id", class_name: "Assignment"

  private

  def develuper?
    role == "develuper"
  end

  def client?
    role == "client"
  end
  def registered?
    role == "registered"
  end
end
