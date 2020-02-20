[![](https://img.shields.io/badge/%E2%99%A5-Support%20Ethical%20Software-red)][subscribe]

This package provides syntax highlighting for Racket.

However, the project is incomplete and unstable. If you think this is
a valuable contribution, then you can help [support this project's
development][subscribe].

## Motivation and Preliminary Thinking
Racket is a pioneer for language-oriented programming with a curious
lack of good syntax highlighting options. My personal interest in this
topic comes from samples like this JavaScript/CSS mixture:

```
const myDiv = styled.div`box-sizing: border-box`
```

Racket developers seem to like using [Pygments][], which forces you to
add an ecosystem and the deployment burden that brings to your project
for the sake of one feature.

The plan is to extend `parsack` such that it buckets characters using
Pygments' token classes. Presentation/post-processing of code can then
be reasoned about in relatively familiar terms for the Racket community.

Problem is, that will take a long time. A good stopgap is a Docker
image with an existing syntax highlighter, along with a Racket API to
access a respective container as a service. One possible complication
is whether Docker should be automatically installed on your system, if
on a VM or bare-metal.

[Pygments]: https://pygments.org/
[subscribe]: https://sagegerard.com/subscribe.html
