+++
title = "Experience with Atlassian"
date = 2024-08-26
updated = 2024-08-29

[taxonomies]
tags = ["web", "rant"]
+++

For the last four years I've been working in a team where we developed apps for Atlassian products.
Maybe you haven't heart of Atlassian but you probably know their products Jira and Confluence.
Both can be extended with apps from the [Atlassian Marketplace](https://marketplace.atlassian.com).
In this post, I'll share how both user and developer experience felt to me and our team.
And to be honest, it wasn't very great.

<!-- more -->

## On premise products

When I started at the company all of our apps were targeting the Confluence or Jira "server" product.
"Server" is their brand for their products which can be hosted onsite.

Back then, this was the normal way to run your company's Jira or Confluence instance.
You installed Java on your server, set up your database and finally downloaded and ran the Java executable.

As a developer you would start your Java Maven[^1] project from [their template](https://developer.atlassian.com/server/framework/atlassian-sdk/create-a-helloworld-plugin-project/) and everything was good to go.
For development you simply ran the Maven project and Confluence/Jira was started on your local machine with your app running as an [OSGi](https://en.wikipedia.org/wiki/OSGi) container inside the main Java application.
The app was integrated tightly into Confluence, you could easily implement their (mostly) documented interfaces to modify or extend behaviour.
And although their products are proprietary, you could easily inspect most of their code in the IDE by simply opening the classes and interfaces you inherited or extended.

Your frontend files were injected directly into the users' browser at the root DOM.
The world was simple. Maybe a bit too simple.
The simplicity and lack of restrictions or containerisation could lead to incompatibilities between apps.
If two apps can modify the frontend in arbitrary ways and they don't know of each other funny things could happen.
The backend was less prone to such incompatibilities but it could happen as well.

## Cloudification

Fast forward some years and Atlassian has abolished their "server" products.
With their "cloud-first strategy" they tried to push the customers towards the cloud.

In the beginning the "server" and "cloud" products didn't differ much.
After all the "cloud" product was still the Java application running on their servers.
They did improve the situation of app incompatibilities and crashes in their cloud product by decoupling the apps from the server.
The apps were no longer running inside the Java server directly, instead they had to be hosted by the developers
and they communicated via HTTP REST APIs with the server.

Over time Atlassian slowed down development of the self-hosted products and increased their efforts to add more new features to the cloud.
They wanted all customers to migrate into their cloud.

The cloud products brought some advantages such as easy setup and minimal maintainance.
But many existing customers could not be convinced to switch over, as the migration process was not without problems.
"Server" apps differ fundamentally from "cloud" apps which makes the migration pretty painful.
Additionally, handing over all your data to an external entity might come with some consideration.

Nevertheless, Atlassian tried to push their cloud products quite agressively.
In a clever move, they announced the end-of-life of their "server" products but kept selling the "data centre" solution.
From a technical standpoint those two platforms are identical. The only difference is the ability to run multiple nodes redundantly.
From a customer's perspective the main difference is the pricing.

While you could get the Confluence server product for 10 users with a one-time payment of 10$,
you had to pay at least 15'000$ *per year* for the smallest "data centre" licence for 500 users.[^2]

For the server licence you might expect to pay 500$ for 500 users, the pricing however is not linear.
Instead you had to pay a whopping 30'000$ for 500 users.
But at least this was a one-time payment and the licence was perpetual like they advertised. *Right?*
Well a product that is announced to be at the end of its life, that doesn't get updates or security fixes and doesn't allow
the installation of new apps doesn't seem very perpetual.

Only after having forced most small to medium sized customers to the cloud Atlassian softened their "cloud-first" approach.[^3]

## User experience

So enough storytelling.
What does it feel like to use Confluence and Jira as an end-user in their cloud?

Firstly, it feels slow. *Very slow.*
It takes about 3 to 5 seconds for a normal Confluence page to load.
You will notice how many parts of the page load individually at their own pace.
Content moves around dynamically and pops up until the page is fully loaded.

A single page load causes Firefox to make more than 350 requests and transfer about 18 megabyes of data.
And all I wanted was to read simple text content less than a single kilobyte in size.
Unfortunately, Atlassian products are not the only bloated websites in the midst
of [the website obesity crisis](https://idlewords.com/talks/website_obesity.htm).

![Network tab in Firefox when loading a small Confluence page, showing 382 requests and 18 megabyes of transferred data](/confluence-network-tab.png)

This is for Confluence "cloud".
Their onsite products are more responsive since their frontend is not as bloated and dynamic.
A lot of things are rendered server-side and good old jQuery is used instead of React.
But the page load times aren't fast either.
In fact, we had to upgrade our servers where we hosted Confluence after some time,
because the application began to crash with `OutOfMemoryError`s.

For the cloud apps we used Cypress to test the functionality and prevent regressions.
With such a slow host product we had to adjust the default waiting timeout for HTML elements from 5 seconds to 20 seconds to have reliable tests.
We had to tell Cypress to ignore errors coming from Confluence to get tests to pass.
Their products cause an insane amount of errors and warnings in the browser.
Below is a screenshot of the console when loading a small Confluence page.
No browser extensions are enabled and no apps are installed in Confluence.
The logs are filled with warnings and error messages.

![17 errors and many more warnings showing up in the browser's console](/confluence-console-tab.png)

What about responsive design?
You would expect their products to be responsive and usable on mobile devices in today's world.
Below is a screenshot of the product's administration settings, where you can manage user groups.
Or at least you could if your screen was big enough.

![Screenshot of admin settings from a mobile phone in landscape mode, showing a dysfunctional and unreadable table where the first column is so small that the text spans across the whole height of the screen](/mobile-responsiveness.png)

Atlassian products are also notorious for its poor search functionality.
In the past (when I was still using Confluence) I would search for a page using a single word.
The results wouldn't show the page containing that exact word, but other unrelated content.
And searching for substrings of words on a page will *never* yield the page.
This is reported and known since 2008 but marked as "gathering interest" by Atlassian as of 2024.[^4]

After a customer's complaint about the poor quality of search results,
Atlassian went on to say that they could use third-party apps that might perform better
or use analytics add-ons.[^5]

They also have "reserved words" you won't be able to search for to *keep the search index size and search performance optimal*
which leads to unexpected behaviour.[^6]
The reserved words are everyday words such as "and", "the" and "this".

But it gets even better.
While they don't seem to bother to make search actually good and useful
they introduced a powerful new feature: AI search.[^7]
This approach seems to follow the same path many companies are taking today.
Instead of actually fixing the problems, they seem to believe that AI will magically do it for them.
This is what Nikhil Suresh talks about in his great article
[I Will Fucking Piledrive You If You Mention AI Again](https://ludic.mataroa.blog/blog/i-will-fucking-piledrive-you-if-you-mention-ai-again/).

And the [enshittification](https://en.wikipedia.org/wiki/Enshittification) with AI doesn't stop there.
It seems like AI suggestions and features pop up in more UI elements each day.
Their cleverly branded
[Atlassian Intelligence](https://support.atlassian.com/organization-administration/docs/understand-atlassian-intelligence-features-in-products/)
can be used for most tasks.

I remember one day Confluence automatically started to highlight some terms and abbreviations on all of our pages.
The AI tried to explain the meaning of those words.
For example, it tried to explain that our company name actually meant something none of us knew before.
It felt like an April Fool's joke.
Luckily, the next day the feature was gone.
But I can't remember if our admin disabled the feature or if Atlassian rolled it back.

But my colleagues and I never felt the need for these features.
Did *anybody* ask for those features? Maybe their stakeholders.

So while Confluence and Jira are useful for collaboration, I personally think the UX is terrible.
There are alternatives today, and I'd probably prefer any of them.

## Developer experience

The developer experience wasn't really any better than the user experience.
It may be in the nature of proprietary products but we often felt like they didn't
really care too much about the users and developers of their platforms.
As mentioned above they didn't put too much effort into improving long-standing issues
or requests from customers. The same was true for requests from developers.

In their public request tracking list you can find issues that have been open for 20 years,
have more than hundreds of upvotes and are still "gathering interest".
For new features Atlassian could be excused with "insufficient resources" and the fact that third-party apps could fill the gap.
But having to wait 20 years before the ability to rename a key *is even considered*?[^8]
Advanced features such as numbered headings are "not being considered" since you can buy an app to do that for you.[^9]
Some people didn't like that decision very much:

> Seriously Atlassian??? First you force us to use the f** cloud version and then you dont even provide the BASIC functinality of a standard Editor????
> Why should be pay for this!? In the server version we hat the CSS functionality to do this stuff. Just implement the basic functions of the server version.
> With our company (1000+ users) we tend o NOT move to the cloud version of confluence and rather change the tools.[^9]


Those were some more user-facing examples.
The more developer-facing it gets, the more obscure and weird it gets.

Their REST API for their cloud products proved to be surprisingly unstable and slow.
Calls could fail seemingly without reason, especially when we ran our automated integration tests for our apps.
They could take multiple seconds to complete for simple request like querying some data.
They tried to address the performance and reliability issues by introducing the new REST API version V2.
However, they deprecated API V1 even before V2 was powerful enough to do the same things that V1 could do.[^10]

Such slow APIs are also likely to result in high costs at runtime in their cloud infrastructure.
Their solution to this problem was rate limiting.[^11] What a great solution!
On their shiny new app development platform, the rate limit was so conservative that our customers were regularly experiencing problems.
Your app's function can run no longer than 25 seconds before it is killed,
you can create no more than 200 database queries in 20 seconds,
you're not even allowed to log more than 30 lines per invocation.[^12]
Like WTF?

Atlassian is also notorious for introducing unnanounced breaking changes.
This is the case for end-users[^13] but also for developers.
For example in an update for their onsite products they introduced a "request whitelist".
This new feature blocked all outbound traffic by default unless the destination URL was whitelisted.
So our customers who updated Confluence broke our translation app, because outbound traffic was blocked at runtime.
There was no programmatic approach to ask for a whitelist entry.
All we could do was tell our customers to *manually* whitelist the URLs, but we still received dozens of complaints.

Another time they made changes to the type that was returned when querying licence information without announcement.
This resulted in many apps either crashing or incorrectly assuming they were unlicensed.
The response time was quite slow so that we had to figure out the problem ourselves.
The best part about debugging the issue was that the licence information was only available in production.
So we had roll out new app versions to our customers for debugging the problem.
Turned out they renamed a property from `isActive` to `active`.
Thank you Atlassian for this great improvement and for the side effect of breaking hundreds of apps.
Oh and apart from not informing anybody about the change they didn't even update their documentation.
In our team we used to joke a lot about the notoriously bad or non-existent documentation.

Below is a screenshot of our complaint.

![Showing the misalignment of their documentation and the value in production in two screenshots. Text: We have found the issue, it seems that you changed the property names of the context. The name "isActive" has been changed to "active", the documentation on the other has NOT been updated and still shows "isActive" as the correct property name. There is no easy way to test this without deploying a version of the app to production and log the context, so it would be greatly appreciated if you could update the documentation when changing such vital things.](/unannounced-api-changes.png)

They even managed to introduce breaking changes with rate limiting, in such a way that apps became unusable.[^14]
Now that's an achievement.

Also Atlassian really doesn't care about technical correctness.
They seem to prioritise new user-facing features and short-term revenue-generating functionality.
One day I reported that they return the status code `200 OK` for Confluence pages that don't exist
where the technically correct code would be `404 Not Found`.
Their response was:

> After discussing with our developers, it was clarified that the HTML document returned when requesting a page is not a documented, supported API.
> If you need to verify the existence of a page, it's recommended to use one of the REST APIs, which will return a 404 as expected if the page does not exist. [...][^15]

Similar things happended in the past[^16] and I had a strong feeling that they would never fix this.
I reported this issue with the expectation of proving my point.

# Conclusion

If you work on extending a platform on a daily basis,
you will inevitably also have to deal with the platform itself, its APIs and documentation on a daily basis.
This is why you expect the platform to provide useful APIs which are well-documented, stable and integrate well.
If this is not the case your productivity as developer and team will suffer and the developer experience will decline.
I'd even argue that a bad developer experience can cause stress and reduce the happiness of software developers.

Working with Atlassian's platforms has often been the painful opposite.
And as time went on, I felt it was getting worse.
They don't seem to care about technical correctness and long-term stability.
Their excuses were often "resource constraints", meaning understaffing.
But for AI enshittification and other features that people haven't asked for, they seem to be finding the resources.
So I think they've got their priorities wrong.
I would advise them to [move slower and fix things](https://endler.dev/2024/move-slow-and-fix-things/),
but stakeholders probably prefer to see shiny new features and AI.
If people find that your platform is unreliable or unstable, they may lose trust.
These people are likely to move to another platform.

It may be a bit of an exaggeration, but I sometimes felt like I was living in a dictatorship when I was working in the Atlassian ecosystem.
If the platform was free software, I could fix the technical problems myself, effectively solving the problem of understaffing or wrong priorities.
When users are unhappy about changes a fork could be created, forcing the vendor to think more about changes.
So while I've been ranting about Atlassian in this article, I think that the underlying problem is the proprietary nature of the products.
There is no shortage of FOSS alternatives to Atlassian products,
and if they continue to perform as they have in recent years, companies may consider alternatives.

To conclude my post, here are a few selected quotes from the Atlassian forums that capture the general sentiment.

> Jira filters are atrocious! Filters on databases have been possible since the 70s... maybe even earlier... Why is this so bad? The poor and unpredictable results have seriously hampered my work, and as they are not reliable, mistakes have been made which cost my project time, effort and money. Desperately trying to convince management to migrate away from Jira and find a different solution.[^17]

> My dudes, this is way too many breaking changes. It’s at version 10 and you’re renaming/removing props. Why were those basic things not solidified many versions ago?
> Most of these changes seem to be nothing more than opinionated aesthetics. [...]
> Almost all of the changes are frivolous. It’d be funny if it didn’t waste developer time.[^18]

> Is this for real?
> Please fix this BUG, unbelievable...[^19]

> If you ever want to retrieve one or multiple pages by title using the Confluence REST API and thought that would be a matter of one simple call against the CQL or Content REST API, you have been fooled by a collection of bugs in the REST endpoints of Confluence Cloud and Server.[^20]

> Support interaction this morning:
>
> Customer: “it’s very slow”<br>
> Me: “nothing we can do sorry, it’s using Atlassian’s UI Kit and is served/hosted on their infrastructure”<br>
> Customer: emails Atlassian support<br>
> Atlassian support: “you’ll need to engage with the vendor”<br>
> Customer: “they sent me back to you”<br>
> Me: “yeah again nothing we can do sorry, I can submit a ticket with them but considering they haven’t fixed many core Forge problems in over two years now it’s unlikely to be resolved any time soon. This is why our Forge apps are still free because we can’t justify charging customers.” [^21]

<br><br><br><br>

[^1]: Maven is one of the package and dependency management systems of Java. Like Cargo for Rust or NPM for NodeJS.

[^2]: [Confluence pricing in August 2020](https://web.archive.org/web/20200814120012/https://www.atlassian.com/software/confluence/pricing?tab=self-managed)

[^3]: [Atlassian softens its cloud-first approach for remaining on-prem customers - The Register](https://www.theregister.com/2024/08/05/atlassian_q4_2024/)

[^4]: [Support substring searches for terms used in Confluence](https://jira.atlassian.com/browse/CONFSERVER-10412)

[^5]: [Confluence search function complaints](https://community.atlassian.com/t5/Confluence-questions/Re-Confluence-search-function-complaints/qaq-p/872284/comment-id/117105#M117105)

[^6]: [Search syntax for text fields - Reserved words](https://confluence.atlassian.com/jiracoreserver073/search-syntax-for-text-fields-861257223.html#PerformingTextSearches-escaping)

[^7]: [Use Atlassian Intelligence to search for answers](https://support.atlassian.com/confluence-cloud/docs/use-atlassian-intelligence-to-search-for-answers/)

[^8]: [Ability to rename space key](https://jira.atlassian.com/browse/CONFSERVER-2085?filter=98691&jql=project%20%3D%20CONFSERVER%20AND%20resolution%20%3D%20Unresolved%20ORDER%20BY%20votes%20DESC)

[^9]: [Numbered headings](https://jira.atlassian.com/browse/CONFSERVER-1732?filter=98691&jql=project%20%3D%20CONFSERVER%20AND%20resolution%20%3D%20Unresolved%20ORDER%20BY%20votes%20DESC)

[^10]: [Confluence REST API v2: Update to v1 Deprecation Timeline](https://community.developer.atlassian.com/t/confluence-rest-api-v2-update-to-v1-deprecation-timeline/75126)

[^11]: [Rate limiting](https://developer.atlassian.com/cloud/confluence/rate-limiting/)

[^12]: [Forge platform quotas and limits](https://web.archive.org/web/20230326111348/https://developer.atlassian.com/platform/forge/platform-quotas-and-limits/)

[^13]: [Why does Atlassian keep breaking Confluence?](https://community.atlassian.com/t5/Confluence-questions/Why-does-Atlassian-keep-breaking-Confluence/qaq-p/882544)

[^14]: [Forge update broke our app in 100s of customer instances and we can’t do anything about it](https://community.developer.atlassian.com/t/forge-update-broke-our-app-in-100s-of-customer-instances-and-we-cant-do-anything-about-it/77751)

[^15]: [Screenshot of service desk issue](/incorrect-status-code-support-ticket.png)

[^16]: [Status code 403 instead of 200](https://jira.atlassian.com/browse/CONFCLOUD-14341)

[^17]: [Searching JIRA issues for special characters does not work](https://jira.atlassian.com/browse/JRASERVER-25092)

[^18]: [JQL search with special characters](https://jira.atlassian.com/browse/JRASERVER-66244)

[^19]: [Finding a page by title](https://community.developer.atlassian.com/t/finding-a-page-by-title/41553)

[^20]: [Forge invoke is very slow](https://community.developer.atlassian.com/t/forge-invoke-is-very-slow/68746/12)

[^21]: [Upgrading to @forge/react version 10](https://community.developer.atlassian.com/t/first-returns-on-upgrade-to-forge-react-version-10/77988/12)
