window.fbAsyncInit = ->
  FB.init
    appId: '690984834394147'
    xfbml: true
    version: 'v2.9'
  FB.AppEvents.logPageView()
  return

((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  if d.getElementById(id)
    return
  js = d.createElement(s)
  js.id = id
  js.src = '//connect.facebook.net/en_US/sdk.js'
  fjs.parentNode.insertBefore js, fjs
  return
) document, 'script', 'facebook-jssdk'
