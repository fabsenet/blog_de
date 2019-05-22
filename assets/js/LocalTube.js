if (document.body.addEventListener) {
    document.body.addEventListener('click', replaceThumbnailWithIframe, false);
}
else {
    document.body.attachEvent('onclick', replaceThumbnailWithIframe);//for IE
}

function replaceThumbnailWithIframe(e) {
    e = e || window.event;
    var target = e.target || e.srcElement;
    if (target.className.match(/LocalTubePlayer/)) {
        const aTag = target;
        const figureTag = target.parentNode;
        id = figureTag.getAttribute('data-youtube-id');

        figureTag.removeChild(aTag);
        const inner = `<iframe class="youtubePlayer" src="https://www.youtube.com/embed/${id}?autoplay=0&autohide=1&border=0&wmode=opaque&enablejsapi=1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen />`;

        figureTag.innerHTML += inner;
        e.preventDefault();
    }
}