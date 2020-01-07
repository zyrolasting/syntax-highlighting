[![](https://img.shields.io/badge/%E2%99%A5-Support%20Ethical%20Software-red)][subscribe]

This package provides syntax highlighting for Racket.

However, the project is incomplete and unstable. You can fix this by
[supporting this project's development][subscribe].

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

[Pygments]: https://pygments.org/
[subscribe]: https://sagegerard.com/subscribe.html
