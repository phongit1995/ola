import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { ClanHomeScreen } from './ClanHomeScreen';
import { ClanScreen } from './ClanScreen';
import { ClanManageScreen } from './ClanManageScreen';
import { ClanMembersScreen } from './ClanMembersScreen';
import { ClanBansScreen } from './ClanBansScreen';

type ClanHomeProps = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.ClanHome>;

export function ClanHomeRouteScreen({ navigation }: ClanHomeProps) {
  return (
    <ClanHomeScreen
      onClose={() => navigation.goBack()}
      onOpenClan={(handle) => navigation.navigate(ROOT_ROUTES.Clan, { handle })}
    />
  );
}

type ClanProps = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.Clan>;

export function ClanRouteScreen({ navigation, route }: ClanProps) {
  const { handle, id } = route.params;
  return (
    <ClanScreen
      key={handle ?? id}
      handle={handle}
      id={id}
      onClose={() => navigation.goBack()}
      onOpenManage={(clanId) => navigation.navigate(ROOT_ROUTES.ClanManage, { clanId })}
      onOpenMembers={(clanId) => navigation.navigate(ROOT_ROUTES.ClanMembers, { clanId })}
    />
  );
}

type ClanManageProps = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.ClanManage>;

export function ClanManageRouteScreen({ navigation, route }: ClanManageProps) {
  return (
    <ClanManageScreen
      clanId={route.params.clanId}
      onClose={() => navigation.goBack()}
      onOpenMembers={(clanId) => navigation.navigate(ROOT_ROUTES.ClanMembers, { clanId })}
      onOpenBans={(clanId) => navigation.navigate(ROOT_ROUTES.ClanBans, { clanId })}
    />
  );
}

type ClanMembersProps = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.ClanMembers>;

export function ClanMembersRouteScreen({ navigation, route }: ClanMembersProps) {
  return <ClanMembersScreen clanId={route.params.clanId} onClose={() => navigation.goBack()} />;
}

type ClanBansProps = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.ClanBans>;

export function ClanBansRouteScreen({ navigation, route }: ClanBansProps) {
  return <ClanBansScreen clanId={route.params.clanId} onClose={() => navigation.goBack()} />;
}
