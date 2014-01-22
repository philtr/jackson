# Jackson

A simple, `iframe`able event RSVP system for your user group.

[![I'll Be There - Jackson 5](http://cl.ly/PdBb)](http://youtu.be/J6pAxF2br_U)

## Usage

Set up an `<iframe>` pointing to `http://jackson.example.com/rsvp` with the following query parameters:

* `event` *(required)* - A unique identifier for your event. Events with the same event identifier but different
  organizations will have different rsvp lists

* `url` - If this option is passed, Jackson assumes you are using an `iframe` and will return the
  browser to this location after the OAuth flow

* `org` - If your event is part of an organization, come up with a unique organization identifier.
  There are not any validation or authorization checks, so I'm sorry if somenoe else has an event
  for your organization.

* `css` - A fully-qualified stylesheet url for your custom styles

