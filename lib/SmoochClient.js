'use strict';

var { NativeModules } = require('react-native');

const { SmoochManager } = NativeModules;

const show = () => {
    return SmoochManager.show();
};

const login = (
    token
) => SmoochManager.login(token);

const logout = () => SmoochManager.logout();

const setFirebaseCloudMessagingToken = (
    token
) => SmoochManager.setFirebaseCloudMessagingToken(token);

module.exports = Object.assign({ setFirebaseCloudMessagingToken, show, login, logout }, SmoochManager);