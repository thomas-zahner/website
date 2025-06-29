+++
title = "Announcing Commitoria"
date = 2025-06-29

[taxonomies]
tags = ["politics", "foss", "web"]
+++

# Background

> Git is a distributed version control system that tracks versions of files. [^1]

This is probably no news to you if you're a developer.
In practice, Git is most often used in combination with a hosting platform, such as GitHub or GitLab.
While these platforms often simplify a developer's life and increase visibility they can also be limiting in ways.
There are devs out there that strongly associate Git with GitHub to a point that they think GitHub (or insert any other platform here) is the only way to host Git repositories.
But this is not the case.
The only tool required to host a Git repository is Git itself[^2]  and some infrastructure to run it on.
The Linux kernel demonstrates how Git, alongside mailing lists, is a perfectly feasible and professional approach for handling large-scale projects.[^3]

While GitHub and other platforms have become mainstream, they are by no means perfect or the only option.
In fact, there are reasons to avoid such platforms.

These platforms undermine the decentralised nature of Git.
While Git itself prevents vendor lock-in to some extent, everything platform-related might be difficult or impossible to migrate.
Many hosting platforms are proprietary, which is quite ironic given that they often serve communities built around FOSS collaboration and transparency.
GitHub was acquired by Microsoft, a company known for its monopolistic and profit-driven tendencies.
Recently, GitHub blocked Organic Maps for some strange, possibly political reasons.[^4]
GitHub is a US-based company[^5], which makes it subject to the Patriot Act and, more recently, unstable and questionable politics.

In summary, there are many compelling reasons to avoid using some of the most well-known hosting platforms.
Additionally, it not uncommon for devs to rely on multiple hosting platforms.

# Announcing Commitoria

With this background I'm happy to announce my latest project [Commitoria](https://github.com/thomas-zahner/commitoria).
Commitoria is a small, **self-hostable** tool and platform that provides a way to summarise your contribution graph across different **independent** hosting solutions.
It's my small contribution in opposition to the mainstream centralisation of Git. <small>(you may have noticed that I also fell victim to the aforementioned centralisation)</small>

<br><br><br><br>

[^1]: [Shamelessly stolen from Wikipedia](https://en.wikipedia.org/wiki/Git)

[^2]: [Git on the Server - Setting Up the Server](https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server)

[^3]: [About the Linux kernel](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/about/)

[^4]: [Organic Maps migrates to Forgejo due to GitHub account blocked by Microsoft](https://alternativeto.net/news/2025/3/organic-maps-migrates-to-forgejo-due-to-github-account-blocked-by-microsoft/)

[^5]: [GitHub Terms of Service](https://docs.github.com/en/site-policy/github-terms/github-terms-of-service#1-governing-law)
