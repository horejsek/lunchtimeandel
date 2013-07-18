
goog.provide 'lta.smoothlyScrollTo'


lta.smoothlyScrollTo = (scrollToY) ->
    frameTime = 10 # ms
    totalTime = 300 # ms

    position = startPosition = window.scrollY
    maxEndPosition = document.height - window.innerHeight
    endPosition = if scrollToY > maxEndPosition then maxEndPosition else scrollToY
    scrollBy = (endPosition - startPosition) * frameTime / totalTime

    shouldAnimate = (position, scrollBy) ->
        (scrollBy > 0 and position < endPosition) or (scrollBy < 0 and position > endPosition)
    animate = () ->
        #  Used scrollTo because ID automatically scroll to element, so
        #+ scollBy would calculate it wrongly.
        if !shouldAnimate(position + scrollBy, scrollBy)
            scrollBy = if scrollBy > 0 then 2 else -2
        position += scrollBy
        window.scrollTo 0, position
        if shouldAnimate(position, scrollBy)
            setTimeout animate, frameTime
    animate() if scrollBy

