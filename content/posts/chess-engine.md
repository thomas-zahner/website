+++
title = "Reinventing the wheel"
date = 2026-01-30

[taxonomies]
tags = ["software", "engineering", "rust", "offline programming"]
+++

5 years ago, in November 2021, when the Covid pandemic was in full swing and everybody tried to stay home, I was both studying and working fully remotely.
Suddenly, I had regained much time of my week by not having to commute.
Lectures could suddenly be skipped without anybody noticing, they could be consumed in double speed while staying in bed.
Everyday habits were broken and new ones emerged.

<!-- more -->

I was no longer seeing any friends from uni physically, but some lectures turned more intersting and social because of TeamSpeak.
We could suddenly talk and discuss openly while the professor was speaking without interrupting anybody.
Image and audio clips and memes of our professors and ourselves were created to keep our home office lifes fun.
When you talked to your friend sometimes a professor was responding unexpectedly in mocking way.

It was in this habit-breaking time where I found the motivation to write a chess engine.
Because I was constantly online for both uni and work, I decided to approach the project a little different.

Today, one would normally first research what a chess engine is and how it works.
One would learn about different approaches, algorithms and ideas profitting by the work and knowledge of others.
One might follow a video tutorial, copy code from others or might even use an LLM to write the code. (though this was the time before ChatGPT)
But what's lost in the process is the creativity and ability to come up with ideas yourself.

So I set myself the goal of writing a functional chess engine *offline* without doing *any* research at all.
I took pen and paper and started to think about the algorithm that would be able to calculate the optimal chess move.
It took me probably about two hours on paper to come up with and understand how the recursive algorithm would work.

I simply called it [`recurse`](https://gitlab.com/thomas-zahner/chess-engine/-/blob/55bb1fd1d5ff23d752e40c6fecb6fe838e7f5c95/src/analysis.rs#L57).
Since I forbade myself to do any research I got the chess square notation "wrong" initially.
It was mirrored, so I used A8 instead of A1.
But it wouldn't have made a difference.
I probably only changed it to match the real chess bord next to me.
At [one point](https://gitlab.com/thomas-zahner/chess-engine/-/commit/55bb1fd1d5ff23d752e40c6fecb6fe838e7f5c95)
after quite some thinking, creativity and programming the engine worked.
I was really happy which I expressed through a bold exclamation mark in the commit message: `Algorithm working!`

Unfortunately, to calculation turned out to be incredibly slow.
It was a beautiful demonstration that a "fast" programming language (Rust) doesn't magically make your programs fast.
If I implemented it in any other langauge it would have been roughly equally slow.
Turns out the magnitude of slowness is largely decided by the algorithm's Big O notation, just as taught by our professors.

At this point I decided to allow myself to "cheat" and do research.
I found out that the algorithm "I invented" was called minimax or minmax.
I found that it could be sped up quite a bit with [alpha-beta pruning](https://gitlab.com/thomas-zahner/chess-engine/-/commit/0c95a1b34d5e384905eef28ab8581667123b752d).
This allowed me to increase the default search depth from 4 to 5 on my machine.
I found out how there is a [Wikipedia](https://www.chessprogramming.org),
diverse communities, video tutorials and forums dedicated to chess engine programming

In summary the whole process was slow, tedious and not very easy.
But it was fun, rewarding and required creative thinking.
It reminded me of the time when I started to learn programming.
It reminded me of my first "bigger" hobby project where I came up with a "software test",
by writing a separate program testing the main program, before I knew the concept of software testing.
Having followed this approach lead to a much deeper understanding of the minimax algorithm, as I basically reinvented it.
If I followed a YouTube tutorial instead, I would have forgotten most of it by now.
Had I followed the Chessprogramming wiki instead, my knowledge about engines would be broader but probably not as deep.

I can warmly recommend doing *offline* programming and reinventing things from time to time.
This is especially true in the current LLM craze.
Reinventing things is not particularly efficient but the process can be really inspiring.
And it might even lead to an actual new invention.

Thank you Matthias for
[improving the program's usability](https://gitlab.com/thomas-zahner/chess-engine/-/commit/966b05c9a8eb54641f8b7854f8921a2a83544b75)
and for [motivating me again](https://endler.dev/2026/personal-blog/) to write a blog post.
I only noticed after giving this blog post the title that Matthias has a very similarly named blog post called
[Reinvent The Wheel](https://endler.dev/2025/reinvent-the-wheel/).
So did I just reinvent reinventing the wheel?
