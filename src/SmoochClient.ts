import { NativeModules, Platform }  from 'react-native';

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

const showConversationList = async () => await SmoochManager.showConversationList();

const showWithStartingMessage = async () => await SmoochManager.showWithStartingText();

const login = async (userId: string, token: string) => await SmoochManager.login(userId, token);

const logout = async () => await SmoochManager.logout();

const setFirebaseCloudMessagingToken = async (token: string) => await SmoochManager.setFirebaseCloudMessagingToken(token);

export { show, showConversationList, showWithStartingMessage, login, logout, setFirebaseCloudMessagingToken, SmoochManager };
