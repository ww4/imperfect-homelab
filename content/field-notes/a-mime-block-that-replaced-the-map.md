+++
title = "A MIME block that replaced the map"
weight = 5
+++

A vhost needed one extra MIME type, so its config gained a `types { ... }` block with that one entry. nginx's `types` directive does not add to the inherited map; it replaces it for that context, so every other file served by that vhost went out as `application/octet-stream` and the browser downloaded stylesheets instead of applying them. Add types with `include mime.types;` inside the block, or set the one type with `default_type` for a location. A related trap from the same incident: a regex `location` wins over a prefix `location` regardless of order, which is how a playlist path 404'd while the rule that should have served it sat two lines above.

