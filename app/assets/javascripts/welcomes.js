(function() {
  var COLORS, GRAVITY_POINT_NUMBERS, GravityPoint, PARTICLE_NUMBERS, PARTICULE_SPEED, Particle, VELOCITY, canvas, context, fruitLoop, gPoints, getDist, i, particles, windowHeight, windowWidth, _classCallCheck;

  _classCallCheck = function(instance, Constructor) {
    if (!(instance instanceof Constructor)) {
      throw new TypeError('Cannot call a class as a function');
    }
  };


  /* ---- Functions ---- */

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

  window.setTimeout((function() {
    $('.first .outerLetter.current').addClass('gone');
    $('.letter-container').slideUp('slow');
  }), 10000);

  window.setTimeout((function() {
    $('.second .outerLetter.current').addClass('gone');
  }), 4000);

  window.setTimeout((function() {
    $('.third .outerLetter.current').addClass('gone');
  }), 5000);

  window.setTimeout((function() {
    $('.fourth .outerLetter.current').addClass('gone');
  }), 6000);

  window.setTimeout((function() {
    $('.fifth .outerLetter.current').addClass('gone');
  }), 7000);

  'use strict';


  /* ---- SETTINGS ---- */

  PARTICLE_NUMBERS = 500;

  GRAVITY_POINT_NUMBERS = Math.abs(Math.floor(Math.random() * (0 - 15)) + 0);

  PARTICULE_SPEED = 0.9;

  VELOCITY = .90;

  COLORS = ['#F2F3AE', '#ECFF8B', '#FFFCF9', '#E0F2E9', '#FCD9EE'];


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
      var d, gpSelected, nearestD, _this;
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
      return gpSelected.getForceDirection(this.x, this.y, nearestD);
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
      if (n > 0) {
        this.gravity = 0;
      }
      if (n > 2) {
        this.gravity = Math.abs(Math.random() * (0 - .1) + 0);
      }
      if (n > 7 && n < 13) {
        this.gravity = 200;
      }
      if (n > 13 && n < 19) {
        this.gravity = 500;
      }
      if (n > 18 && n < 24) {
        this.gravity = 800;
      }
      if (n > 23 && n < 27) {
        this.gravity = 1200;
      }
      if (n > 26 && n < 29) {
        this.gravity = 3000;
      }
      if (n > 28 && n < 32) {
        return this.gravity = 0;
      }
    };
    GravityPoint.prototype.render = function() {
      context.beginPath();
      context.strokeStyle = '#4F5AF2';
      context.lineWidth = 2;
      context.arc(this.x, this.y, this.gravity, 0, Math.PI * 2);
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

  context = canvas.getContext('2d');

  canvas.id = 'canvas';

  canvas.width = window.innerWidth;

  canvas.height = window.innerHeight;

  document.body.appendChild(canvas);

  i = 0;

  while (i < PARTICLE_NUMBERS) {
    particles.push(new Particle(Math.randomF(0, windowWidth), Math.randomF(0, windowHeight)));
    i++;
  }

  i = 0;

  while (i < GRAVITY_POINT_NUMBERS) {
    gPoints.push(new GravityPoint(Math.randomF(windowWidth * .01, windowWidth - (windowWidth * .01)), Math.randomF(windowHeight * .01, windowHeight - (windowHeight * .01))));
    i++;
  }

  fruitLoop();

}).call(this);
