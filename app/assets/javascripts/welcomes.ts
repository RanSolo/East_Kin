// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function () {
  $('#lyrics').prepend("<div class='hidden-sm hidden-xs' id='player' style='position: fixed; z-index: -99; width: 100%; height: 100%'></div>");
  // 2. This code loads the IFrame Player API code asynchronously.
  const tag = document.createElement('script');
  const onYouTubeIframeAPIReady = function () {
    let player: any;
    return player = new (YT.Player)('player', {
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

  // 4. The API will call this function when the video player is ready.

  var onPlayerReady = function (event: { target: { stopVideo: () => void; }; }) {
    player.mute();
    event.target.stopVideo();
  };

  var onPlayerStateChange = function (event: any) { };

  const playVideo = function (event: any) {
    player.playVideo();
  };

  const stopVideo = function (event: any) {
    player.stopVideo();
  };

  tag.src = 'https://www.youtube.com/iframe_api';
  const firstScriptTag = document.getElementsByTagName('script')[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
  // 3. This function creates an <iframe> (and YouTube player)
  //    after the API code downloads.
  var player = undefined;
  const done = false;

  // ---
  window.state = 'kin';
  // Here we call we check the width and height anytime it changes we call mobileCart()
  $(window).on('resize oreintationchange', function () {
    canvasResize();
  });

  $(document).scroll(function () {
    canvasResize();
  });
  document.addEventListener('turbolinks:load', function () {
    $('#restart-universe').click(() => restartUniverse());
    $('#blow-up-universe').click(() => blowUpUniverse());
    $('.juke-box').click(() => showJukebox());
    $('.lyrics').click(() => event.target.playVideo());
    return $('.drawing-examples').click(() => showExamples());
  });
  $('#tokyo').hide('slideOut');
  $('#life').hide('slideOut');
  $('#all-things').show('slideIn');
  ticker(welcome_messages);
});

const _classCallCheck = function (instance: any, Constructor: any) {
  if (!(instance instanceof Constructor)) {
    throw new TypeError('Cannot call a class as a function');
  }
};

/* ---- Functions ----*/

var showJukebox = function () {
  if ($('#musicDD').is(':empty')) {
    return $('#musicDD').prepend(
      `<iframe width='100%' height='300' scrolling='no' frameborder='no' src='//w.soundcloud.com/player/?url=https%3A//w.soundcloud.com/playlists/245155799&amp;auto_play=false&amp;hide_related=true&amp;show_comments=false&amp;show_user=false&amp;show_reposts=false'> \
</iframe>`);
  }
};
var showExamples = function () {
  if ($('.example').is(':empty')) {
    return $('.example').prepend(
      `<div class="embed-responsive embed-responsive-16by9"> \
<iframe width="400" height="315" src="//www.youtube.com/embed/yA8gaiW4Bdg" \
frameborder="0" allowfullscreen></iframe> \
</div>`);
  }
};

var fruitLoop = function () {
  context.clearRect(0, 0, canvas.width, canvas.height);
  gPoints.map(function (g: { render: () => void; }, index: any) {
    g.render();
  });
  particles.map(function (p: { update: (arg0: {}) => void; render: () => void; }, index: any) {
    p.update(gPoints);
    p.render();
  });
  requestAnimationFrame(fruitLoop);
};

let getDist = (x1: number, y1: number, x2: number, y2: number) => Math.sqrt(Math.sqr(y2 - y1) + Math.sqr(x2 - x1));

/* ---- SETTINGS ---- */

const randomizeParticle = function () {
  const groupDecider = Math.abs(Math.floor(Math.random() * (0 - 6)) + 0);
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

let PARTICLE_NUMBERS = randomizeParticle();
let GRAVITY_POINT_NUMBERS = Math.abs(Math.floor(Math.random() * (0 - 100)) + 0);
let PARTICULE_SPEED = 0.8;
let VELOCITY = 1;
let COLORS = [
  '#F2F3AE',
  '#ECFF8B',
  '#FFFCF9',
  '#E0F2E9',
  '#FCD9EE',
  'purple',
  'aqua'
];

/* ---- Particle ---- */

let Particle = (function () {
  let Particle: { (x: any, y: any): void; prototype?: any; };

  Particle = function (x: any, y: any) {
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

  Particle.prototype.render = function () {
    context.beginPath();
    context.strokeStyle = this.color;
    context.lineWidth = 1;
    context.moveTo(this.train[0].x, this.train[0].y);
    let i = this.train.length - 1;
    i;
    while (i > 0) {
      context.lineTo(this.train[i].x, this.train[i].y);
      i--;
    }
    context.stroke();
  };

  Particle.prototype.update = function (gPoints: any) {
    const force = this.getForceOfNearestGravityPoint();
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
    //trains
    this.train.push({
      x: this.x,
      y: this.y
    });
    if (this.train.length > 10) {
      this.train.splice(0, 1);
    }
  };

  Particle.prototype.getForceOfNearestGravityPoint = function () {
    const _this = this;
    let gpSelected = undefined;
    let nearestD = 99999;
    let d = undefined;
    gPoints.map(function (gp: { x: any; y: any; }) {
      d = getDist(gp.x, gp.y, _this.x, _this.y);
      if (nearestD > d) {
        nearestD = d;
        gpSelected = gp;
      }
    });
    if (gpSelected === undefined) {
      pushParticles();
      return fruitLoop();
    } else {
      return gpSelected.getForceDirection(this.x, this.y, nearestD);
    }
  };
  return Particle;
})();

/* ---- GravityPoint ---- */

let GravityPoint = (function () {
  let GravityPoint: { (x: any, y: any): number; prototype?: any; };
  const n = Math.abs(Math.floor(Math.random() * (0 - 32)) + 0);
  GravityPoint = function (x: any, y: any) {
    _classCallCheck(this, GravityPoint);
    this.x = x;
    this.y = y;
    if (n > 0) {
      this.gravity = 0;
    }
    if (n > 1) {
      this.gravity = Math.abs((Math.random() * (0 - 20)) + 0);
    }
    if ((n > 8) && (n < 15)) {
      this.gravity = 25;
    }

    if ((n > 14) && (n < 18)) {
      this.gravity = 100;
    }

    if ((n > 17) && (n < 21)) {
      this.gravity = 175;
    }

    if ((n > 20) && (n < 25)) {
      this.gravity = 250;
    }

    if ((n > 24) && (n < 29)) {
      this.gravity = 550;
    }

    if ((n > 28) && (n < 32)) {
      return this.gravity = 650;
    }
  };

  GravityPoint.prototype.render = function () {
    context.beginPath();
    context.strokeStyle = '#4F5AF2';
    context.lineWidth =
      context.arc(this.x, this.y, this.gravity, 0, Math.PI * 1);
    context.stroke();
  };

  GravityPoint.prototype.getForceDirection = function (x: number, y: number, dist: number) {
    const F = this.gravity / dist;
    return {
      x: (this.x - x) * .5 * F,
      y: (this.y - y) * .5 * F
    };
  };

  return GravityPoint;
})();
const sqr = (a: number) => a * a;

const randomF = function (min: number, max: number) {
  let i: any;
  return (Math.random() * (max - min)) + min;
};

/* ---- START ---- */

var particles = [];
var gPoints = [];
let windowWidth = window.innerWidth;
let windowHeight = window.innerHeight;
var canvas = document.createElement('canvas');
canvas.id = 'canvas';
canvas.width = windowWidth;
canvas.height = windowHeight;
var context = canvas.getContext('2d');
document.body.appendChild(canvas);
const destruction_messages = new Array(
  "I felt a great disturbance in the Force,",
  "as if millions of voices suddenly cried out in terror, and were suddenly silenced.",
  "I fear something terrible has happened.",
  "There's beauty in destruction.",
  "So many colors in fire.",
  "Do you feel like a god?",
  "Where is the fun in that",
  "Might be a good King, Might be a bad King.",
  "On your throne... King of the wasteland",
  "The universe is setting like the sun at the end of a long day",
  "Oh No! There Goes Tokyo!",
  "There's beauty in destruction.",
  "So many colors in fire.",
  "Do you feel like a god?",
  'Afirmitive, Dave. I read you.',
  "I'm sorry, Dave. I'm afraid I can't do that.",
  "This Mission is too important for me to allow you jeaprodize it...",
  "I know that you and frank were planning to disconnect me.",
  "...I could see your lips move...",
  "Without your space helmet, Dave? You're gonna find that very difficult...",
  "Dave, this conversation can serve no purpose anymore, goodbye.",
  'Click more descisions and listen to some tunes',
  'Click more descisions and watch a video',
  'Have you played with the synthesizer yet?',
  'Horton hears a who?',
  'You never think twice...',
  '...a time or two it was you',
  '...a time or three it was me',
  'Have you destroyed or restarted East Kins Universe?',
  '...the river will deliver your underscore.',
  'I can read your back page, it’s written on your face',
  'You’re as bad as me...',
  "Who's sayin' what 'bout who",
  "It feels like a chain I can't break",
  "I tell my friends you’re crazy",
  "There’s better days up ahead",
  "I’ll float through lite as a feather",
  "Watch out for time and it’s toll",
  "Trouble's just trouble. We all get into it somehow.",
  "Flowers or...",
  "Darkness or...",
  "The sun is hanging lower...",
  "Dreams live past the horizon, then fade into the heat...",
  "Might be levelling. Might be deshevelling...",
  "The awakening might be a rude thing.",
  "...someone steps out of the shadows...",
  "Everything is not black and white.",
  "I love you, like it or not",
  "Why do you want to start this fight?",
  "There’s stones in the air",
  "There’s always someone in your way... with stuff to say",
  "Might be a good thing … might be a bad thing...",
  "Might be a first thing … might be a last thing...",
  "Might not be anything … might be a lot of things",
  "You never can tell.",
  "Whose side are you on anyway?",
  "It was a cold and bleak night...",
  "...on a long and lonely road",
  '...the river will deliver your underscore.',
  'Do you feel like a God?',
  'Power makes you drunk.',
  'Horton hears a who?',
  'You never think twice...',
  '...a time or two it was you',
  '...a time or three it was me',
  'You’re as bad as me...',
  "I tell my friends you’re crazy",
  "Might be levelling. Might be deshevelling",
  "The Awakening might be a rude thing",
  "...someone steps out of the shadows",
  "Everything is not black and white",
  "Why do you want to start this fight",
  "There’s stones in the air",
  "There’s always someone in your way... with stuff to say",
  "Might be a good thing … might be a bad thing.",
  "Might be a first thing … might be a last thing..",
  "It was a cold and bleak night...",
  "...on a long and lonely road",
  'Yeah, it’s just me, myself and pride.',
  'It’s a great day at the CIA',
  'I was havin’ a fine time till we intertwined.',
  'You’re seein’ red, I see in black and white.',
  'I got a big problem that starts with why and ends with y-o-u.',
  'I’ve been plotting out words to shout.',
  'This conversations overdue.',
  'I’ll take it up with you when you call.'

);
var welcome_messages = new Array(
  'Click more descisions and listen to some tunes',
  'Listen to some tunes while you restart and destroy the universe.',
  'Listen to some tunes while you draw pictures or jam along with the synth.',
  'Click more descisions and watch a video',
  'Have you played with the synthesizer yet?',
  'Have you drawn anything?',
  'Click more descisions, fire up some tunes and follow the lyrics.',
  'Horton hears a who?',
  'You never think twice...',
  '...a time or two it was you',
  "Whose side are you on anyway?",
  '...a time or three it was me',
  'Have you destroyed or restarted East Kins Universe?',
  '...the river will deliver your underscore.',
  'I can read your back page, it’s written on your face',
  'You’re as bad as me...',
  "Who's sayin' what 'bout who",
  "It feels like a chain I can't break",
  "I tell my friends you’re crazy",
  "There’s better days up ahead",
  "I’ll float through lite as a feather",
  "Watch out for time and it’s toll",
  "Trouble's just trouble. We all get into it somehow.",
  "Flowers or...",
  "Darkness or...",
  "The sun is hanging lower...",
  "Dreams live past the horizon, then fade into the heat...",
  "Might be levelling. Might be deshevelling...",
  "The awakening might be a rude thing.",
  "...someone steps out of the shadows...",
  "Everything is not black and white.",
  "I love you, like it or not",
  "Why do you want to start this fight?",
  "There’s stones in the air",
  "There’s always someone in your way... with stuff to say",
  "Might be a good thing … might be a bad thing...",
  "Might be a first thing … might be a last thing...",
  "Might not be anything … might be a lot of things",
  "You never can tell.",
  "It was a cold and bleak night...",
  "...on a long and lonely road",
  '...the river will deliver your underscore.'
);
const life_messages = new Array(
  'Click more descisions and listen to some tunes',
  'Click more descisions and watch a video',
  'Have you played with the synthesizer yet?',
  'Horton hears a who?',
  'You never think twice...',
  '...a time or two it was you',
  '...a time or three it was me',
  'Have you destroyed or restarted East Kins Universe?',
  '...the river will deliver your underscore.',
  'I can read your back page, it’s written on your face',
  'You’re as bad as me...',
  "Who's sayin' what 'bout who",
  "It feels like a chain I can't break",
  "I tell my friends you’re crazy",
  "There’s better days up ahead",
  "Whose side are you on anyway?",
  "I’ll float through lite as a feather",
  "Watch out for time and it’s toll",
  "Count your blessings, hold on tight, don’t let go",
  "Trouble's just trouble. We all get into it somehow.",
  "Flowers or...",
  "Darkness or...",
  "The sun is hanging lower...",
  "Dreams live past the horizon, then fade into the heat...",
  "Might be levelling. Might be deshevelling...",
  "The awakening might be a rude thing.",
  "...someone steps out of the shadows...",
  "Everything is not black and white.",
  "I love you, like it or not",
  "Why do you want to start this fight?",
  "There’s stones in the air",
  "There’s always someone in your way... with stuff to say",
  "Might be a good thing … might be a bad thing...",
  "Might be a first thing … might be a last thing...",
  "Might not be anything … might be a lot of things",
  "You never can tell.",
  "It was a cold and bleak night...",
  "...on a long and lonely road",
  '...the river will deliver your underscore.',
  'Do you feel like a God?',
  'Power makes you drunk.',
  'Horton hears a who?',
  'You never think twice...',
  '...a time or two it was you',
  '...a time or three it was me',
  'You’re as bad as me...',
  "I tell my friends you’re crazy",
  "Might be levelling. Might be deshevelling",
  "Count your blessings, hold on tight, don’t let go",
  "The Awakening might be a rude thing",
  "...someone steps out of the shadows",
  "Everything is not black and white",
  "Why do you want to start this fight",
  "There’s stones in the air",
  "There’s always someone in your way... with stuff to say",
  "Might be a good thing … might be a bad thing.",
  "Might be a first thing … might be a last thing..",
  "It was a cold and bleak night...",
  "...on a long and lonely road",
  "How long until the first spring?",
  "Let there be light.",
  "Once upon a time there was a little... you.",
  "How will you rule?",
  "You have created an alternate universe.",
  "Click East Kin's Universe - reload's East Kin's Universe."
);
welcome_messages.sort(() => 0.5 - Math.random());
destruction_messages.sort(() => 0.5 - Math.random());
life_messages.sort(() => 0.5 - Math.random());
const plugWelcome = function (message: any) {
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

let tickerText = undefined;

var ticker = function (messages: any) {
  myStopFunction();
  let offset = 0;
  return _(messages).each(function (item: any) {
    tickerText = window.setTimeout((function () {
      plugWelcome(item);
    }), 10000 + offset);
    return offset += 15000;
  });
};

var myStopFunction = () => (() => {
  const result = [];
  while (tickerText--) {
    result.push(window.clearTimeout(tickerText));
  }
  return result;
})();


var pushParticles = function () {
  Math.sqr = (a: number) => a * a;
  Math.randomF = function (min: number, max: number) {
    let i: any;
    return (Math.random() * (max - min)) + min;
  };

  /* ---- START ---- */

  particles = [];
  gPoints = [];
  let i = 0;
  while (i < PARTICLE_NUMBERS) {
    particles.push(new Particle(Math.randomF(0, windowWidth), Math.randomF(0, windowHeight)));
    i++;
  }
  i = 0;
  return (() => {
    const result = [];
    while (i < GRAVITY_POINT_NUMBERS) {
      gPoints.push(new GravityPoint(Math.randomF(windowWidth * 1, windowWidth - (windowWidth * 1)), Math.randomF(windowHeight * .1, windowHeight - (windowHeight * .1))));
      result.push(i++);
    }
    return result;
  })();
};
pushParticles();
fruitLoop();
var canvasResize = function () {
  const oldCanvas = document.getElementById('canvas');
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

var blowUpUniverse = function () {
  $('.lifeOrDeath').val('death');
  $('#life, #all-things').hide();
  $('#tokyo').show();
  if (window.state !== 'death') {
    ticker(destruction_messages);
  }
  window.state = 'death';
  const atomic_bomb = document.getElementById('atomic-bomb');
  atomic_bomb.volume = 0.1;
  $('#atomic-bomb').trigger('play');
  this.gravity = 1000;

  getDist = (x1, y1, x2, y2) => Math.sqrt(Math.sqr(y2 - y1) + Math.sqr(x2 - x1));

  /* ---- SETTINGS ---- */
  PARTICLE_NUMBERS = 1000;
  GRAVITY_POINT_NUMBERS = 1;
  PARTICULE_SPEED = .3;
  VELOCITY = 1;
  COLORS = [
    '#F2F3AE',
    '#ECFF8B',
    '#FFFCF9',
    '#E0F2E9',
    '#FCD9EE',
    '#F2F3AE',
    '#ECFF8B',
    '#FFFCF9',
    '#E0F2E9',
    '#FCD9EE',
    '#F2F3AE',
    '#ECFF8B',
    '#FFFCF9',
    '#E0F2E9',
    '#FCD9EE',
    'orange',
    'orange',
    'red',
    'blue',
    'purple',
    'red',
    'black',
    'green'
  ];

  /* ---- Particle ---- */

  Particle = (function () {
    let Particle: { (x: any, y: any): void; prototype?: any; };

    Particle = function (x: any, y: any) {
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

    Particle.prototype.render = function () {
      context.beginPath();
      context.strokeStyle = this.color;
      context.lineWidth = .1;
      context.moveTo(this.train[0].x, this.train[0].y);
      let i = this.train.length - 1;
      i;
      while (i > 0) {
        context.lineTo(this.train[i].x, this.train[i].y);
        i--;
      }
      context.stroke();
    };

    Particle.prototype.update = function (gPoints: any) {
      const force = this.getForceOfNearestGravityPoint();
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
      //trains
      this.train.push({
        x: this.x,
        y: this.y
      });
      if (this.train.length > 100) {
        this.train.splice(0, 1);
      }
    };

    Particle.prototype.getForceOfNearestGravityPoint = function () {
      const _this = this;
      let gpSelected = undefined;
      let nearestD = 99999;
      let d = undefined;
      gPoints.map(function (gp: { x: any; y: any; }) {
        d = getDist(gp.x, gp.y, _this.x, _this.y);
        if (nearestD > d) {
          nearestD = d;
          gpSelected = gp;
        }
      });
      if (gpSelected === undefined) {
        pushParticles();
        return fruitLoop();
      } else {
        return gpSelected.getForceDirection(this.x, this.y, nearestD);
      }
    };
    return Particle;
  })();

  /* ---- GravityPoint ---- */

  GravityPoint = (function () {
    let GravityPoint: { (x: any, y: any): number; prototype?: any; };
    const n = Math.abs(Math.floor(Math.random() * (0 - 30)) + 0);
    GravityPoint = function (x: any, y: any) {
      _classCallCheck(this, GravityPoint);
      this.x = x;
      this.y = y;
      return this.gravity = 3000;
    };

    GravityPoint.prototype.render = function () {
      context.beginPath();
      context.strokeStyle = '#4F5AF2';
      context.lineWidth = 2;
      context.arc(this.x, this.y, this.gravity, 0, Math.PI * 1);
      context.stroke();
    };

    GravityPoint.prototype.getForceDirection = function (x: number, y: number, dist: number) {
      const F = this.gravity / dist;
      return {
        x: (this.x - x) * .5 * F,
        y: (this.y - y) * .5 * F
      };
    };
    return GravityPoint;
  })();

  return pushParticles();
};

var restartUniverse = function () {
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
  // space_ship =  document.getElementById('space-ship')
  // space_ship.volume = 0.1
  // $('#space-ship').trigger('play')

  this.gravity = 0;

  getDist = (x1, y1, x2, y2) => Math.sqrt(Math.sqr(y2 - y1) + Math.sqr(x2 - x1));

  /* ---- SETTINGS ---- */

  PARTICLE_NUMBERS = randomizeParticle();
  GRAVITY_POINT_NUMBERS = Math.abs(Math.floor(Math.random() * (2 - 100)) + 0);

  PARTICULE_SPEED = Math.abs((Math.random() * (0 - 5)) + 0);
  VELOCITY = Math.abs((Math.random() * (0.5 - 1)) + 0);
  COLORS = [
    '#F2F3AE',
    '#ECFF8B',
    '#FFFCF9',
    '#E0F2E9',
    '#FCD9EE'
  ];

  /* ---- Particle ---- */

  Particle = (function () {
    let Particle: { (x: any, y: any): void; prototype?: any; };

    Particle = function (x: any, y: any) {
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

    Particle.prototype.render = function () {
      context.beginPath();
      context.strokeStyle = this.color;

      context.lineWidth = .1;
      context.moveTo(this.train[0].x, this.train[0].y);
      let i = this.train.length - 1;
      i;
      while (i > 0) {
        context.lineTo(this.train[i].x, this.train[i].y);
        i--;
      }
      context.stroke();
    };

    Particle.prototype.update = function (gPoints: any) {
      const force = this.getForceOfNearestGravityPoint();
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
      //trains
      this.train.push({
        x: this.x,
        y: this.y
      });
      if (this.train.length > 100) {
        this.train.splice(0, 1);
      }
    };

    Particle.prototype.getForceOfNearestGravityPoint = function () {
      const _this = this;
      let gpSelected = undefined;
      let nearestD = 99999;
      let d = undefined;
      gPoints.map(function (gp: { x: any; y: any; }) {
        d = getDist(gp.x, gp.y, _this.x, _this.y);
        if (nearestD > d) {
          nearestD = d;
          gpSelected = gp;
        }
      });
      if (gpSelected === undefined) {
        pushParticles();
        return fruitLoop();
      } else {
        return gpSelected.getForceDirection(this.x, this.y, nearestD);
      }
    };
    return Particle;
  })();

  /* ---- GravityPoint ---- */

  GravityPoint = (function () {
    let GravityPoint: { (x: any, y: any): number; prototype?: any; };
    const n = Math.abs(Math.floor(Math.random() * (0 - 10)) + 0);
    GravityPoint = function (x: any, y: any) {
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

    // 1 10 3000

    GravityPoint.prototype.render = function () {
      context.beginPath();
      context.strokeStyle = '#4F5AF2';
      context.lineWidth = 2;
      context.arc(this.x, this.y, this.gravity * 1, 0, Math.PI * 1);
      context.stroke();
    };

    GravityPoint.prototype.getForceDirection = function (x: number, y: number, dist: number) {
      const F = this.gravity / dist;
      return {
        x: (this.x - x) * .5 * F,
        y: (this.y - y) * .5 * F
      };
    };

    return GravityPoint;
  })();

  return pushParticles();
};
