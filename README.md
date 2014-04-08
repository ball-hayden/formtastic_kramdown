Formtastic Markdown
===================

This gem is licensed under the 3-Clause BSD License.

Installation
============

Add to gemfile:

`gem 'formtastic_kramdown', github: 'ball-hayden/formtastic_kramdown`

Add CSS:

```
// application.css

@import "formtastic_kramdown";
```

Add Coffee:

```
# application.js

#= require formtastic_kramdown
```

Mount the preview:

```
mount FormtasticKramdown::Engine, at: '/'
```

