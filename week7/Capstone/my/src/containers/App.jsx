import React, { Suspense } from 'react';
import { Route, Switch } from 'react-router-dom';
import { withRouter } from 'react-router';

import { AppProvider, AppConsumer, AuthProvider, AuthConsumer } from '../contexts';
import { PublicRoute, Header, Footer, Loading } from '../components';
import Home from './Home';
const About = React.lazy(() => import('./About'));
const Examples = React.lazy(() => import('./Examples'));

const App = () => (
  <AppProvider>
    <AppConsumer>
      {({ appData }) => (
        <AuthProvider>
          <AuthConsumer>
            {({ user, isLoggedIn }) => (
              <main role="main">
                <Header user={user} isLoggedIn={isLoggedIn} appData={appData} />
                <div className="container">
                  <Suspense fallback={<Loading />}>
                    <Switch>
                      <Route path="/" exact render={props => <Home {...props} appData={appData} />} />
                      <PublicRoute path="/about" component={About} />
                      <PublicRoute path="/examples" component={Examples} />
                      <Route path="/unauthorised" render={() => <h1>Unauthorised</h1>} />
                      <Route render={() => <h1>404</h1>} />
                    </Switch>
                  </Suspense>
                </div>
                <Footer content={appData.content} />
              </main>
            )}
          </AuthConsumer>
        </AuthProvider>
      )}
    </AppConsumer>
  </AppProvider>
);
export default withRouter(App);
