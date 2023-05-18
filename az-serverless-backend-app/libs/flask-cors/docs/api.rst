API Docs
==========

This package exposes a Flask extension which by default enables CORS support on all routes, for all origins and methods.
It allows parameterization of all CORS headers on a per-resource level. The package also contains a decorator, for those who prefer this approach.

Extension
~~~~~~~~~

This is the suggested approach to enabling CORS.
The default configuration will work well for most use cases.

.. autoclass:: flask_cors.CORS

Decorator
~~~~~~~~~

If the `CORS` extension does not satisfy your needs, you may find the decorator useful.
It shares options with the extension, and should be simple to use.

.. autofunction:: flask_cors.cross_origin


Using `CORS` with cookies
~~~~~~~~~~~~~~~~~~~~~~~~~

By default, Flask-CORS does not allow cookies to be submitted across sites, since it has potential security implications.
If you wish to enable cross-site cookies, you may wish to add some sort of `CSRF <http://en.wikipedia.org/wiki/Cross-site_request_forgery>`__ protection to keep you and your users safe.

To allow cookies or authenticated requests to be made cross origins, simply set the `supports_credentials` option to `True`. E.g.

.. code:: python


    from flask import Flask, session
    from flask_cors import CORS

    app = Flask(__name__)
    CORS(app, supports_credentials=True)

    @app.route("/")
    def helloWorld():
      return "Hello, %s" % session['username']


The above code enables Flask backend to accept cookies to be submitted from cross origin sites.
But if you are sending Xhr requests (ajax calls) to a cross-origin server, by default chrome or any modern browser won't send cookies and session with the request.
You should use ``withCredentials = True`` while sending Xhr request to enable that.
You should keep in mind about the necessary security concerns.
Related MDN doc: https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/withCredentials

Using `CORS` with Blueprints
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Flask-CORS supports blueprints out of the box.
Simply pass a `blueprint` instance to the CORS extension, and everything will just work.

.. literalinclude:: ../examples/blueprints_based_example.py
  :language: python
  :lines: 23-


Examples
~~~~~~~~~

Using the `CORS` extension
^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. literalinclude:: ../examples/app_based_example.py
   :language: python
   :lines: 29-


Using the `cross_origin` decorator
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. literalinclude:: ../examples/view_based_example.py
   :language: python
   :lines: 27-
