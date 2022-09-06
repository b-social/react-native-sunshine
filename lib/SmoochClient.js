'use strict';

var { NativeModules, Platform } = require('react-native');

const LINKING_ERROR =
    `The package 'react-native-sunshine' doesn't seem to be linked. Make sure: \n\n` +
    Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
    '- You rebuilt the app after installing the package\n' +
    '- You are not using Expo managed workflow\n';

const SmoochManager = NativeModules.SmoochManager
    ? NativeModules.SmoochManager
    : new Proxy(
        {},
        {
            get() {
                throw new Error(LINKING_ERROR);
            },
        }
    );

const show = async () => await SmoochManager.show();

const login = async (token) => await SmoochManager.login(token);

const logout = async () => await SmoochManager.logout();

const setFirebaseCloudMessagingToken = async (token) => await SmoochManager.setFirebaseCloudMessagingToken(token);

module.exports = Object.assign({ show, login, logout, setFirebaseCloudMessagingToken }, SmoochManager);