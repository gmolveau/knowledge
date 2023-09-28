# Logging

Descriptive / Contextual / Reactive - Actionable

> If I read this log, what should I understand ?

Log events, should be like a story : start of the operation, relevant things and the conclusion (good or bad)

CRITICAL level = wake up someone at 3am
DEBUG level in prod

use JSON format, use the same json structure (fields) across services

use different handlers

the verbose flag can simply change the level of the handler to `DEBUG`

add a unique_request_id to easily follow HTTP requests

Separate parameters (variables) from the message (human written)

Every log line in the system MUST be 100% unique

Never Use Log Statements in a Loop

Don't Log Lists or Arrays

Don't log Method Entry/Exit

Be aware of privacy (remove or anonymize user data) and security risks (sanitize user input before log)

## Opinionated solution

1. The 'Happy' path through your webapp (2xx response) shouldn't have any logging on it. The only things you care about here are how often it was hit and how long it took to serve a response.
2. Only log errors, put metrics on the rest
3. Your logging code should live in one place at the edge of your webapp, ideally as a middleware that kicks in just before an error response is returned to the user. You're now free from bloating up your method signatures / structs with loggers.
4. Context

- Timestamp
- Microservice Name
- URL requested
- Information about exactly where in The Cloud the request hit
- Some way of identifying the user
- Any relevant HTTP headers / body

5. add a unique-request-id to user-facing services and pass it internally


## Log Levels

- [StackOverflow](https://stackoverflow.com/a/8021604)
    - error: the system is in distress, customers are probably being affected (or will soon be) and the fix probably requires human intervention. The "2AM rule" applies here- if you're on call, do you want to be woken up at 2AM if this condition happens? If yes, then log it as "error".
    - warn: an unexpected technical or business event happened, customers may be affected, but probably no immediate human intervention is required. On call people won't be called immediately, but support personnel will want to review these issues asap to understand what the impact is. Basically any issue that needs to be tracked but may not require immediate intervention.
    - info: things we want to see at high volume in case we need to forensically analyze an issue. System lifecycle events (system start, stop) go here. "Session" lifecycle events (login, logout, etc.) go here. Significant boundary events should be considered as well (e.g. database calls, remote API calls). Typical business exceptions can go here (e.g. login failed due to bad credentials). Any other event you think you'll need to see in production at high volume goes here. 
    - debug: just about everything that doesn't make the "info" cut... any message that is helpful in tracking the flow through the system and isolating issues, especially during the development and QA phases. We use "debug" level logs for entry/exit of most non-trivial methods and marking interesting events and decision points inside methods.
    - trace: we don't use this often, but this would be for extremely detailed and potentially high volume logs that you don't typically want enabled even during normal development. Examples include dumping a full object hierarchy, logging some state during every iteration of a large loop, etc.

- [JCL (Jakarta Commons Logging)](http://commons.apache.org/proper/commons-logging/guide.html#Best_Practices_General)
    - error - Other runtime errors or unexpected conditions. Expect these to be immediately visible on a status console.
    - warn - Use of deprecated APIs, poor use of API, 'almost' errors, other runtime situations that are undesirable or unexpected, but not necessarily "wrong". Expect these to be immediately visible on a status console.
    - info - Interesting runtime events (startup/shutdown). Expect these to be immediately visible on a console, so be conservative and keep to a minimum.
    - debug - detailed information on the flow through the system. Expect these to be written to logs only.
    - trace - more detailed information. Expect these to be written to logs only.

If you did some operations which actually worked, but there have been some issues - that’s a `WARNING` (like a success after a retry). But if you did some operation and it simply didn’t work - that’s an `ERROR`.

In case of a WARNING, you did something, but you didn’t do it perfectly. In case of an ERROR you didn’t do it.

`WARNING` (and also an ERROR of course) is a call to action. If nobody needs to react and to do something, then you don’t need to log a `WARNING`. But this also means, that you don’t log a `WARNING` if this particular case is expected to happen. For example, if you search for something and don’t find it, this is expected behaviour most of the time. It’s neither a `WARNING` nor an `ERROR`.

`INFO` is for business, `DEBUG` for technology

## Resources

- https://guicommits.com/how-to-log-in-python-like-a-pro/
- https://github.com/guilatrova/tryceratops/blob/95a34b643ad71c392d419006607ba4d3cbb68375/src/tryceratops/__main__.py#L50-L52
- https://twitter.com/guilatrova/status/1563119188582969345
- https://thomshutt.github.io/opinionated-logging-in-go.html
- https://tuhrig.de/my-logging-best-practices/
