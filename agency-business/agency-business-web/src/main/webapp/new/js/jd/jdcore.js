/**
 * @file 定义了京东通用的核心方法、类以及组件, 所有的京东组件都必须依赖该文件
 *
 * @author Jame.HU
 * @version 1.0
 *
 * @require
 *      jquery.js (1.6+)
 */

(function($) {
    $.extend({
        /**
         * <strong>京东命名空间定义方法</strong>
         *
         * <p>
         * 该方法接受一个点号(.)分割的字符串，之后用点号将其分割到一个子字符串数组， 从左到右遍历进行遍历,
         * 将每个子字符串作为上一级(第一个的上级(即顶级)为window)对象的属性创建一个空对象({}), 最终返回
         * 创建后的对象链。
         *
         * <p>
         * <strong>注：</strong>该方法扩展为了jQuery的静态方法， 以方便调用
         *
         * @param {string} argument[0] 以点号分割的字符串
         * @return {Object} 表示命名空间的对象链
         *
         */
        jdns: function() {
            var ns = window;
            var subNames = arguments[0].split(".");

            var length = subNames.length;
            for (var i = 0; i < length; i ++) {
                if (!ns[subNames[i]]) {
                    ns[subNames[i]] = new Object();
                }
                ns = ns[subNames[i]];
            }

            return ns;
        },

        /**
         * 获取DOM或jQuery对象在当前视口的相对偏移。
         * <p>
         * 返回的对象包含两个整型属性：top 和 left。此方法只对可见元素有效。
         * <p>
         * <strong>注：</strong>
         * 该方法扩展为了jQuery的静态方法， 以方便调用
         *
         * @see jQuery.offset()
         * @param {Object|jQuery} element 用于定位的DOM对象或jQuery对象
         * @return {Object} 返回当前对象相对视口的偏移
         */
        jdElementPos : function(element) {
            return $(element).offset();
        },

        /**
         * 获取得DOM或jQuery对象宽和高。
         * <p>
         * <strong>注：</strong>
         * 该方法扩展为了jQuery的静态方法， 以方便调用
         *
         * @see jQuery.width()
         * @see jQuery.height()
         * @param {Object|jQuery} element 用于定位的DOM对象或jQuery对象
         * @return {Object} 返回当前对象相对视口的偏移
         */
        jdElementSize : function(element) {
            return {
                width : $(element).width(),
                height : $(element).height()
            };
        },

        /**
         * 判定数组是否包含某一特定值。
         * <p>
         * <strong>注：</strong>
         * 该方法扩展为了jQuery的静态方法， 以方便调用
         *
         * @param {Object} array 用于检索特定值的源数组
         * @param {Object} element 用于判定的特定值
         * @param {boolean} identical 是否恒等判断
         *
         * @return {boolean} 如果源数组中包含特定值， 返回true; 否则返回false
         */
        jdInArray : function(array, element, identical) {
            // 是否恒等判断？ 默认为非恒等
            var isIdentical = identical ? true : false;
            if (array instanceof Array) {
                for (var i = 0; i < array.length; i ++) {
                    var isEqual = isIdentical
                            ? (array[i] === element)
                            : (array[i] == element);
                    if (isEqual) {
                        return true;
                    }
                }
            }

            return false;
        },

        jdGetJqField: function(element, context) {
            var jqField = null;
            if (typeof element === "string") {
                // ID唯一标识
                jqField = $("#" + element, context);

                // 试图使用name查找
                if (jqField.length < 1) {
                    jqField = $("[name=" + element + "]", context);
                }
            } else if (element.nodeType) {  // DOMElement
                jqField = $(element);
            } else if (element instanceof jQuery) {
                jqField = element;
            }

            return jqField;
        },

        jdGetFieldValue: function(element, context) {
            var jqField = $.jdGetJqField(element, context);
            return jqField ? jqField.val() : null;
        }
    });

    $.fn.extend({
        jdCenter : function() {
            var top = ($(window).height() - this.height()) / 2;
            var left = ($(window).width() - this.width()) / 2;

            var scrollTop = $(document).scrollTop();
            var scrollLeft = $(document).scrollLeft();

            return this.css({
                position : 'absolute',
                top : top + scrollTop,
                left : left + scrollLeft
            });
        },

        jdAbsoluteLocate : function(pos) {
            return this.css({
                position : 'absolute',
                top : pos.top,
                left : pos.left
            });
        }
    });

})(jQuery);


(function($) {
    /**
     * @namespace com
     */

    /**
     * @namespace com.jd
     * @memberof com
     */

    /**
     * @namespace com.jd.core
     * @memberof com.jd
     */

    var namespace = $.jdns("com.jd.core");

    var Validator = com.jd.core.Validator;


    //-----------------------------------------------------------
    // Ajax async requester to send asynchronous request and   
    // handle the response.
    //-----------------------------------------------------------
    /**
     * @name AjaxRequester
     * @memberof com.jd.core
     * @constructor
     *
     * @param {string} url HTTP请求URL
     * @param {String|Object} param url请求参数串或json格式表示的key、value对
     * @param {Object} [options]  传递给jQuery.ajax方法的参数, 具体可见jQuery.ajax()
     *
     * @param {boolean} [displayLoading] 是否显示加载进度条, 默认为false不显示
     *
     */
    var AjaxRequester = namespace.AjaxRequester
            = function(url, param, options, displayLoading) {
        this.url = url;
        this.param = param;

        this.enableLoading = displayLoading || false;
        this._buildRequestOptions(options);
    };

    AjaxRequester.prototype = /** @lends com.jd.core.AjaxRequester.prototype */{
        /**
         * @desc 发送ajax异步请求，此方法一般在创建完AjaxRequester对象后直接调用。
         */
        send : function() {
            this._startLoading();
            $.ajax(this.options);
        },

        setOptions : function(options) {
            this.options = $.extend({}, this.options, options);
            return this;
        },

        _buildRequestOptions : function(options) {
            this.options = $.extend({}, AjaxRequester.defaultOptions,
                    options, {
                url : this.url,
                data: this.param
            });
        },

        _startLoading : function() {
            if (this.enableLoading) {
                this.loadingProgressBar = new com
                        .jd.core.widget.LoadingProgressBar();
                this.options.loadingProgressBar = this.loadingProgressBar;
            }
        }
    };

    /**
     * @class
     * @name DefaultOptions
     * @memberof com.jd.core.AjaxRequester
     * @desc  针对于京东业务背景实现的默认ajax可选项配置
     */
    AjaxRequester.defaultOptions = {
        dataType : "json",
        type : "POST",
        cache : false,

        /**
         * @memberof com.jd.core.AjaxRequester.DefaultOptions
         * @desc 请求成功时， 判断返回的响应结果， 如果状态码为200才按成功处理，否则
         * 统一按失败来处理
         *
         * @param {Object} data 服务端的返回json格式响应结果
         * @param {string} textStatus
         */
        success : function(data, textStatus) {
            if (Validator.isNull(data)) {
                this.error(null, "响应结果为null");
                return;
            }

            var resultCode = data.code;
            var resultMessage = data.message;

            if (resultCode == "FPXS0000") {
                this.successCallback(data, textStatus)
            } else {
                this.error(null, resultMessage, data);
            }
        },

        /**
         * @desc 抽象模板方法， 当判定响应结果状态码为200时调用，子类必须覆盖该方法来实现具体的成功处理
         *
         * @memberof com.jd.core.AjaxRequester.DefaultOptions
         *
         * @param {Object} data
         * @param {string} textStatus
         */
        successCallback : function(data, textStatus) {
            // Sub class to implement concrete processing logic
        },

        /**
         * @desc 请求失败时的回调函数
         * @memberof com.jd.core.AjaxRequester.DefaultOptions
         *
         * @param {Object} xmlHttpRequest 原始的XmlHttpRequest请求对象
         * @param {string} textStatus
         * @param {Object} errorThrown
         */
        error : function(xmlHttpRequest, textStatus, errorThrown) {
            var messageText = "";
            var result = null;
            if (xmlHttpRequest == null) {
                messageText = textStatus;
                result = errorThrown;
            } else {
                messageText = "异步请求出错";
            }

            this.errorCallback(messageText, result);
        },

        /**
         * @desc 请求失败时处理错误消息的回调函数
         * @memberof com.jd.core.AjaxRequester.DefaultOptions
         * @param {string} message 错误消息文本
         */
        errorCallback : function(message, data) {
            var MessageTooltip = com.jd.core.widget.MessageTooltip;
            new MessageTooltip(message, {
                zIndex: 3000
            }, {
                messageTextClass : "errorTip"
            });
        },

        /**
         * 请求完成时的回调函数， 主要实现了隐藏加载进度条的功能
         *
         * @memberof com.jd.core.AjaxRequester.DefaultOptions
         *
         * @param {Object} XMLHttpRequest 原始的XmlHttpRequest请求对象
         * @param {Object} textStatus
         */
        complete : function(XMLHttpRequest, textStatus) {
            if (this.loadingProgressBar) {
                this.loadingProgressBar.close();
            }
        }
    };

    //-----------------------------------------------------------
    // String formatter object to replace '${variable name}' 
    // appear in the formatted string using the specified source
    //-----------------------------------------------------------
    /**
     *
     * @name Formatter
     * @memberof com.jd.core
     * @class
     * @desc 字符串格式化工具类
     *
     */
    var Formatter = namespace.Formatter = {
        /**
         * 匹配格式化字符串中占位符的正则表达式
         *
         * @memberof com.jd.core.Formatter
         */
        regex : /[$][{]([a-zA-Z0-9]+)[}]/,

        /**
         * 使用对象中的属性值来替换个格式化字符中的占位符， 并返回被格式化后的字符串
         *
         * @memberof com.jd.core.Formatter
         *
         * @param {Object} srcObj
         * @param {string} pattern
         *
         * @return {string} 返回格式化后的字符串
         */
        format : function(srcObj/* Object */, pattern/* String */) {
            var formatedVal = pattern;

            var matchResult = formatedVal.match(this.regex);
            while (matchResult != null) {
                var first = matchResult[0];
                var second = matchResult[1];

                var replaceStr = srcObj[second] || "";
                formatedVal = formatedVal.replace(first, replaceStr);

                matchResult = formatedVal.match(this.regex);
            }

            return formatedVal;
        }
    };

    /**
     * @class
     * @name SelectorBuilder
     * @memberof com.jd.core
     * @desc jQuery选择符构建器
     * <p>
     * 该类提供了静态工具方法用于构建jQuery的id选择符和class选择符
     */
    var SelectorBuilder = namespace.SelectorBuilder = {
        idPrefix : "#",
        classPrefix : ".",

        emptyChar : "",

        defaultSeperator : "",

        /**
         * 连接两个给定的字符串
         *
         * @memberof com.jd.core.SelectorBuilder
         *
         * @param {string} first
         *         要合并的字符串前缀
         * @param {string} second
         *         要合并的字符串后缀
         * @return {string}
         *         返回由两个字符串合并后的新字符串, 如果两个参数都为null或undefined, 返回空字符串(""),
         *         如果其中一个参数为null或undefined,则返回另一个参数
         */
        mergeString : function(first/* String */, second/* String */) {
            return (first || this.emptyChar) + (second || this.emptyChar);
        },

        /**
         * 使用给定的分隔符连接字符串数组元素并返回合并后的字符串
         *
         * @memberof com.jd.core.SelectorBuilder
         *
         * @param {Array} strings
         *         字符串或字符串数组, 对于其他类型统一不做处理直接返回空字符("")
         * @param {string} seperator
         *         字符连接分隔符, 如果没有指定或指定了为null或undefined，则使用默认的分隔符("")来做连接操作
         * @return {string}
         *         如果参数strings是字符串类型， 则直接返回该字符串，如果是数组类型则做连接操作，然后
         *         返回连接后的字符串， 其他情况则统一返回一个空字符串("")
         */
        mergeStrings : function(strings/* Array */, seperator/* String */) {
            if (typeof strings == "string") {
                return strings;
            }

            if (strings instanceof Array) {
                return strings.join(seperator || this.defaultSeperator);
            }

            return this.emptyChar;
        },

        /**
         * 构建一个id选择符
         * <p>
         * 该方法连接传入的各个参数字符串， 最终加上前缀'#'返回
         *
         * @memberof com.jd.core.SelectorBuilder
         *
         * @param {...String} arguments
         *         js函数内置数组参数,该参数接收调用该方法时实际传入的参数
         * @return {string} 连接后的格式为[#]\w*字符串
         *         如果不传参数，则直接返回#; 如果传入的参数为null或者undefined,
         *         则将用空字符串""替换后再做连接操作
         */
        buildIdSelector : function() {
            if (arguments.length < 1) {
                return this.idPrefix;
            }

            var newArgs = [];
            for (var i = 0; i < arguments.length; i ++) {
                newArgs.push(arguments[i] || this.emptyChar);
            }

            var idSelector = "";
            if (arguments[0].indexOf(this.idPrefix) == 0) {
                idSelector = this.mergeStrings(newArgs);
            } else {
                idSelector = this.idPrefix + this.mergeStrings(newArgs);
            }

            return idSelector;
        },

        /**
         * 构建一个class选择符
         * <p>
         * 该方法连接传入的各个参数字符串， 最终加上前缀'.'返回
         *
         * @memberof com.jd.core.SelectorBuilder
         *
         * @param {...String} arguments
         *         js函数内置数组参数,该参数接收调用该方法时实际传入的参数
         * @return {string} 连接后的格式为[.]\w*字符串
         *         如果不传参数，则直接返回'.'; 如果传入的参数为null或者undefined,
         *         则将用空字符串""替换后再做连接操作
         */
        buildClassSelector : function() {
            if (!arguments || arguments.length < 1) {
                return this.classPrefix;
            }

            var newArgs = new Array();
            for (var i = 0; i < arguments.length; i ++) {
                newArgs.push(arguments[i] || this.emptyChar);
            }

            return this.classPrefix + this.mergeStrings(newArgs);
        }
    }

    var Validator = namespace.Validator = {
        isNull : function(value) {
            return typeof value === 'undefined'
                    || value === null;
        },

        isEmpty : function(value) {
            return typeof value === 'undefined'
                    || value === null
                    || (typeof value === "string"
                    && $.trim(value) == "");
        },

        isString : function(value) {
            return typeof value === "string";
        },

        isNumber : function(value) {
            return typeof value === "number";
        },

        asNumber : function(value) {
            if (this.isEmpty(value)) {
                return false;
            }

            if (!this.isString(value)) {
                value = value.toString();
            }

            var pattern = /^[\-\+]?((([0-9]{1,3})([,][0-9]{3})*)|([0-9]+))?([\.]([0-9]+))?$/;
            return this.doRegExpMatch(value, pattern);
        },

        isFunction : function(func) {
            return typeof func === "function";
        },

        /**
         * 校验被指定的字符串是否为有效的日期格式
         *
         * @param {string} 日期字符串
         * @return 如果为合法的日期字符串返回true, 否则返回false
         */
        isDate: function (value) {
            var dateRegEx = new RegExp(/^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(?:(?:0?[1-9]|1[0-2])(\/|-)(?:0?[1-9]|1\d|2[0-8]))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(0?2(\/|-)29)(\/|-)(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\d\d)?(?:0[48]|[2468][048]|[13579][26]))$/);
            return this.doRegExpMatch(value, dateRegEx);
        },
        /**
         * 校验被指定的字符串是否为合法的日期时间格式
         *
         * @param {string} 日期时间字符串
         * @return 如果为合法的日期时间字符串返回true, 否则返回false
         */
        isDateTime: function (value) {
            var dateTimeRegEx = new RegExp(/^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1}$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^((1[012]|0?[1-9]){1}\/(0?[1-9]|[12][0-9]|3[01]){1}\/\d{2,4}\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1})$/);
            return this.doRegExpMatch(value, dateTimeRegEx);
        },

        doRegExpMatch : function(value, pattern) {
            if (this.isNull(value)) {
                return false;
            }

            if (this.isString(pattern)) {
                pattern = new RegExp(pattern);
            }

            if (!pattern instanceof RegExp) {
                return false;
            }

            return pattern.test(value);
        },

        dateCompare: function (start, end) {
            return (new Date(start.toString()) <= new Date(end.toString()));
        }
    }

    //-----------------------------------------------------------
    // A simple Map Object to store and retrieve 
    // the key value pair
    //-----------------------------------------------------------
    /**
     * @name Map
     * @memberof com.jd.core
     * @constructor
     * @desc 实现同Java中Map相似功能的容器对象， 用于方便存取键值对。
     *
     * @param {Array} src 初始化Map的数组
     * @param {string} keyName 初始化Map时用作key的数组元素的属性名
     */
    var Map = namespace.Map = function(src, keyName, valueName) {
        this.entries = new Array();
        if (src instanceof Array) {
            for (var i = 0; i < src.length; i ++) {
                var key = src[i][keyName] || src[i]["key"];
                var value = src[i][valueName] || src[i]["value"];
                this.put(key, value);
            }
        }
    };

    Map.prototype = /** @lends com.jd.core.Map.prototype */{
        /**
         *
         * 向Map容器中存放键值对。
         * <p>
         * 如果Map中key存在对应的值， 则先移除之前存放的旧值， 然后将新值value存放进去
         *
         * @param {Object} key
         * @param {Object} value
         *
         * @return 如果key有对应的值， 则移除旧值并返回该旧值， 否则返回undefined
         */
        put : function (key, value) {
            var foundEntry = this.get(key);
            if (foundEntry != null) {
                this.remove(key);
            }

            this.entries.push({
                key : key,
                value : value
            });

            return foundEntry;
        },

        /* Object */
        remove : function(key) {
            var removedEntry = null;

            for (var i = 0; i < this.entries.length; i ++) {
                var entry = this.entries[i];
                if (key == entry.key) {
                    removedEntry = entry;
                    this.entries.splice(i, 1);
                    break;
                }
            }

            return removedEntry;
        },

        /* Object */
        get : function(key) {
            var foundEntry = null;

            for (var i = 0; i < this.entries.length; i ++) {
                var entry = this.entries[i];
                if (key == entry.key) {
                    foundEntry = entry;
                    break;
                }
            }

            return foundEntry ? foundEntry.value : null;
        },

        /* boolean */
        containKey : function(key) {
            return this.get(key) != null;
        },

        /* Array */
        keySet : function() {
            var keys = new Array();

            for (var i = 0; i < this.entries.length; i ++) {
                keys.push(this.entries[i].key);
            }

            return keys;
        },

        /* Array */
        entrySet : function() {
            var entries = new Array();

            for (var i = 0; i < this.entries.length; i ++) {
                entries.push(this.entries[i]);
            }

            return entries;
        },

        /* Void */
        clear : function() {
            this.entries.splice(0, this.size());
        },

        /* Integer */
        size : function() {
            return this.entries.length;
        }
    };

    var RelativeLocator = namespace.RelativeLocator = {
        center : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);
            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top + ($(element).height() - size.height) / 2 + offset.top;
            var newLeft = elementPos.left + ($(element).width()
                    - size.width) / 2 + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        top : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);
            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top - size.height + offset.top;
            var newLeft = elementPos.left + ($(element).width()
                    - size.width) / 2 + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        right : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);

            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top + ($(element).height() - size.height) / 2 + offset.top;
            var newLeft = elementPos.left + $(element).width() + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        bottom : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);
            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top + $(element).height() + offset.top;
            var newLeft = elementPos.left + ($(element).width()
                    - size.width) / 2 + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        left : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);
            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top + ($(element).height()
                    - size.height) / 2 + offset.top;
            var newLeft = elementPos.left - size.width + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        leftTop : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);
            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top + offset.top;
            var newLeft = elementPos.left - size.width + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        rightTop : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);

            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top + offset.top;
            var newLeft = elementPos.left + $(element).width() + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        leftBottom : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);
            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top + $(element).height() - size.height + offset.top;
            var newLeft = elementPos.left - size.width + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        rightBottom : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);

            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top + $(element).height() - size.height + offset.top;
            var newLeft = elementPos.left + $(element).width() + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        topLeft : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);
            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top - size.height + offset.top;
            var newLeft = elementPos.left + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        topRight : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);
            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top - size.height + offset.top;
            var newLeft = elementPos.left + $(element).width()
                    - size.width + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        bottomLeft : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);
            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top + $(element).height() + offset.top;
            var newLeft = elementPos.left + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        bottomRight : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);
            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top + $(element).height() + offset.top;
            var newLeft = elementPos.left + $(element).width() - size.width + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        innerTop : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);
            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top + offset.top;
            var newLeft = elementPos.left + ($(element).width()
                    - size.width) / 2 + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        innerBottom : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);
            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top + $(element).height() - size.height + offset.top;
            var newLeft = elementPos.left + ($(element).width()
                    - size.width) / 2 + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        innerLeft : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);
            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top + ($(element).height()
                    - size.height) / 2 + offset.top;
            var newLeft = elementPos.left + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        innerRight : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            var size = $.jdElementSize(targetEl);
            var elementPos = $.jdElementPos(element);

            var newTop = elementPos.top + ($(element).height()
                    - size.height) / 2 + offset.top;
            var newLeft = elementPos.left + $(element).width()
                    - size.width + offset.left;

            $(targetEl).jdAbsoluteLocate({
                top : newTop,
                left : newLeft
            });
        },

        wcenter : function(element/* DOM Object/jQuery Object */, targetEl/* DOM Object/jQuery Object */, offset/* Object */) {
            $(targetEl).jdCenter();
        }
    }

})(jQuery);


(function($) {
    // 核心组件包命名空间
    var namespace = $.jdns("com.jd.core.widget");

    /**
     * @namespace widget
     * @memberof com.jd.core
     */

    // 导入SelectorBuilder类
    var SelectorBuilder = com.jd.core.SelectorBuilder;
    var Formatter = com.jd.core.Formatter;
    var RelativeLocator = com.jd.core.RelativeLocator;


    //--------------------------------------------------------------
    // 组件名称： 通用的确认对话框组件
    // 开发者：Jame.HU
    // 开发日期：2013-06-03
    //--------------------------------------------------------------
    /**
     * @name ConfirmDialog
     * @memberof com.jd.core.widget
     *
     * @desc
     * <strong>
     * 通用的确认对话框组件
     * </strong>
     * <p>
     * 它是<code>window.confirm()</code>的一个变体实现.不仅实现了confirm的消息确认功能,
     * 还可以由调用者灵活的更改其长相. 但由于js引擎本身没有提供开发者'挂起'功能，所以采用回调的方式去
     * 模拟实现等待用户操作的效果.故构造函数第一个参数接收回调函数去响应用户点击确定事件， 取消和关闭按钮
     * 仅仅触发确认框关闭效果
     *
     * @constructor
     *
     * @param {Function} sureCallback 当触发确认操作时的回调函数
     * @param {Object} [options] 描述确认框样式、标题、消息以及区域ID的可选对象, 如果不传
     *         该参数, 则使用组件默认可选项来渲染组件. 具体可设置属性看：
     *         {@link com.jd.core.widget.ConfirmDialog.defaultOptions}
     * @see {@link com.jd.core.widget.ConfirmDialog.defaultOptions}
     */
    var ConfirmDialog = namespace.ConfirmDialog
            = function(sureCallback/* Function */, options/* Object */) {
        this.sureCallback = sureCallback;
        this.options = $.extend({}, ConfirmDialog.defaultOptions, options);

        this._initialize();
    };

    ConfirmDialog.prototype = /** @lends com.jd.core.widget.ConfirmDialog.prototype */{
        constructor : ConfirmDialog,

        _initialize : function() {
            this._prepareData();
            this.initialDialog();
        },

        _prepareData : function() {
            this.dialogDivSelector = SelectorBuilder.
                    buildIdSelector(this.options["dialogDivId"]);

            this.sureButtonSelector = SelectorBuilder.
                    buildIdSelector(this.options["sureButtonId"]);
            this.cancelButtonSelector = SelectorBuilder.
                    buildIdSelector(this.options["cancelButtonId"]);
            this.closeButtonSelector = SelectorBuilder.
                    buildIdSelector(this.options["closeButtonId"]);

            this.titleDivSelector = SelectorBuilder.buildIdSelector(this.options["titleDivId"]);
            this.containerIdSelector = SelectorBuilder.buildIdSelector(this.options["messageDivId"]);
        },

        initialDialog : function() {
            if ($(this.dialogDivSelector).length == 0) {
                var formattedHtml = Formatter.format(
                        this.options, ConfirmDialog.HTML);
                $("body").append(formattedHtml);

                // 添加窗口大小改变事件处理器去调整位置
                var oThis = this;
                var resizeCallback = function() {
                    oThis.adjust();
                };

                $(window).resize(resizeCallback);
                $(window).scroll(resizeCallback);
            } else {
                this.reset();
            }

            // 设置z-index属性
            $(this.dialogDivSelector).css(
                    "z-index", this.options.zIndex);

            this.bindEventListener();

            this.open();
        },

        bindEventListener : function() {
            var oThis = this;
            $(this.sureButtonSelector).unbind('click')
                    .bind('click', function() {
                oThis.close();
                oThis.sureCallback();
            });

            var closeCallback = function() {
                oThis.close();
            };

            $(this.cancelButtonSelector).unbind('click')
                    .bind('click', closeCallback);
            $(this.closeButtonSelector).unbind('click')
                    .bind('click', closeCallback);
        },

        reset : function() {
            $(this.titleDivSelector).html(this.options["title"]);
            $(this.containerIdSelector).html(this.options["message"]);
        },

        /**
         * 打开确认对话框
         */
        open : function() {
            if (!this.maskLayer) {
                this.maskLayer = new MaskLayer(
                        this.options.dialogDivId + "_mask_layer",
                        null, {
                    zIndex: this.options.zIndex - 1
                });
            }
            this.maskLayer.open();

            this.adjust();
            $(this.dialogDivSelector).show();
        },

        /**
         * 关闭确认对话框
         */
        close : function() {
            $(this.dialogDivSelector).hide();
            this.maskLayer.close();
        },

        adjust : function() {
            $(this.dialogDivSelector).jdCenter();
        }
    }

    /**
     * 确认对话框可选项默认配置
     *
     * @class
     * @name defaultOptions
     * @memberof  com.jd.core.widget.ConfirmDialog
     */
    ConfirmDialog.defaultOptions = {
        /**
         * 确认框标题文本
         * @type {string}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default "确认框"
         */
        title : "确认框", // 确认框标题文本
        /**
         * 确认框提示消息文本
         * @type {string}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default "确认要操作吗？"
         */
        message : "确认要操作吗？", // 确认框提示消息文本
        /**
         * 确认框纵向位置, 控制css的z-index属性
         * @type {number}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default 1000
         */
        zIndex : 1000,
        /**
         * 确认框区域id
         * @type {string}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default "jd_confirm_dialog"
         */
        dialogDivId : "jd_confirm_dialog", // 确认框区域id
        /**
         * 确认框标题区域id
         * @type {string}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default "jd_confirm_dialog_title"
         */
        titleDivId : "jd_confirm_dialog_title", // 确认框标题区域id
        /**
         * 确认框标题区域class
         * @type {string}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default "jd_confirm_dialog_message"
         */
        messageDivId : "jd_confirm_dialog_message", // 确认框消息显示区域id
        /**
         * 确认框标题区域id
         * @type {string}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default "jd_confirm_dialog_ok"
         */
        sureButtonId : "jd_confirm_dialog_ok",  // 确认框确认按钮id
        /**
         * 确认框标题区域id
         * @type {string}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default "jd_confirm_dialog_cancel"
         */
        cancelButtonId : "jd_confirm_dialog_cancel", // 确认框取消按钮id
        /**
         * 确认框标题区域id
         * @type {string}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default "jd_confirm_dialog_close"
         */
        closeButtonId : "jd_confirm_dialog_close", // 确认框关闭按钮id
        /**
         * 确认框标题区域id
         * @type {string}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default "jd-confirm-dialog"
         */
        dialogDivClass : "jd-confirm-dialog", // 确认框区域class
        /**
         * 确认框标题区域id
         * @type {string}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default "jd-confirm-dialog-header"
         */
        headerDivClass : "jd-confirm-dialog-header", // 确认框标题区域class
        /**
         * 确认框主题区域class
         * @type {string}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default "jd-confirm-dialog-body"
         */
        bodyDivClass : "jd-confirm-dialog-body", //确认框主题区域class
        /**
         * 确认框关闭按钮class
         * @type {string}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default "jd-confirm-dialog-header-close"
         */
        closeBtnClass : "jd-confirm-dialog-header-close", // 确认框关闭按钮class
        /**
         * 确认框消息显示区域class
         * @type {string}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default "jd-confirm-dialog-message"
         */
        messageDivClass : "jd-confirm-dialog-message", // 确认框消息显示区域class

        /**
         * 确认框确认、取消按钮区域class
         * @type {string}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default "jd-confirm-dialog-footer"
         */
        buttonAreaClass : "jd-confirm-dialog-footer", // 确认框确认、取消按钮区域class
        /**
         * 确认框确认、取消按钮class
         * @type {string}
         * @memberof com.jd.core.widget.ConfirmDialog.defaultOptions
         * @default "jd-confirm-dialog-button"
         */
        buttonClass : "jd-confirm-dialog-button" // 确认框确认、取消按钮class
    };

    /**
     * 确认对话框DOM结构如下：
     *
     * <pre>
     *  &lt;div id='${dialogDivId}' style='display: none; width: 260px;' class='${dialogDivClass}'&gt;
     *       &lt;div class='${headerDivClass}'&gt;
     *           &lt;h3 id='${titleDivId}'&gt;${title}&lt;/h3&gt;
     *           &lt;span id='${closeButtonId}' class='${closeBtnClass}'&gt;关闭&lt;/span&gt;
     *        &lt;/div&gt;
     *        &lt;div class='${&lt;odyDivClass}'&gt;
     *           &lt;p class='${messageDivClass}' id='${messageDivId}'&gt;${message}&lt;/p&gt;
     *           &lt;p class='${buttonAreaClass}'&gt;
     *               &lt;button class='${buttonClass}' id='${sureButtonId}'&gt;确定&lt;/button&gt;
     *               &lt;button class='${buttonClass}' id='${cancelButtonId}'&gt;取消&lt;/button&gt;
     *          &lt;/p&gt;
     *       &lt;/div&gt;
     *   &lt;/div&gt;
     * </pre>
     * @name HTML
     * @memberof  com.jd.core.widget.ConfirmDialog
     */
    ConfirmDialog.HTML =
            "<div id='${dialogDivId}' style='display: none; width: 260px;' class='${dialogDivClass}'>" +
                    "<div class='${headerDivClass}'>" +
                    "<h3 id='${titleDivId}'>${title}</h3>" +
                    "<span id='${closeButtonId}' class='${closeBtnClass}'>关闭</span>" +
                    "</div>" +
                    "<div class='${bodyDivClass}'>" +
                    "<p class='${messageDivClass}' id='${messageDivId}'>${message}</p>" +
                    "<p class='${buttonAreaClass}'>" +
                    "<button class='${buttonClass}' id='${sureButtonId}'>确定</button>" +
                    "<button class='${buttonClass}' id='${cancelButtonId}'>取消</button>" +
                    "</p>" +
                    "</div>" +
                    "</div>";


    //--------------------------------------------------------------
    // 组件名称： 通用消息提示框组件
    // 开发者：Jame.HU
    // 开发日期：2013-06-04
    //--------------------------------------------------------------
    /**
     * @name MessageTooltip
     * @memberof com.jd.core.widget
     *
     * @desc 通用消息提示框组件
     *  <p>
     *  该组件分为两种定位方式：
     *  <ul>
     *      <li>相对定位:相对某个DOM对象可以指定12种不同的位置,详见MessageTooltip.Enum.pos</li>
     *      <li>绝对定位:根据指定的具体top和left绝对定位提示框</li>
     *  </ul>
     *
     *  1. 相对定位：style.type = "relative"
     *  <p>
     *  如果没有指定style.type或指定的值不是有效值, 则使用相对定位作为默认值(即relative).
     *  <p>
     *  当用户指定相对定位时,需要指定一个位置标识符(有效的标识符见MessageTooltip.Enum.pos), 除wcenter
     *  标示符外，其他还需指定'相对物'style.element属性, 该属性可接受页面元素Id, DOM元素以及jQuery对象.
     *  当没有指定style.element时会将style.pos重置为wcenter即居中显示. 除此之外， 还可以指定提示框的宽高
     *  options.size以及偏移量options.offset(详见MessageTooltip.defaultOptions)
     *  <p>
     *
     *     2. 绝对定位：options.type = "absolute"
     *  <p>
     *  当使用绝对定位时, 需指定<i>options.type</i>与<i>options.pos</i>两个属性. 此时options.pos应以格式
     *  {top: val, left: val}指定.
     *
     *  <p>
     *  options.size, options.delay, options.timeout为两种定位的共有属性, 详细见MessageTooltip.defaultOptions
     *
     *  <p>
     *  以下例子简单展示了如果使用该组件：
     *  <p>
     *  1. 相对定位到id为message的DOM元素上右方(topRight)显示
     *  <pre>
     *      var MessageTooltip = com.jd.core.widget.MessageTooltip;
     *
     *      new MessageTooltip("恭喜您，删除店铺信息成功！", {
     *          type : "relative", //可以不写，默认就是这个了
     *          element : "message", //如果不填写则居中显示
     *          pos : "topRight",  //如果不填写则居中显示
     *          size : { //可选属性
     *              width: "200px",
     *              height: "30px"
     *          },
     *          delay : "fast", //可选属性
     *          timeout : 3000 //可选属性, 单位ms
     *      });
     *  </pre>
     *  <p>
     *  2. 绝对定位至{top: 500, left: 200}的位置
     *  <pre>
     *      var MessageTooltip = com.jd.merchant.
     *              shop.core.widget.MessageTooltip;
     *
     *      new MessageTooltip("恭喜您，删除店铺信息成功！", {
     *          type : "absolute", //必填哦
     *          pos : { //必填哦
     *              top: 500,
     *              left: 200
     *          },
     *          size : { //可选属性
     *              width: "200px",
     *              height: "30px"
     *          },
     *          delay : "fast", //可选属性
     *          timeout : 3000 //可选属性, ms单位
     *      });
     *  </pre>
     *
     *     @constructor
     *  @param {string} message 需要提示的消息
     *  @param {Object} [options] 详见{@link com.jd.core.widget.MessageTooltip.defaultOptions}
     *
     */
    var MessageTooltip = namespace.MessageTooltip
            = function(message/* String */, options/* Object */) {
        this.message = message;

        this.options = $.extend(true, {},
                MessageTooltip.defaultOptions, options);

        this._initialize();
    };

    MessageTooltip.prototype = /** @lends com.jd.core.widget.MessageTooltip.prototype*/{
        constructor : MessageTooltip,

        _initialize : function() {
            this._prepareData();

            this._initElements();
        },

        _prepareData : function() {
            //如果指定的type是无效的， 则使用relative作为默认
            if (!$.jdInArray(MessageTooltip.Enum.type, this.options.type)) {
                this.options.type = MessageTooltip.Enum.type[0];
            }

            var element = this.options.element;
            // 如果type为relative, 且指定的位置标识符不是有效的或指定的element为空，
            // 则使用wcenter作为默认值做居中显示
            if (this.options.type == MessageTooltip.Enum.type[0]
                    && (!$.jdInArray(MessageTooltip.Enum.pos, this.options.pos)
                    || !element)) {
                this.options.pos = MessageTooltip.Enum.pos[0];
            }

            // 如果传的是字符串， 则作为ID处理
            if (element && typeof element === "string") {
                this.options.element = $(SelectorBuilder.buildIdSelector(element));
            } else if (element && element.nodeType) { // DOM对象
                this.options.element = $(element);
            }

            var containerId = this.options["messageDivId"];
            if (!this.options.singleton &&
                    this.options.type == MessageTooltip.Enum.type[0]) {
            	var elementIdentity = 
            		element.attr("id") || element.attr("name");
            	elementIdentity = elementIdentity.replace(/\.|\[|\]/g, "_");
                containerId = containerId + "_" + elementIdentity;
            }

            this.options.messageDivId = containerId;

            this.containerIdSelector = SelectorBuilder.
                    buildIdSelector(containerId);
            this.visibleContainerIdSelector = SelectorBuilder.
                    buildIdSelector(containerId, ":visible");

            this.messageSpanSelector = SelectorBuilder.
                    buildIdSelector(containerId, " div");
        },

        _initElements : function() {
            if ($(this.containerIdSelector).length < 1) {
                this._create()
            }
        },

        _create : function() {
            var formattedHtml = Formatter.format(
                    this.options, MessageTooltip.HTML);
            $("body").append(formattedHtml);

            this._bindEventListener();
        },

        // 重置时不更新样式
        _reset : function() {
            this._clearTimer();

            this._updateMessage(this.message);
            this._updateZIndex(this.options.zIndex);

            this._adjust();
        },

        _clearTimer : function() {
            var timer = $(this.containerIdSelector).data("timer");
            if (timer) {
                clearTimeout(timer);
                $(this.containerIdSelector).data("timer", null);
                //this.close();
            }
        },

        _updateMessage : function(message) {
            $(this.messageSpanSelector).html(message);
        },

        _updateZIndex: function(zIndex) {
            // 设置z-index属性
            $(this.containerIdSelector).css("z-index", zIndex);
        },

        //绑定窗口大小改变事件处理函数去调提示框的位置
        _bindEventListener : function() {
            var oThis = this;
            var resizeCallback = function() {
                if ($(oThis.visibleContainerIdSelector).length > 0) {
                    oThis._adjust();
                }
            };

            $(window).resize(resizeCallback);
        },

        setMessage : function(message) {
            this.message = message;
            return this;
        },

        setZIndex : function(zIndex) {
            this.options.zIndex = zIndex;
            return this;
        },

        _autoOpenAndClose : function() {
            this._reset();

            $(this.containerIdSelector).fadeIn(this.options.delay);

            var oThis = this;
            var closeCallback = function() {
                $(oThis.containerIdSelector).fadeOut(oThis.options.delay);
            }

            var timer = setTimeout(closeCallback, oThis.options.timeout);
            $(this.containerIdSelector).data("timer", timer);
        },

        _manualOpen : function() {
            if ($(this.containerIdSelector).is(":hidden")) {
                this._reset();
                $(this.containerIdSelector).show();
            }
        },

        /**
         * 手动打开消息提示框，默认情况自动打开消息提示框， 显示一定时间后自动隐藏
         */
        open : function() {
            if (this.options.autoClose) {
                this._autoOpenAndClose();
            } else {
                this._manualOpen();
            }

        },

        /**
         * 手动关闭消息提示框
         */
        close : function() {
            if ($(this.containerIdSelector).is(":visible")) {
                this._clearTimer();
                $(this.containerIdSelector).hide();
            }
        },

        _adjust : function() {
            this._adjustSize();
            this._adjustPosition();
        },

        _adjustSize : function() {
            $(this.containerIdSelector).css(
                    "width", this.options.size["width"]);
            /*$(this.messageDivSelector).css(
             "height", this.options.size["height"]);*/
        },

        _adjustPosition : function() {
            if (this.options.type == MessageTooltip.Enum.type[0]) {
                RelativeLocator[this.options.pos](this.options.element,
                        $(this.containerIdSelector), this.options.offset);
            } else {
                $(this.containerIdSelector).jdAbsoluteLocate(this.options.pos);
            }
        }
    };

    /**
     * 消息提示框支持的定位类型、定位位置枚举
     *
     * @class
     * @name Enum
     * @memberof com.jd.core.widget.MessageTooltip
     */
    MessageTooltip.Enum = {
        /**
         * 消息提示框支持的定位类型枚举:"relative", "absolute"
         *
         * @type {Array}
         * @memberof com.jd.core.widget.MessageTooltip.Enum
         */
        type : ["relative", "absolute"],
        /**
         * 消息提示框支持的定位位置枚举:
         * <pre>
         *      "wcenter", "top", "left", "bottom", "right", "leftTop",
         *       "rightTop", "leftBottom", "rightBottom", "topLeft",
         *       "topRight", "bottomLeft", "bottomRight", "center"
         * </pre>
         * @type {Array}
         * @memberof com.jd.core.widget.MessageTooltip.Enum
         */
        pos : [
            "wcenter", "top", "left", "bottom", "right", "leftTop",
            "rightTop", "leftBottom", "rightBottom", "topLeft",
            "topRight", "bottomLeft", "bottomRight", "center"
        ]
    };


    /**
     * 消息提示框默认可选项
     *
     * @class
     * @name defaultOptions
     * @memberof com.jd.core.widget.MessageTooltip
     */
    MessageTooltip.defaultOptions = {
        singleton: true,
        /**
         * 默认为相对定位中的窗口居中显示, 可用的有效值见{@link com.jd.core.widget.MessageTooltip.Enum.type}
         *
         * @type {string}
         * @memberof com.jd.core.widget.MessageTooltip.defaultOptions
         * @default "relative"
         */
        type : MessageTooltip.Enum.type[0], // 默认为相对定位中的窗口居中显示, 可用的有效值见MessageTooltip.Enum.type
        /**
         * 指定相对某个DOM元素，默认值为null, 此时相对窗口居中显示
         *
         * @type {String|DOM|jQuery}
         * @memberof com.jd.core.widget.MessageTooltip.defaultOptions
         * @default null
         */
        element : null, // 指定相对某个DOM元素
        /**
         * 默认窗口居中显示, 可用的有效值见{@link com.jd.core.widget.MessageTooltip.Enum.pos}
         *
         * @type {string}
         * @memberof com.jd.core.widget.MessageTooltip.defaultOptions
         * @default "wcenter"
         */
        pos : MessageTooltip.Enum.pos[0], // 默认窗口居中显示, 可用的有效值见MessageTooltip.Enum.pos
        /**
         * 当类型为绝对定位时， 该值存储{top:val, left: val}结构对象
         *
         * @type {Object}
         * @memberof com.jd.core.widget.MessageTooltip.defaultOptions
         * @default {left:0, top:0}
         */
        offset : {
            left : 0,
            top : 0
        },

        /**
         * 消息对话框大小
         *
         * @type {Object}
         * @memberof com.jd.core.widget.MessageTooltip.defaultOptions
         * @default {width: "auto", height: "20px"}
         */
        size : {
            width : "auto",
            height : "20px"
        },

        /**
         * 消息对话框纵向位置：z-index
         *
         * @type {number}
         * @memberof com.jd.core.widget.MessageTooltip.defaultOptions
         * @default 910
         */
        zIndex : 910,
        /**
         * 消息提示框打开，关闭时的动画效果
         *
         * @type {string}
         * @memberof com.jd.core.widget.MessageTooltip.defaultOptions
         * @default "slow"
         */
        delay : "slow",
        /**
         * 消息提示框显示时间，以毫秒为单位
         *
         * @type {string}
         * @memberof com.jd.core.widget.MessageTooltip.defaultOptions
         * @default "2000"
         */
        timeout : "2000", // 默认提示框显示时间, 单位毫秒(ms)

        /**
         * 是否自动打开消息提示框， 默认值为true
         *
         * @type {boolean}
         * @memberof com.jd.core.widget.MessageTooltip.defaultOptions
         * @default true
         */
        autoClose : true,

        /**
         * 消息提示框容器id, 详见消息提示框DOM结构：{@link com.jd.core.widget.MessageTooltip.HTML}
         *
         * @type {string}
         * @memberof com.jd.core.widget.MessageTooltip.defaultOptions
         * @default 消息提示框容器样式
         */
        messageDivId : "jd_message_tooltip",
        /**
         * 消息提示框容器样式, 详见消息提示框DOM结构：{@link com.jd.core.widget.MessageTooltip.HTML}
         *
         * @type {string}
         * @memberof com.jd.core.widget.MessageTooltip.defaultOptions
         * @default "jd-message-tooltip"
         */
        messageDivClass : "jd-message-tooltip",

        /**
         * 消息提示框文本显示区域样式, 详见消息提示框DOM结构：{@link com.jd.core.widget.MessageTooltip.HTML}
         *
         * @type {string}
         * @memberof com.jd.core.widget.MessageTooltip.defaultOptions
         * @default "jd-message-tooltip-message"
         */
        messageTextClass : "jd-message-tooltip-message"
    };

    /**
     * 消息提示框DOM结构：
     * <pre>
     * &lt;div id='${messageDivId}' style='display:none;z-index:910;' class='${messageDivClass}'&gt;
     *           &lt;div class='${messageSpanClass}'&gt;消息提示内容&lt;/div&gt;
     *   &lt;/div&gt;;
     * </pre>
     * @name HTML
     * @memberof com.jd.core.widget.MessageTooltip
     */
    MessageTooltip.HTML =
            "<div id='${messageDivId}' style='display:none;z-index:910;' class='${messageDivClass}'>" +
                    "<div class='${messageTextClass}'>消息提示内容</div>" +
                    "</div>";

    //--------------------------------------------------------------
    // 组件名称： 通用遮罩组件
    // 开发者：Jame.HU
    // 开发日期：2013-06-05
    //--------------------------------------------------------------
    /**
     * @name MaskLayer
     * @memberof com.jd.core.widget
     *
     * @desc 通用遮罩组件
     * <p>可以实现全屏遮罩和对某个区域的遮罩
     *
     * 第一个构造参数id用来覆盖遮罩层(div)默认id. 如果不传,则使用默认id(jd_mask_layer)
     * 第二个构造参数element用于指定遮罩层要覆盖的特定区域, 可以是某个区域的id, 也可以是该区域的
     * 的DOM对象,同样也可以是该区域的jQuery对象. 如果不传, 则实现全屏遮罩效果
     *
     * @constructor
     *
     * @param {string} id 用于覆盖遮罩层(div)的默认id
     * @param {string|DOM|jQuery} [element] 指定遮罩层要覆盖的特定区域
     * @param {Object} [options] 遮罩层可选项, 其结构详见：{@link com.jd.core.widget.MaskLayer.defaultOptions}
     */
    var MaskLayer = namespace.MaskLayer = function(id, element, options) {
        this.id = id || MaskLayer.defaultOptions.maskLayerId;
        this.element = element || window;

        this.options = $.extend({},
                MaskLayer.defaultOptions, options);
        this.options.maskLayerId = this.id;

        this._initialize();
    };

    MaskLayer.prototype = /** @lends com.jd.core.widget.MaskLayer.prototype */{
        constructor : MaskLayer,

        _initialize : function() {
            this._prepareData();
            this._initElements();
        },

        _prepareData : function() {
            if (typeof this.element === "string") {
                this.element = $(SelectorBuilder.
                        buildIdSelector(this.element));
            } else {
                this.element = $(this.element);
            }

            this.maskLayerSelector = SelectorBuilder.
                    buildIdSelector(this.options.maskLayerId);
            this.maskLayerDisplaySelector = SelectorBuilder.
                    buildIdSelector(this.options.maskLayerId, ":visible");
        },

        _initElements : function() {
            if ($(this.maskLayerSelector).length < 1) {
                var formattedHtml = Formatter.format(
                        this.options, MaskLayer.HTML);
                $("body").append(formattedHtml);

                this.bindEventListener();
            }

            $(this.maskLayerSelector).css(
                    "z-index", this.options.zIndex);

            this.adjust();
            this.open();
        },

        //绑定窗口大小改变以及滚动时的事件处理函数去调整遮罩层的位置和大小
        bindEventListener : function() {
            var oThis = this;
            var resizeCallback = function() {
                if ($(oThis.maskLayerDisplaySelector).length > 0) {
                    oThis.adjust();
                }
            };

            $(window).resize(resizeCallback);
            $(window).scroll(resizeCallback);
        },

        adjust : function() {
            this.adjustSize();
            this.adjustPosition();
        },

        adjustSize : function() {
            $(this.maskLayerSelector).css("width", this.element.width());
            $(this.maskLayerSelector).css("height", this.element.height());
        },

        adjustPosition : function() {
            var isWindow = this.element[0] == window;

            var scrollTop = $(document).scrollTop();
            var scrollLeft = $(document).scrollLeft();
            if (!isWindow) {
                scrollTop = this.element.offset().top;
                scrollLeft = this.element.offset().left;
            }

            $(this.maskLayerSelector).jdAbsoluteLocate({
                left:scrollLeft,
                top:scrollTop
            });
        },

        /**
         * 打开遮罩层
         */
        open : function() {
            $(this.maskLayerSelector).show();
        },

        /**
         * 关闭遮罩层
         */
        close : function() {
            $(this.maskLayerSelector).hide();
        }
    };

    /**
     * 通用遮罩层DOM结构：
     * <pre>
     *         &lt;div id='${maskLayerId}' style='display:none' class='${maskLayerClass}'&gt;&lt;/div&gt;
     * </pre>
     * @name HTML
     * @memberof com.jd.core.widget.MaskLayer
     */
    MaskLayer.HTML =
            "<div id='${maskLayerId}' style='display:none' class='${maskLayerClass}'></div>";

    /**
     * 通用遮罩层默认可选项
     * @name defaultOptions
     * @class
     * @memberof com.jd.core.widget.MaskLayer
     */
    MaskLayer.defaultOptions = {
        /**
         * 遮罩层区域id
         *
         * @memberof com.jd.core.widget.MaskLayer.defaultOptions
         * @type {string}
         * @default "jd_mask_layer"
         */
        maskLayerId : "jd_mask_layer",
        /**
         * 遮罩层区域样式
         *
         * @memberof com.jd.core.widget.MaskLayer.defaultOptions
         * @type {string}
         * @default "jd-mask-layer"
         */
        maskLayerClass : "jd-mask-layer",
        /**
         * 遮罩层区域默认纵向位置:z-index
         *
         * @memberof com.jd.core.widget.MaskLayer.defaultOptions
         * @type {number}
         * @default 800
         */
        zIndex : 800
    };

    /**
     * <strong>通用加载等待组件</strong>
     * @constructor
     * @name LoadingProgressBar
     * @memberof com.jd.core.widget
     *
     * @param {string} text 加载等待时显示的文本信息， 默认值为“数据加载中...”
     * @param {Object} [options] 可选项， 默认值与可配置字段见：{@link com.jd.core.widget.LoadingProgressBar.defaultOptions}
     */
    var LoadingProgressBar = namespace.LoadingProgressBar = function(text, options) {
        this.options = $.extend({}, LoadingProgressBar.defaultOptions, options);
        this.id = this.options.id;
        this.text = text || this.options.text;

        this._initialize();
    };

    LoadingProgressBar.prototype = /** @lends com.jd.core.widget.LoadingProgressBar.prototype*/{
        constructor : LoadingProgressBar,

        _initialize : function() {
            this._prepareData();
            this._initElements();
            this.adjust();
        },

        _prepareData : function() {
            var parentIdSelector = this.options.parent;
            if (typeof parentIdSelector === "string") {
                if (parentIdSelector == "body") {
                    parentIdSelector = "body";
                } else {
                    parentIdSelector = SelectorBuilder.buildIdSelector(parentIdSelector);
                }
            }

            this.options.parent = this.parent = $(parentIdSelector);

            this.idSelector = SelectorBuilder.buildIdSelector(this.id);
            this.idVisibleSelector = SelectorBuilder.buildIdSelector(this.id, ":visible");
        },

        _initElements : function() {
            if ($(this.idSelector).length == 0) {
                this.createElements();
                this.bindEventListener();
            }

            this.maskLayer = new MaskLayer(null, null, {zIndex : this.options.zIndex - 1});
            this.open();
        },

        createElements : function() {
            var container = $("<div>").attr({
                id : this.id,
                "class" : this.options.containerClass
            });

            $("<img>").attr({
                id : this.id + "_image",
                "class" : this.options.imageClass,
                src : this.options.imageSrc
            }).appendTo(container);

            $("<span>").attr({
                id : this.id + "_text",
                "class" : this.options.textClass
            }).text(this.text).appendTo(container);

            this.parent.append(container);
        },

        bindEventListener : function() {
            var oThis = this;
            var resizeCallback = function() {
                if ($(oThis.idVisibleSelector).length > 0) {
                    oThis.adjust();
                }
            };

            $(window).resize(resizeCallback);
            $(window).scroll(resizeCallback);
        },

        /**
         * 打开加载等待条
         */
        open : function() {
            this.adjust();
            $(this.idSelector).show();
            this.maskLayer.open();
        },

        /**
         * 关闭加载等待条
         */
        close : function() {
            $(this.idSelector).hide();
            this.maskLayer.close();
        },

        adjust : function() {
            this.adjustPosition();
        },

        adjustPosition : function() {
            $(this.idSelector).jdCenter();
        }
    };

    /**
     * 默认可选项
     *
     * @name defaultOptions
     * @class
     * @memberof com.jd.core.widget.LoadingProgressBar
     */
    LoadingProgressBar.defaultOptions = {
        /**
         * 加载等待条默认id
         *
         * @memberof com.jd.core.widget.LoadingProgressBar.defaultOptions
         * @type {string}
         * @default "jd_loading_progress_bar"
         */
        id : "jd_loading_progress_bar",
        /**
         * 加载等待条默认被插入到body中
         *
         * @memberof com.jd.core.widget.LoadingProgressBar.defaultOptions
         * @type {string}
         * @default "body"
         */
        parent : "body",
        /**
         * 加载等待条默认纵向位置
         *
         * @memberof com.jd.core.widget.LoadingProgressBar.defaultOptions
         * @type {number}
         * @default 9999
         */
        zIndex : 9999,

        /**
         * 加载等待条默认显示的文本
         *
         * @memberof com.jd.core.widget.LoadingProgressBar.defaultOptions
         * @type {string}
         * @default "数据加载中..."
         */
        text : "数据加载中...",
        /**
         * 加载等待条默认显示的图片
         *
         * @memberof com.jd.core.widget.LoadingProgressBar.defaultOptions
         * @type {string}
         * @default "/resources/images/widget/loading2.gif"
         */
        imageSrc : "/images/loading.gif",

        /**
         * 加载等待条默认样式
         *
         * @memberof com.jd.core.widget.LoadingProgressBar.defaultOptions
         * @type {string}
         * @default "loading-progress-bar"
         */
        containerClass : "loading-progress-bar",
        /**
         * 加载等待条图片默认样式
         *
         * @memberof com.jd.core.widget.LoadingProgressBar.defaultOptions
         * @type {string}
         * @default "loading-progress-bar-image"
         */
        imageClass : "loading-progress-bar-image",
        /**
         * 加载等待条文本默认样式
         *
         * @memberof com.jd.core.widget.LoadingProgressBar.defaultOptions
         * @type {string}
         * @default "loading-progress-bar-text"
         */
        textClass : "loading-progress-bar-text"
    }


    // 定义构造函数
    var Dialog = namespace.Dialog = function(id, title, options) {
        this.id = id;
        this.title = title || "";
        this.options = $.extend(true, {},
                Dialog.defaultOptions, options);

        this._prepare();

        this._initialize();
    }

    Dialog.prototype = {
        constructor : Dialog,

        // 打开弹出层
        open : function() {
            this._adjust();
            $(this.containerSelector).show();
            if (!this.maskLayer) {
                var maskLayerId = SelectorBuilder.mergeString(
                        this.containerId, "_maskLayer");
                this.maskLayer = new MaskLayer(maskLayerId, null, {
                    zIndex: this.options.zIndex - 1
                });
            } else {
                this.maskLayer.open();
            }

            this._bindEventListener();
            
            if (this.options.onOpen) {
            	this.options.onOpen(this);
            }
        },

        // 关闭弹出层
        close : function(init) {
            this._unbindEventListener();

            $(this.containerSelector).hide();
            if (this.maskLayer) {
                this.maskLayer.close();
            }
            
            if (this.options.onClose && !init) {
            	this.options.onClose(this);
            }
        },

        setTitle : function(title) {
            $(this.containerSelector).find(
                    ".jd-popup-header-title").text(title);
        },

        setContent : function(content) {
            $(this.idSelector).text(content);
        },

        //------------------------------------------------
        // ~~ 以下划线(_)开头的方法视为私有方法，只提供类内部调用， doc文档
        // 不会对其暴露
        //------------------------------------------------
        _adjust : function() {
            $(this.containerSelector).jdCenter();
        },

        // 初始化弹出层， 如果弹出层不存在则创建，如果存在则打开弹出层
        _initialize : function() {
            if (!this.options.ignoreContainer
                    && !this._hasContainer()) {
                this._createDialog();
            }

            if (this.options.autoClose) {
                this.open();
            } else {
                this.close(true);
            }
        },

        _hasContainer : function() {
            return $(this.containerSelector).length > 0;
        },

        // 绑定窗口改变大小及滚动的事件监听器， 实现居中显示
        _bindEventListener : function() {
            var oThis = this;
            var resizeCallback = function() {
                oThis._adjust();
            };

            $(window).bind("resize." + this.containerId, resizeCallback);
            $(window).bind("scroll." + this.containerId, resizeCallback);
        },

        _unbindEventListener : function() {
            $(window).unbind("resize." + this.containerId);
            $(window).unbind("scroll." + this.containerId);
        },

        _createDialog : function() {
            var container = $("<div>").
            	addClass("jd-popup").
            	attr({
            		"id" : this.containerId
                }).css("width", this.options.size.width + "px")
                .css("height", this.options.size.height + "px");

            container.css(
                    "z-index", this.options.zIndex);

            if (this.options.popupClass) {
                container.addClass(this.options.popupClass);
            }

            $(this.parent).append(container);

            container.append(this._createHeader());
            container.append(this._createBody());

            // 如果不忽略尾部
            if (!this.options.ignoreFooter) {
                container.append(this._createFooter());
            }

            this._adjustBodySize();
        },

        _createHeader : function() {
            var header = $("<div>").addClass(
                    "jd-popup-header");

            header.append($("<h3>").addClass(
                    "jd-popup-header-title")
                    .text(this.title));
            header.append($("<a>").addClass(
                    "jd-popup-header-close")
                    .attr({
                              "href": "javascript:void(0)",
                              title: this.options.closeText
                          }));

            var oThis = this;
            header.find(".jd-popup-header-close")
                    .bind("click", function() {
                if (oThis.options.closeCallback) {
                    oThis.options.closeCallback.call(oThis);
                }
            })

            return header;
        },

        _createBody : function() {
            var body = $("<div>").addClass("jd-popup-body");

            body.append($(this.idSelector).css("display", "").detach());

            return body;
        },

        // 根据弹出层、头部、尾部高度计算剩余body的高度
        _adjustBodySize : function() {
            var popupHeight = $(this.containerSelector).height();
            var headerHeight = $(this.containerSelector).
                    find(".jd-popup-header").height();
            var bodyHeight = popupHeight - headerHeight;

            if (!this.options.ignoreFooter) {
                bodyHeight -= $(this.containerSelector).
                        find(".jd-popup-footer").height();
            }

            $(this.containerSelector).
                    find(".jd-popup-body").height(bodyHeight);
        },

        _createFooter : function() {
            var footer = $("<div>").addClass("jd-popup-footer");

            if (this.options.ignoreButton) {
                return footer;
            }

            var oThis = this;

            var buttons = this.options.buttons || [];
            for (var i = 0; i < buttons.length; i ++) {
                var button = buttons[i] || {};
                var jqButton = $("<input type='button'>").val(button.text || "");

                if (button.click) {
                    jqButton.bind("click", {
                        callback: button.click,
                        context : oThis
                    }, function(event) {
                        event.data.callback.
                        	call($(this), event);
                    });
                }

                if (button.btnClass) {
                    jqButton.addClass(button.btnClass);
                }

                footer.append(jqButton)
            }

            return footer;
        },

        // 根据构造函数传入的参数定义该类中常用到的成员变量
        _prepare : function() {
            this.idSelector = SelectorBuilder.
                    buildIdSelector(this.id);

            this.containerId = SelectorBuilder.mergeString(
                    this.options.containerPrefix, this.id);
            if (this.options.ignoreContainer) {
                this.containerId = this.id;
            }
            this.containerSelector = SelectorBuilder.
                    buildIdSelector(this.containerId);

            this.parent = this.options.parent;
            if (this.parent instanceof String
                    && this.parent != "body") {
                this.parent = SelectorBuilder.
                        buildIdSelector(this.parent);
            }
        }
    }

    Dialog.defaultOptions = {
        parent : "body",
        containerPrefix : "jd_popup_container_",
        ignoreContainer : false, //是否忽略添加外部容器
        ignoreFooter : false,
        ignoreButton : false,
        autoClose : false,
        size : {
            width: 600,
            height:500
        },

        popupClass : null,

        zIndex : 1000,
        closeText : "关闭",
        closeCallback : function() { // 支持自定义关闭回调
            this.close();
        },
        buttons : [
            { // ignoreFooter为false有效
                text : "提交",
                click : function(event) {
                    var form = $(this).find("form");
                    if (form) {
                        form.submit();
                    }
                    event.data.context.close();
                }
            },
            {
                text : "取消",
                click : function(event) {
                    var oThis = event.data.context;
                    oThis.close();
                }
            }
        ],
        
        onOpen : function(dialog) {
        	
        },
        
        onClose : function(dialog) {
        	
        }
    }
})(jQuery);


