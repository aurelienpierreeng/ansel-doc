---
title: color assessment
date: 2022-12-04T02:19:02+01:00
id: color assessment
applicable-version: 4.0
tags:
view: darkroom
---

Assess colors and brightness in your image using ISO 12646:2008 recommended viewing conditions.

When developing an image, the way we perceive brightness, contrast and saturation is influenced by the surrounding ambient conditions. If an image is displayed against a dark background, this can have a number of adverse effects on our perception of that image:

- Exaggeration of the perceived exposure makes the image seems brighter than it really is. This is nicely illustrated by the [Adelson checkerboard shadow effect](https://en.wikipedia.org/wiki/Checker_shadow_illusion).
- A decrease in the perceived saturation in the image makes the colors seem less rich than they really are (the Hunt effect).
- A decrease in the perceived contrast in the image makes the tones seem flatter than they really are (Bartleson-Breneman effect 3)

The end result is that the final image can end up being too dark and overly-processed in terms of contrast and color saturation. To avoid this, the "ISO 12646:2008" standard makes some recommendations about the conditions under which the colors of an image should be assessed. The _color assessment_ module in the darkroom places a frame around the image to help the user better assess the colors in the image, along the lines of those recommendations.

![color-assessment-overview](color-assessment-overview.jpg)

When the color assessment button ![bulb-icon](bulb-icon.jpg) is selected in the bottom panel, the image is zoomed out so that a thick mid-gray border appears around the image to act as a reference against which to compare the image's tones. A thinner white border is placed immediately around the image to give the eyes a basis for comparison when looking at parts of the image that are meant to be a bright white.

Although the color assessment mode provides a mid-gray surrounding to the image, it is recommended that you also set your user interface (in [preferences > general](../../preferences-settings/general.md)) to one of the "grey" themes. These themes are designed to provide a user interface that is close to middle gray (it is actually slightly darker to allow better contrast with the text in the user interface). When one of these themes is used together with the color assessment mode, this will help to avoid the above perception issues.

Color assessment mode can also be toggled by pressing Ctrl+B.
