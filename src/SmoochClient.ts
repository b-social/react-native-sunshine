import { NativeModules, Platform } from 'react-native';

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

const showWithStartingMessage = async (text: string) => await SmoochManager.showWithStartingText(text);

const setCurrentConversationDetails = async (name: string, description: string) => await SmoochManager.setCurrentConversationDetails(name, description)

const login = async (userId: string, token: string) => await SmoochManager.login(userId, token);

const logout = async () => await SmoochManager.logout();

const setFirstName = async (text: string) => await SmoochManager.setFirstName(text);

const setLastName = async (text: string) => await SmoochManager.setLastName(text);

const setFirebaseCloudMessagingToken = async (token: string) => await SmoochManager.setFirebaseCloudMessagingToken(token);

export { show, showConversationList, showWithStartingMessage, setCurrentConversationDetails, login, logout, setFirstName, setLastName, setFirebaseCloudMessagingToken, SmoochManager };
