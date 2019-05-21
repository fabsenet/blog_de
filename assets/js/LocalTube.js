if (document.body.addEventListener) {
    document.body.addEventListener('click', replaceThumbnailWithIframe, false);
}
else {
    document.body.attachEvent('onclick', replaceThumbnailWithIframe);//for IE
}

function replaceThumbnailWithIframe(e) {
    e = e || window.event;
    var target = e.target || e.srcElement;
    if (target.className.match(/LocalTube-playBtn/)) {
        parent = target.parentNode;
        id = parent.getAttribute('data-youtube-id');
        style = 'style="frameborder=0;"';
        inner = '<iframe class="youtubePlayer" src="https://www.youtube.com/embed/' + id + '?autoplay=1&autohide=1&border=0&wmode=opaque&enablejsapi=1"' + style + ' />'
        parent.innerHTML = inner;
    }
}