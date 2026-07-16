import { useTranslation } from 'react-i18next';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { UserProfileScreen } from './UserProfileScreen';

type Props = NativeStackScreenProps<RootStackParamList, 'ProfileView'>;

export function ProfileViewScreen({ navigation, route }: Props) {
  const { userId } = route.params;
  const { i18n } = useTranslation();

  return (
    <UserProfileScreen
      username={userId}
      language={i18n.language}
      onClose={() => navigation.goBack()}
      onOpenProfile={(nick, color) => navigation.push(ROOT_ROUTES.ProfileView, { userId: nick, color })}
      onEditProfile={() => navigation.navigate(ROOT_ROUTES.EditProfile)}
      onMessage={async (uid) => {
        const conversation = await useChatStore.getState().startDirect(uid);
        if (conversation != null && conversation.id !== '') {
          navigation.navigate(ROOT_ROUTES.ChatDetail, { conversationId: conversation.id });
        }
      }}
    />
  );
}
