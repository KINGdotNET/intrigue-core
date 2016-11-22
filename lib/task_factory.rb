###
### Task factory: Standardize the creation and validation of tasks
###
module Intrigue
class TaskFactory

  def self.register(klass)
    @tasks = [] unless @tasks
    @tasks << klass
  end

  def self.list
    available_tasks
  end

  def self.allowed_tasks_for_entity_type(entity_type)
    available_tasks.select {|task_class| task_class if task_class.metadata[:allowed_types].include? entity_type}
  end
  #
  # XXX - can :name be set on the class vs the object
  # to prevent the need to call "new" ?
  #
  def self.include?(name)
    available_tasks.each do |t|
      if (t.metadata[:name] == name)
        return true
      end
    end
  false
  end

  #
  # XXX - can :name be set on the class vs the object
  # to prevent the need to call "new" ?
  #
  def self.create_by_name(name)
    available_tasks.each do |t|
      if (t.metadata[:name] == name)
        return t.new # Create a new object and send it back
      end
    end

    ### XXX - exception handling? Should this return nil?
    raise "No task by that name!"
  end

  #
  # XXX - can :name be set on the class vs the object
  # to prevent the need to call "new" ?
  #
  def self.create_by_pretty_name(pretty_name)
    available_tasks.each do |t|
      if (t.metadata[:pretty_name] == pretty_name)
        return t.new # Create a new object and send it back
      end
    end

    ### XXX - exception handling? Should this return nil?
    raise "No task by that name!"
  end

  private

  def self.available_tasks
    @tasks
  end

end
end
