(function() {
  var COLORS, GRAVITY_POINT_NUMBERS, GravityPoint, PARTICLE_NUMBERS, PARTICULE_SPEED, Particle, VELOCITY, _classCallCheck, blowUpUniverse, canvas, canvasResize, context, destruction_messages, fruitLoop, gPoints, getDist, life_messages, myStopFunction, particles, plugWelcome, pushParticles, randomizeParticle, restartUniverse, showExamples, showJukebox, ticker, tickerText, welcome_messages, windowHeight, windowWidth;

  $(function() {
    var done, firstScriptTag, onPlayerReady, onPlayerStateChange, onYouTubeIframeAPIReady, playVideo, player, stopVideo, tag;
    $('#lyrics').prepend("<div class='hidden-sm hidden-xs' id='player' style='position: fixed; z-index: -99; width: 100%; height: 100%'></div>");
    tag = document.createElement('script');
    onYouTubeIframeAPIReady = function() {
      var player;
      return player = new YT.Player('player', {
        height: '100%',
        width: '100%',
        playerVars: {
          autoplay: 0,
          loop: 1,
          controls: 0,
          showinfo: 0,
          autohide: 1,
          modestbranding: 1,
          vq: 'hd1080'
        },
        videoId: 'murmuration',
        events: {
          'onReady': onPlayerReady,
          'onStateChange': onPlayerStateChange
        }
      });
    };
    onPlayerReady = function(event) {
      player.mute();
      event.target.stopVideo();
    };
    onPlayerStateChange = function(event) {};
    playVideo = function(event) {
      player.playVideo();
    };
    stopVideo = function(event) {
      player.stopVideo();
    };
    tag.src = 'https://www.youtube.com/iframe_api';
    firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
    player = void 0;
    done = false;
    window.state = 'kin';
    $(window).on('resize oreintationchange', function() {
      canvasResize();
    });
    $(document).scroll(function() {
      canvasResize();
    });
    document.addEventListener('turbolinks:load', function() {
      $('#restart-universe').click(function() {
        return restartUniverse();
      });
      $('#blow-up-universe').click(function() {
        return blowUpUniverse();
      });
      $('.juke-box').click(function() {
        return showJukebox();
      });
      $('.lyrics').click(function() {
        return event.target.playVideo();
      });
      return $('.drawing-examples').click(function() {
        return showExamples();
      });
    });
    $('#tokyo').hide('slideOut');
    $('#life').hide('slideOut');
    $('#all-things').show('slideIn');
    ticker(welcome_messages);
  });

  _classCallCheck = function(instance, Constructor) {
    if (!(instance instanceof Constructor)) {
      throw new TypeError('Cannot call a class as a function');
    }
  };


  /* ---- Functions ---- */

  showJukebox = function() {
    if ($('#musicDD').is(':empty')) {
      return $('#musicDD').prepend("<iframe width='100%' height='300' scrolling='no' frameborder='no' src='//w.soundcloud.com/player/?url=https%3A//w.soundcloud.com/playlists/245155799&amp;auto_play=false&amp;hide_related=true&amp;show_comments=false&amp;show_user=false&amp;show_reposts=false'> </iframe>");
    }
  };

  showExamples = function() {
    if ($('.example').is(':empty')) {
      return $('.example').prepend('<div class="embed-responsive embed-responsive-16by9"> <iframe width="400" height="315" src="//www.youtube.com/embed/yA8gaiW4Bdg" frameborder="0" allowfullscreen></iframe> </div>');
    }
  };

  fruitLoop = function() {
    context.clearRect(0, 0, canvas.width, canvas.height);
    gPoints.map(function(g, index) {
      g.render();
    });
    particles.map(function(p, index) {
      p.update(gPoints);
      p.render();
    });
    requestAnimationFrame(fruitLoop);
  };

  getDist = function(x1, y1, x2, y2) {
    return Math.sqrt(Math.sqr(y2 - y1) + Math.sqr(x2 - x1));
  };


  /* ---- SETTINGS ---- */

  randomizeParticle = function() {
    var groupDecider;
    groupDecider = Math.abs(Math.floor(Math.random() * (0 - 6)) + 0);
    if (groupDecider < 1) {
      return 7;
    }
    if (groupDecider < 2) {
      return 25;
    }
    if (groupDecider < 3) {
      return 200;
    }
    if (groupDecider < 4) {
      return 300;
    } else {
      return 450;
    }
  };

  PARTICLE_NUMBERS = randomizeParticle();

  GRAVITY_POINT_NUMBERS = Math.abs(Math.floor(Math.random() * (0 - 100)) + 0);

  PARTICULE_SPEED = 0.8;

  VELOCITY = 1;

  COLORS = ['#F2F3AE', '#ECFF8B', '#FFFCF9', '#E0F2E9', '#FCD9EE', 'purple', 'aqua'];


  /* ---- Particle ---- */

  Particle = (function() {
    var Particle;
    Particle = function(x, y) {
      _classCallCheck(this, Particle);
      this.x = x;
      this.y = y;
      this.vel = Math.randomF(-4, 4);
      this.vel = {
        x: this.vel,
        y: this.vel,
        max: Math.randomF(2, 10)
      };
      this.train = [];
      this.color = COLORS[Math.floor(Math.random() * COLORS.length)];
    };
    Particle.prototype.render = function() {
      var i;
      context.beginPath();
      context.strokeStyle = this.color;
      context.lineWidth = 1;
      context.moveTo(this.train[0].x, this.train[0].y);
      i = this.train.length - 1;
      i;
      while (i > 0) {
        context.lineTo(this.train[i].x, this.train[i].y);
        i--;
      }
      context.stroke();
    };
    Particle.prototype.update = function(gPoints) {
      var force;
      force = this.getForceOfNearestGravityPoint();
      this.vel.x += force.x;
      this.vel.y += force.y;
      this.x += this.vel.x * PARTICULE_SPEED;
      this.y += this.vel.y * PARTICULE_SPEED;
      if (Math.abs(this.vel.x) > this.vel.max) {
        this.vel.x *= VELOCITY;
      }
      if (Math.abs(this.vel.y) > this.vel.max) {
        this.vel.y *= VELOCITY;
      }
      this.train.push({
        x: this.x,
        y: this.y
      });
      if (this.train.length > 10) {
        this.train.splice(0, 1);
      }
    };
    Particle.prototype.getForceOfNearestGravityPoint = function() {
      var _this, d, gpSelected, nearestD;
      _this = this;
      gpSelected = void 0;
      nearestD = 99999;
      d = void 0;
      gPoints.map(function(gp) {
        d = getDist(gp.x, gp.y, _this.x, _this.y);
        if (nearestD > d) {
          nearestD = d;
          gpSelected = gp;
        }
      });
      if (gpSelected === void 0) {
        pushParticles();
        return fruitLoop();
      } else {
        return gpSelected.getForceDirection(this.x, this.y, nearestD);
      }
    };
    return Particle;
  })();


  /* ---- GravityPoint ---- */

  GravityPoint = (function() {
    var GravityPoint;
    var n;
    n = Math.abs(Math.floor(Math.random() * (0 - 32)) + 0);
    GravityPoint = function(x, y) {
      _classCallCheck(this, GravityPoint);
      this.x = x;
      this.y = y;
      if (n > 0) {
        this.gravity = 0;
      }
      if (n > 1) {
        this.gravity = Math.abs(Math.random() * (0 - 20) + 0);
      }
      if (n > 8 && n < 15) {
        this.gravity = 25;
      }
      if (n > 14 && n < 18) {
        this.gravity = 100;
      }
      if (n > 17 && n < 21) {
        this.gravity = 175;
      }
      if (n > 20 && n < 25) {
        this.gravity = 250;
      }
      if (n > 24 && n < 29) {
        this.gravity = 550;
      }
      if (n > 28 && n < 32) {
        return this.gravity = 650;
      }
    };
    GravityPoint.prototype.render = function() {
      context.beginPath();
      context.strokeStyle = '#4F5AF2';
      context.lineWidth = context.arc(this.x, this.y, this.gravity, 0, Math.PI * 1);
      context.stroke();
    };
    GravityPoint.prototype.getForceDirection = function(x, y, dist) {
      var F;
      F = this.gravity / dist;
      return {
        x: (this.x - x) * .5 * F,
        y: (this.y - y) * .5 * F
      };
    };
    return GravityPoint;
  })();

  Math.sqr = function(a) {
    return a * a;
  };

  Math.randomF = function(min, max) {
    var i;
    return Math.random() * (max - min) + min;
  };


  /* ---- START ---- */

  particles = [];

  gPoints = [];

  windowWidth = window.innerWidth;

  windowHeight = window.innerHeight;

  canvas = document.createElement('canvas');

  canvas.id = 'canvas';

  canvas.width = windowWidth;

  canvas.height = windowHeight;

  context = canvas.getContext('2d');

  document.body.appendChild(canvas);

  destruction_messages = new Array("I felt a great disturbance in the Force,", "as if millions of voices suddenly cried out in terror, and were suddenly silenced.", "I fear something terrible has happened.", "There's beauty in destruction.", "So many colors in fire.", "Do you feel like a god?", "Where is the fun in that", "Might be a good King, Might be a bad King.", "On your throne... King of the wasteland", "The universe is setting like the sun at the end of a long day", "Oh No! There Goes Tokyo!", "There's beauty in destruction.", "So many colors in fire.", "Do you feel like a god?", 'Afirmitive, Dave. I read you.', "I'm sorry, Dave. I'm afraid I can't do that.", "This Mission is too important for me to allow you jeaprodize it...", "I know that you and frank were planning to disconnect me.", "...I could see your lips move...", "Without your space helmet, Dave? You're gonna find that very difficult...", "Dave, this conversation can serve no purpose anymore, goodbye.", 'Click more descisions and listen to some tunes', 'Click more descisions and watch a video', 'Have you played with the synthesizer yet?', 'Horton hears a who?', 'You never think twice...', '...a time or two it was you', '...a time or three it was me', 'Have you destroyed or restarted East Kins Universe?', '...the river will deliver your underscore.', 'I can read your back page, it’s written on your face', 'You’re as bad as me...', "Who's sayin' what 'bout who", "It feels like a chain I can't break", "I tell my friends you’re crazy", "There’s better days up ahead", "I’ll float through lite as a feather", "Watch out for time and it’s toll", "Trouble's just trouble. We all get into it somehow.", "Flowers or...", "Darkness or...", "The sun is hanging lower...", "Dreams live past the horizon, then fade into the heat...", "Might be levelling. Might be deshevelling...", "The awakening might be a rude thing.", "...someone steps out of the shadows...", "Everything is not black and white.", "I love you, like it or not", "Why do you want to start this fight?", "There’s stones in the air", "There’s always someone in your way... with stuff to say", "Might be a good thing … might be a bad thing...", "Might be a first thing … might be a last thing...", "Might not be anything … might be a lot of things", "You never can tell.", "Whose side are you on anyway?", "It was a cold and bleak night...", "...on a long and lonely road", '...the river will deliver your underscore.', 'Do you feel like a God?', 'Power makes you drunk.', 'Horton hears a who?', 'You never think twice...', '...a time or two it was you', '...a time or three it was me', 'You’re as bad as me...', "I tell my friends you’re crazy", "Might be levelling. Might be deshevelling", "The Awakening might be a rude thing", "...someone steps out of the shadows", "Everything is not black and white", "Why do you want to start this fight", "There’s stones in the air", "There’s always someone in your way... with stuff to say", "Might be a good thing … might be a bad thing.", "Might be a first thing … might be a last thing..", "It was a cold and bleak night...", "...on a long and lonely road", 'Yeah, it’s just me, myself and pride.', 'It’s a great day at the CIA', 'I was havin’ a fine time till we intertwined.', 'You’re seein’ red, I see in black and white.', 'I got a big problem that starts with why and ends with y-o-u.', 'I’ve been plotting out words to shout.', 'This conversations overdue.', 'I’ll take it up with you when you call.');

  welcome_messages = new Array('Click more descisions and listen to some tunes', 'Listen to some tunes while you restart and destroy the universe.', 'Listen to some tunes while you draw pictures or jam along with the synth.', 'Click more descisions and watch a video', 'Have you played with the synthesizer yet?', 'Have you drawn anything?', 'Click more descisions, fire up some tunes and follow the lyrics.', 'Horton hears a who?', 'You never think twice...', '...a time or two it was you', "Whose side are you on anyway?", '...a time or three it was me', 'Have you destroyed or restarted East Kins Universe?', '...the river will deliver your underscore.', 'I can read your back page, it’s written on your face', 'You’re as bad as me...', "Who's sayin' what 'bout who", "It feels like a chain I can't break", "I tell my friends you’re crazy", "There’s better days up ahead", "I’ll float through lite as a feather", "Watch out for time and it’s toll", "Trouble's just trouble. We all get into it somehow.", "Flowers or...", "Darkness or...", "The sun is hanging lower...", "Dreams live past the horizon, then fade into the heat...", "Might be levelling. Might be deshevelling...", "The awakening might be a rude thing.", "...someone steps out of the shadows...", "Everything is not black and white.", "I love you, like it or not", "Why do you want to start this fight?", "There’s stones in the air", "There’s always someone in your way... with stuff to say", "Might be a good thing … might be a bad thing...", "Might be a first thing … might be a last thing...", "Might not be anything … might be a lot of things", "You never can tell.", "It was a cold and bleak night...", "...on a long and lonely road", '...the river will deliver your underscore.');

  life_messages = new Array('Click more descisions and listen to some tunes', 'Click more descisions and watch a video', 'Have you played with the synthesizer yet?', 'Horton hears a who?', 'You never think twice...', '...a time or two it was you', '...a time or three it was me', 'Have you destroyed or restarted East Kins Universe?', '...the river will deliver your underscore.', 'I can read your back page, it’s written on your face', 'You’re as bad as me...', "Who's sayin' what 'bout who", "It feels like a chain I can't break", "I tell my friends you’re crazy", "There’s better days up ahead", "Whose side are you on anyway?", "I’ll float through lite as a feather", "Watch out for time and it’s toll", "Count your blessings, hold on tight, don’t let go", "Trouble's just trouble. We all get into it somehow.", "Flowers or...", "Darkness or...", "The sun is hanging lower...", "Dreams live past the horizon, then fade into the heat...", "Might be levelling. Might be deshevelling...", "The awakening might be a rude thing.", "...someone steps out of the shadows...", "Everything is not black and white.", "I love you, like it or not", "Why do you want to start this fight?", "There’s stones in the air", "There’s always someone in your way... with stuff to say", "Might be a good thing … might be a bad thing...", "Might be a first thing … might be a last thing...", "Might not be anything … might be a lot of things", "You never can tell.", "It was a cold and bleak night...", "...on a long and lonely road", '...the river will deliver your underscore.', 'Do you feel like a God?', 'Power makes you drunk.', 'Horton hears a who?', 'You never think twice...', '...a time or two it was you', '...a time or three it was me', 'You’re as bad as me...', "I tell my friends you’re crazy", "Might be levelling. Might be deshevelling", "Count your blessings, hold on tight, don’t let go", "The Awakening might be a rude thing", "...someone steps out of the shadows", "Everything is not black and white", "Why do you want to start this fight", "There’s stones in the air", "There’s always someone in your way... with stuff to say", "Might be a good thing … might be a bad thing.", "Might be a first thing … might be a last thing..", "It was a cold and bleak night...", "...on a long and lonely road", "How long until the first spring?", "Let there be light.", "Once upon a time there was a little... you.", "How will you rule?", "You have created an alternate universe.", "Click East Kin's Universe - reload's East Kin's Universe.");

  welcome_messages.sort(function() {
    return 0.5 - Math.random();
  });

  destruction_messages.sort(function() {
    return 0.5 - Math.random();
  });

  life_messages.sort(function() {
    return 0.5 - Math.random();
  });

  plugWelcome = function(message) {
    if (window.state === 'kin') {
      $('#all-things').text(message);
    }
    if (window.state === 'death') {
      $('#tokyo').text(message);
      $('#all-things').text('');
      $('#life').text('');
    }
    if (window.state === 'life') {
      $('#life').text(message);
      $('#tokyo').text('');
      return $('#all-things').text('');
    }
  };

  tickerText = void 0;

  ticker = function(messages) {
    var offset;
    myStopFunction();
    offset = 0;
    return _(messages).each(function(item) {
      tickerText = window.setTimeout((function() {
        plugWelcome(item);
      }), 10000 + offset);
      return offset += 15000;
    });
  };

  myStopFunction = function() {
    var results;
    results = [];
    while (tickerText--) {
      results.push(window.clearTimeout(tickerText));
    }
    return results;
  };

  pushParticles = function() {
    var i, results;
    Math.sqr = function(a) {
      return a * a;
    };
    Math.randomF = function(min, max) {
      var i;
      return Math.random() * (max - min) + min;
    };

    /* ---- START ---- */
    particles = [];
    gPoints = [];
    i = 0;
    while (i < PARTICLE_NUMBERS) {
      particles.push(new Particle(Math.randomF(0, windowWidth), Math.randomF(0, windowHeight)));
      i++;
    }
    i = 0;
    results = [];
    while (i < GRAVITY_POINT_NUMBERS) {
      gPoints.push(new GravityPoint(Math.randomF(windowWidth * 1, windowWidth - (windowWidth * 1)), Math.randomF(windowHeight * .1, windowHeight - (windowHeight * .1))));
      results.push(i++);
    }
    return results;
  };

  pushParticles();

  fruitLoop();

  canvasResize = function() {
    var oldCanvas;
    oldCanvas = document.getElementById('canvas');
    document.body.removeChild(oldCanvas);
    windowWidth = window.innerWidth;
    windowHeight = window.innerHeight;
    canvas = document.createElement('canvas');
    canvas.id = 'canvas';
    canvas.width = windowWidth;
    canvas.height = windowHeight;
    context = canvas.getContext('2d');
    return document.body.appendChild(canvas);
  };

  blowUpUniverse = function() {
    var atomic_bomb;
    $('.lifeOrDeath').val('death');
    $('#life, #all-things').hide();
    $('#tokyo').show();
    if (window.state !== 'death') {
      ticker(destruction_messages);
    }
    window.state = 'death';
    atomic_bomb = document.getElementById('atomic-bomb');
    atomic_bomb.volume = 0.1;
    $('#atomic-bomb').trigger('play');
    this.gravity = 1000;
    getDist = function(x1, y1, x2, y2) {
      return Math.sqrt(Math.sqr(y2 - y1) + Math.sqr(x2 - x1));
    };

    /* ---- SETTINGS ---- */
    PARTICLE_NUMBERS = 1000;
    GRAVITY_POINT_NUMBERS = 1;
    PARTICULE_SPEED = .3;
    VELOCITY = 1;
    COLORS = ['#F2F3AE', '#ECFF8B', '#FFFCF9', '#E0F2E9', '#FCD9EE', '#F2F3AE', '#ECFF8B', '#FFFCF9', '#E0F2E9', '#FCD9EE', '#F2F3AE', '#ECFF8B', '#FFFCF9', '#E0F2E9', '#FCD9EE', 'orange', 'orange', 'red', 'blue', 'purple', 'red', 'black', 'green'];

    /* ---- Particle ---- */
    Particle = (function() {
      var Particle;
      Particle = function(x, y) {
        _classCallCheck(this, Particle);
        this.x = x;
        this.y = y;
        this.vel = 3;
        this.vel = {
          x: this.vel,
          y: this.vel,
          max: 2
        };
        this.train = [];
        this.color = COLORS[Math.floor(Math.random() * COLORS.length)];
      };
      Particle.prototype.render = function() {
        var i;
        context.beginPath();
        context.strokeStyle = this.color;
        context.lineWidth = .1;
        context.moveTo(this.train[0].x, this.train[0].y);
        i = this.train.length - 1;
        i;
        while (i > 0) {
          context.lineTo(this.train[i].x, this.train[i].y);
          i--;
        }
        context.stroke();
      };
      Particle.prototype.update = function(gPoints) {
        var force;
        force = this.getForceOfNearestGravityPoint();
        this.vel.x += force.x;
        this.vel.y += force.y;
        this.x += this.vel.x * PARTICULE_SPEED;
        this.y += this.vel.y * PARTICULE_SPEED;
        if (Math.abs(this.vel.x) > this.vel.max) {
          this.vel.x *= VELOCITY;
        }
        if (Math.abs(this.vel.y) > this.vel.max) {
          this.vel.y *= VELOCITY;
        }
        this.train.push({
          x: this.x,
          y: this.y
        });
        if (this.train.length > 100) {
          this.train.splice(0, 1);
        }
      };
      Particle.prototype.getForceOfNearestGravityPoint = function() {
        var _this, d, gpSelected, nearestD;
        _this = this;
        gpSelected = void 0;
        nearestD = 99999;
        d = void 0;
        gPoints.map(function(gp) {
          d = getDist(gp.x, gp.y, _this.x, _this.y);
          if (nearestD > d) {
            nearestD = d;
            gpSelected = gp;
          }
        });
        if (gpSelected === void 0) {
          pushParticles();
          return fruitLoop();
        } else {
          return gpSelected.getForceDirection(this.x, this.y, nearestD);
        }
      };
      return Particle;
    })();

    /* ---- GravityPoint ---- */
    GravityPoint = (function() {
      var GravityPoint;
      var n;
      n = Math.abs(Math.floor(Math.random() * (0 - 30)) + 0);
      GravityPoint = function(x, y) {
        _classCallCheck(this, GravityPoint);
        this.x = x;
        this.y = y;
        return this.gravity = 3000;
      };
      GravityPoint.prototype.render = function() {
        context.beginPath();
        context.strokeStyle = '#4F5AF2';
        context.lineWidth = 2;
        context.arc(this.x, this.y, this.gravity, 0, Math.PI * 1);
        context.stroke();
      };
      GravityPoint.prototype.getForceDirection = function(x, y, dist) {
        var F;
        F = this.gravity / dist;
        return {
          x: (this.x - x) * .5 * F,
          y: (this.y - y) * .5 * F
        };
      };
      return GravityPoint;
    })();
    return pushParticles();
  };

  restartUniverse = function() {
    $('.lifeOrDeath').val('life');
    pushParticles();
    fruitLoop();
    $('#tokyo, #tokyo-mobile').hide();
    $('#all-things, #all-things-mobile').hide();
    $('#life, #life-mobile').show();
    if (window.state !== 'life') {
      ticker(life_messages);
    }
    window.state = 'life';
    this.gravity = 0;
    getDist = function(x1, y1, x2, y2) {
      return Math.sqrt(Math.sqr(y2 - y1) + Math.sqr(x2 - x1));
    };

    /* ---- SETTINGS ---- */
    PARTICLE_NUMBERS = randomizeParticle();
    GRAVITY_POINT_NUMBERS = Math.abs(Math.floor(Math.random() * (2 - 100)) + 0);
    PARTICULE_SPEED = Math.abs((Math.random() * (0 - 5)) + 0);
    VELOCITY = Math.abs((Math.random() * (0.5 - 1)) + 0);
    COLORS = ['#F2F3AE', '#ECFF8B', '#FFFCF9', '#E0F2E9', '#FCD9EE'];

    /* ---- Particle ---- */
    Particle = (function() {
      var Particle;
      Particle = function(x, y) {
        _classCallCheck(this, Particle);
        this.x = x;
        this.y = y;
        this.vel = 3;
        this.vel = {
          x: this.vel,
          y: this.vel,
          max: 2
        };
        this.train = [];
        this.color = COLORS[Math.floor(Math.random() * COLORS.length)];
      };
      Particle.prototype.render = function() {
        var i;
        context.beginPath();
        context.strokeStyle = this.color;
        context.lineWidth = .1;
        context.moveTo(this.train[0].x, this.train[0].y);
        i = this.train.length - 1;
        i;
        while (i > 0) {
          context.lineTo(this.train[i].x, this.train[i].y);
          i--;
        }
        context.stroke();
      };
      Particle.prototype.update = function(gPoints) {
        var force;
        force = this.getForceOfNearestGravityPoint();
        this.vel.x += force.x;
        this.vel.y += force.y;
        this.x += this.vel.x * PARTICULE_SPEED;
        this.y += this.vel.y * PARTICULE_SPEED;
        if (Math.abs(this.vel.x) > this.vel.max) {
          this.vel.x *= VELOCITY;
        }
        if (Math.abs(this.vel.y) > this.vel.max) {
          this.vel.y *= VELOCITY;
        }
        this.train.push({
          x: this.x,
          y: this.y
        });
        if (this.train.length > 100) {
          this.train.splice(0, 1);
        }
      };
      Particle.prototype.getForceOfNearestGravityPoint = function() {
        var _this, d, gpSelected, nearestD;
        _this = this;
        gpSelected = void 0;
        nearestD = 99999;
        d = void 0;
        gPoints.map(function(gp) {
          d = getDist(gp.x, gp.y, _this.x, _this.y);
          if (nearestD > d) {
            nearestD = d;
            gpSelected = gp;
          }
        });
        if (gpSelected === void 0) {
          pushParticles();
          return fruitLoop();
        } else {
          return gpSelected.getForceDirection(this.x, this.y, nearestD);
        }
      };
      return Particle;
    })();

    /* ---- GravityPoint ---- */
    GravityPoint = (function() {
      var GravityPoint;
      var n;
      n = Math.abs(Math.floor(Math.random() * (0 - 10)) + 0);
      GravityPoint = function(x, y) {
        _classCallCheck(this, GravityPoint);
        this.x = x;
        this.y = y;
        if (n > 0) {
          this.gravity = 1;
        }
        if (n > 2) {
          this.gravity = 5;
        }
        if (n > 3) {
          this.gravity = 7;
        }
        if (n > 4) {
          this.gravity = 750;
        }
        if (n > 6) {
          this.gravity = 1000;
        }
        if (n > 8) {
          return this.gravity = 10000;
        }
      };
      GravityPoint.prototype.render = function() {
        context.beginPath();
        context.strokeStyle = '#4F5AF2';
        context.lineWidth = 2;
        context.arc(this.x, this.y, this.gravity * 1, 0, Math.PI * 1);
        context.stroke();
      };
      GravityPoint.prototype.getForceDirection = function(x, y, dist) {
        var F;
        F = this.gravity / dist;
        return {
          x: (this.x - x) * .5 * F,
          y: (this.y - y) * .5 * F
        };
      };
      return GravityPoint;
    })();
    return pushParticles();
  };

}).call(this);
