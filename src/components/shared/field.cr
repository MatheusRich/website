# This component is used to make it easier to render the same fields styles
# throughout your app
#
# ## Usage
#
#     mount Shared::Field.new(operation.name) # Renders text input by default
#     mount Shared::Field.new(operation.email), &.email_input(autofocus: "true")
#     mount Shared::Field.new(operation.username), &.email_input(placeholder: "Username")
#     mount Shared::Field.new(operation.name), &.text_input(append_class: "custom-input-class")
#     mount Shared::Field.new(operation.nickname), &.text_input(replace_class: "compact-input")
#
# ## Customization
#
# You can customize this class so that fields render like you expect
# For example, you might wrap it in a div with a "field-wrapper" class.
#
#    div class: "field-wrapper"
#      label_for field
#      yield field
#      mount Shared::FieldErrors.new(field)
#    end
#
# You may also want to have more more classes if you render fields
# differently in different parts of your app, e.g. `Shared::CompactField``
class Shared::Field(T) < BaseComponent
  include Lucky::CatchUnpermittedAttribute
  needs field : Avram::FillableField(T)

  def render
    label_for field

    # You can add more default options here. For example:
    #
    #    with_defaults field: @field, class: "input"
    #
    # Will add the class "input" to the generated HTML.
    with_defaults field: field do |input_builder|
      yield input_builder
    end

    mount Shared::FieldErrors.new(field)
  end

  # Use a text_input by default
  def render
    render &.text_input
  end
end
