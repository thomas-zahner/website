+++
title = "Experience with Atlassian"
date = 2024-08-20
# updated = 2024-08-20

[taxonomies]
tags = ["web", "rant"]
+++

So for the last four years I've been working in a company in a team where we developed apps and solutions for Atlassian products.
Maybe you haven't heart of Atlassian but you probably know their products Jira and Confluence.
Both can be extended with apps from the [Atlassian Marketplace](https://marketplace.atlassian.com).
In this post, I'll share how both user and developer experience felt to me and our team.
And to be honest, it wasn't very great.

<!-- more -->

If you work on extending a platform on a daily basis, you will inevitably also have to deal with the platform itself, its APIs and documentation on a daily basis.

This is why you expect the platform to provide useful APIs which are well-documented, stable and integrate well.
If this is not the case your productivity as developer and team will suffer and the developer experience (DX) will decline.
I'd even argue that a bad developer experience can cause stress and reduce the happiness of software developers.

But let's start from the very beginning.

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
They wanted all customers to migrate into their all-mighty cloud.

The cloud products brought some advantages such as easy setup and minimal maintainance.
But many existing customers could not be convinced to switch over, as the migration process was not without problems.
"Server" apps differ fundamentally from "cloud" apps which makes the migration pretty painful.
Additionally, handing over all your data to an external entity might come with some consideration.

Nevertheless, Atlassian tried to push their cloud products quite agressively.
In a clever move, they announced the end-of-life of their "server" products but kept selling the "data centre" solution.
From a technical standpoint those two palatforms are identical. The only difference is the ability to run multiple nodes redundantly.
From a customer's perspective the main difference is the pricing.

While you could get the Confluence server product for 10 users with a one-time payment of 10$,
you had to pay at least 15'000$ per year for the smallest "data centre" licence for 500 users.[^2]

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

![Network tab in Firefox when loading a small Confluence page, showing 382 requests and 18 megabyes of transferred data](/confluence-network-tab.png)

This is for Confluence "cloud".
Their onsite products do feel more responsive since their forntend is not as bloated and dynamic.
But the page load times aren't fast either.
In fact, we had to upgrade our servers where we hosted Confluence after some time,
because the Java application began to crash with `OutOfMemoryError`s.

For the cloud apps we used Cypress to test the functionality and prevent regressions.
With such a slow host product we had to adjust the default waiting timeout for HTML elements from 5 seconds to 20 seconds to have reliable tests.
We had to tell Cypress to ignore errors coming from Confluence to get tests to pass.
Their products cause an insane amount of errors and warnings in the browser.
Below is a screenshot of the console when loading a small Confluence page.
No browser extensions are enabled and no apps are installed in Confluence.
The logs are filled with warnings and error messages.

![17 errors and many more warnings showing up in the browser's console](/confluence-console-tab.png)

Unfortunately, Atlassian products are not the only bloated websites in the midst
of [the website obesity crisis](https://idlewords.com/talks/website_obesity.htm).

What about responsive design?
You would expect their products to be responsive and usable on mobile devices in today's world.
Below is a screenshot of the product's administration settings, where you can manage user groups.
Or at least you could if your screen was big enough.

![Screenshot of admin settings from a mobile phone in landscape mode, showing a dysfunctional and unreadable table where the first column is so small that the text spans across the whole height of the screen](/mobile-responsiveness.png)

Confluence is also notorious for its poor search functionality.
In the past (when I was still using Confluence) I would search for a page using a single word.
The results wouldn't show the page containing that exact word, but other unrelated content.
And searching for substrings of words on a page will *never* yield the page.
This is reported and known since 2008 but marked as "gathering interest" by Atlassian as of 2024.[^4]

After a customer's complaint about the poor quality of search results,
Atlassian went on to say that they could use thrid-party apps that might perform better
or use analytics add-ons.[^5]

But it gets even better.
While they don't seem to bother to make search actually good and useful
they introduced a powerful new feature: AI search.[^6]
This approach seems to follow the same path many companies are taking today.
Instead of actually fixing their shit they seem to believe that AI will magically solve their issues.
This is what Nikhil Suresh talks about in his great article
[I Will Fucking Piledrive You If You Mention AI Again](https://ludic.mataroa.blog/blog/i-will-fucking-piledrive-you-if-you-mention-ai-again/).

And the [enshittification](https://en.wikipedia.org/wiki/Enshittification) with AI doesn't stop there.
It seems like AI suggestions and features pop up in more UI elements each day.
Their cleverly branded
[Atlassian Intelligence](https://support.atlassian.com/organization-administration/docs/understand-atlassian-intelligence-features-in-products/)
can be used for most tasks.

I remember one day Confluence automatically started to highlight some terms and abbreviations on all of our pages.
The AI tried to explain the meaning of those words.
For example, it tried to explain that our company's name actually meant something none of us knew before.
It felt like an April Fool's joke.
Luckily, the next day the feature was gone.
But I can't remember if our admin disabled the feature or if Atlassian rolled it back.

But my colleagues and I never felt the need for these features.
Did *anybody* ask for those features? Maybe their stakeholders.

So while Confluence and Jira are useful for collaboration, I personally think the UX is terrible.
I'd prefer a git repository with text files over Confluence anytime.
I'd always choose a GitHub or GitLab issue board over Jira.

[^1]: Maven is one of the package and dependency management systems of Java, like Cargo or CMake

[^2]: <https://web.archive.org/web/20200814120012/https://www.atlassian.com/software/confluence/pricing?tab=self-managed>

[^3]: <https://www.theregister.com/2024/08/05/atlassian_q4_2024/>

[^4]: <https://jira.atlassian.com/browse/CONFSERVER-10412>

[^5]: <https://community.atlassian.com/t5/Confluence-questions/Re-Confluence-search-function-complaints/qaq-p/872284/comment-id/117105#M117105>

[^6]: <https://support.atlassian.com/confluence-cloud/docs/use-atlassian-intelligence-to-search-for-answers/>
