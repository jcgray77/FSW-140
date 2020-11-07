import './styles/index.scss';

import * as moment from 'moment';
// Add more locales
import '../node_modules/moment/locale/en-gb';
moment.locale(['en-GB']);

import React from 'react';
import ReactDOM from 'react-dom';
import { Router } from 'react-router-dom';
import * as serviceWorker from './serviceWorker';
import App from './containers/App';
import { history } from './services';

// Post logout redirect logic*-+9/
if (window.location.href.indexOf('?postLogout=true') > 0) {
  const { AuthService } = require('./services/auth.service');
  var authService = new AuthService();
  authService.signoutRedirectCallback().then(() => {
    // clear the query string
    history.push('/', '');
  });
}

function render() {
  ReactDOM[window.ssrEnabled ? 'hydrate' : 'render'](
    <Router history={history}>
      <App />
    </Router>,
    document.getElementById('app')
  );
}

render();

if (module.hot) {
  module.hot.accept('./containers/App', () => {
    const NextApp = require('./containers/App');
    console.clear();
    render(NextApp);
  });
}