!function($) {
  function PostController() { return this.__constructor.apply(this, arguments); };
  $.extend(PostController.prototype, {
    __constructor: function() {
      // TODO
      this._template = {
        _body: '<div class="post">#{body}</div>',
        apply: function(data) {
          var html = this._body.replace(/#{(\w+)}/g, function(m, key) {
            var text = data[key] || '';
            return text;
          });

          return $(html);
        }
      };
    },

    /**
     * Max count of posts in the page same time.
     * @type Number
     */
    MAX_VISIBLES: 10,

    /**
     * Post data.
     * @type Array
     */
    _posts: null,

    /**
     * Height of the theme.
     * @type Number
     */
    _themeHeight: null,

    /**
     * Start managing.
     */
    start: function() {
      this.showTheme();
      this.loadPosts();
    },

    /**
     * Show theme text in center of the page.
     */
    showTheme: function() {
      var $body = $('body');
      var $text = $('#theme h2');
      $text
        .css({
          left: ($body.width() - $text.outerWidth(true)) / 2,
          top: ($body.height() - $text.outerHeight(true)) / 2
        })
        .fadeIn();
    },

    /**
     * Fetch post data from server in async.
     */
    loadPosts: function() {
      var that = this;

      // TODO: get from server
      setTimeout(function() {
        // make dummy posts
        var posts = that._posts = [];
        for (var i = 0; i < 3; i++) {
          posts.push({
            body: 'わあい50万円　あかり50万円だいすき',
            author: '50歳・会社員・男性'
          });
        }

        // show one (real move)
        that.showPost();
      }, 1);
    },

    /**
     * Add one post in screen and remove oldest one.
     */
    showPost: function() {
      var post = this._fetchPost();
      if (post) {
        this._addPost(post);

        this._updateStyles();
        this._removeOldestPost();

        // next time
        var that = this;
        var interval = 1500;
        setTimeout(function() {
          that.showPost();
        }, interval);
      }
      else {
        this.loadPosts();
      }
    },

    /**
     * Return next post data.
     * @returns {Post} null if no data remains.
     */
    _fetchPost: function() {
      return this._posts.shift();
    },

    /**
     * Add a post view into the page.
     */
    _addPost: function(post) {
      // build
      var template = this._template;
      var $post = template.apply(post);

      // put into the page
      var $canvas = this._getCanvas();
      $canvas.append($post);

      // get position, and not set here to be animated
      var css = this._getPosition($post);

      // centering
      this._centerPost($post);

      // show
      // (wait for applying centered position)
      var that = this;
      css['-webkit-transform'] = 'scale(1)';
      setTimeout(function() {
        $post
          .addClass('ready')
          .css(css);
          that._powan($post);
      }, 1);
    },

    /**
     * Get random position for the element.
     * @param {HtmlElement} $post
     * @returns {Map} left and top.
     */
    _getPosition: function($post) {
      var $canvas = this._getCanvas();
      var canvasWidth = $canvas.width();  // TODO: cache
      var canvasHeight = $canvas.height();  // TODO: cache

      var width = $post.outerWidth(true);
      var height = $post.outerHeight(true);

      return {
        left: (Math.random() * (canvasWidth - width)),
        top: (Math.random() * (canvasHeight - height))
      };
    },

    /**
     * Get random position for the element.
     * @param {HtmlElement} $post
     * @returns {Map} left and top.
     */
    _centerPost: function($post) {
      // TODO: commonize
      var $canvas = this._getCanvas();
      var canvasWidth = $canvas.width();  // TODO: cache
      var canvasHeight = $canvas.height();  // TODO: cache

      var width = $post.outerWidth(true);
      var height = $post.outerHeight(true);

      $post.css({
        left: (canvasWidth - width) / 2,
        top: (canvasHeight - height) / 2
      });
    },

    /**
     * Update post elements style by order.
     */
    _updateStyles: function() {
      // skip newest post that be applied special effect
      // (so i=1 not 0)
      var $posts = this._getPostElements();
      for (var i = 1, l = $posts.length; i < l; i++) {
        var $post = $posts.eq(l-1 -i);

        var scale = 1 - (i / this.MAX_VISIBLES);
        this.setScale($post, scale);
      }
    },

    /**
     * Remove oldest post from page if there are too much.
     */
    _removeOldestPost: function() {
      var $posts = this._getPostElements();
      if ($posts.length > this.MAX_VISIBLES) {
        $posts.eq(0).remove();
      }
    },

    /**
     * Return `.post` elements under canvas element.
     * @returns {HtmlElement} jQuery
     */
    _getPostElements: function() {
      var $canvas = this._getCanvas();
      var $posts = $canvas.children('.post');
      return $posts;
    },

    /**
     * Animate post block.
     * @param {HtmlElement} $post
     */
    _powan: function($post) {
      var INTERVAL = 100;
      var scales = [-2, 20, 0, 10, 0, 5, 0, 2, 0];
      var that = this;
      function push(i) {
        setTimeout(function() {
          that.setScale($post, (100 + scales[i]) /100);
        }, i * INTERVAL);
      }
      for (var i = 0, l = scales.length; i < l; i++) {
        push(i);
      }
    },

    // TODO
    _getCanvas: function() {
      return $('#theme');
    },

    // TODO
    /**
     * Set scale style.
     * @param {HtmlElement} $el
     * @param {Number} scale
     */
    setScale: function($el, scale) {
      $el.css('-webkit-transform', 'scale(' + scale + ')');
    },

    '': null  // banpei : TODO : remove me
  });

  var controller = new PostController();
  controller.start();
}(jQuery);
