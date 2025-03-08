# Long-running tasks

Visualise with flow chart

Insert -> (Retrieve) -> (Progress) -> Complete

Insert gives out a handle and a UUID.
Retrieving is done via `UUID`. This is meant for external actors -> web clients
Progressing is done via `&Handle`. This method can be called by the computationally expensive task
Complete is done via `Handle`. This method is also called by the task's logic.

The beauty of Rust's ownership model makes it possible to ensure that the `progress` function
The nice thing is that this makes it possible for library users to `progress` a task after calling `complete`. It is prevented by the borrow checker.

In the `progress` function this is ex None => unreachable



## Outlook

- Cancellation of running tasks: DELETE /task/{id}
- Timeouts with tasks -> cancel timed out tasks
- Compare with Hangfire & Quartz scheduler https://blog.elmah.io/async-processing-of-long-running-tasks-in-asp-net-core/
- Update README.md under `Why?`: ... This prevents HTTP request timeouts and enables clients to poll a tasks state or progress.
- Test compile time errors? (https://rustc-dev-guide.rust-lang.org/tests/ui.html)
